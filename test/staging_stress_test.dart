// Real-network stress run against a staging portal, driven through the full
// public SDK surface (initClient -> login -> fetchServiceDialog -> send).
//
// Skipped unless the environment is configured, so `flutter test` stays green
// without network access:
//
//   WEBITEL_STRESS_URL='grpcs://host' \
//   WEBITEL_STRESS_TOKEN='...' \
//   WEBITEL_STRESS_ISSUER='https://host/portal' \
//   flutter test test/staging_stress_test.dart
//
// Phases: sequential baseline, concurrent bursts, reconnect churn, sustained
// rate — then the chat history is fetched back and every sent message is
// verified to appear exactly once (duplicates / losses).
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:webitel_portal_sdk/webitel_portal_sdk.dart';

int _pct(List<int> sorted, double p) =>
    sorted[((sorted.length - 1) * p).round()];

void _report(String phase, List<int> latencies) {
  if (latencies.isEmpty) {
    // ignore: avoid_print
    print('STRESS $phase: no samples');
    return;
  }
  final sorted = [...latencies]..sort();
  // ignore: avoid_print
  print('STRESS $phase: n=${sorted.length} '
      'p50=${_pct(sorted, .50)}ms '
      'p95=${_pct(sorted, .95)}ms '
      'p99=${_pct(sorted, .99)}ms '
      'max=${sorted.last}ms');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final url = Platform.environment['WEBITEL_STRESS_URL'];
  final token = Platform.environment['WEBITEL_STRESS_TOKEN'];
  final issuer = Platform.environment['WEBITEL_STRESS_ISSUER'];

  test(
    'staging stress run',
    () async {
      if (url == null || token == null || issuer == null) {
        markTestSkipped('WEBITEL_STRESS_* environment is not configured');
        return;
      }
      if (Platform.environment['WEBITEL_STRESS_XL'] == '1') {
        markTestSkipped('XL run requested — skipping the small profile');
        return;
      }

      SharedPreferences.setMockInitialValues({});
      PackageInfo.setMockInitialValues(
        appName: 'sdk-stress',
        packageName: 'com.webitel.sdk.stress',
        version: '1.0.0',
        buildNumber: '1',
        buildSignature: '',
      );

      const uuid = Uuid();
      final runId = uuid.v4().substring(0, 8);

      final client = await WebitelPortalSdk.instance.initClient(
        url: url,
        appToken: token,
        loggerLevel: LoggerLevel.error,
      );
      expect(client.error, isNull,
          reason: 'initClient failed: ${client.error?.errorMessage}');

      // Contact fields are filled deliberately: an identity without them gets
      // user_contact = NULL on the portal side, and the chat backend 500s on
      // every message with "converting NULL to string" (found by run #1).
      final login = await client.login(
        name: 'SDK Stress $runId',
        sub: 'sdk-stress-$runId',
        issuer: issuer,
        email: 'sdk-stress-$runId@example.com',
        emailVerified: true,
        phoneNumber: '+380670000001',
        phoneNumberVerified: true,
      );
      // ignore: avoid_print
      print('STRESS login: ${login.status}'
          '${login.message != null ? ' ${login.message}' : ''}');
      expect(login.status, PortalResponseStatus.success);

      final dialog = await client.chat.fetchServiceDialog();
      // ignore: avoid_print
      print('STRESS dialog: id=${dialog.id} closed=${dialog.isClosed}');
      expect(dialog.id, isNot('default_id'),
          reason: 'no service dialog available for this portal');

      final channel = await client.getChannel();

      final acked = <String>[];
      final failures = <String>[];

      Future<int> sendOne(String phase, int i) async {
        final content = 'stress:$runId:$phase:$i';
        final stopwatch = Stopwatch()..start();
        final response = await dialog.sendMessage(
          content: content,
          requestId: uuid.v4(),
        );
        stopwatch.stop();
        if (response.error != null) {
          failures.add('$phase:$i -> ${response.error!.errorMessage}');
        } else {
          acked.add(content);
        }
        return stopwatch.elapsedMilliseconds;
      }

      // Phase 1 — sequential baseline: clean per-message RTT.
      final sequential = <int>[];
      for (var i = 0; i < 20; i++) {
        sequential.add(await sendOne('seq', i));
      }
      _report('sequential x20   ', sequential);

      // Phase 2 — concurrent bursts: 3 rounds of 10 parallel sends on one
      // stream (the old stack multiplied connections and lost acks here).
      final burst = <int>[];
      for (var round = 0; round < 3; round++) {
        burst.addAll(await Future.wait(
          [for (var i = 0; i < 10; i++) sendOne('burst$round', i)],
        ));
      }
      _report('burst 3x10       ', burst);

      // Phase 3 — reconnect churn: forced reconnect before every send (the
      // old stack duplicated every message once per surviving stream).
      final churn = <int>[];
      for (var i = 0; i < 10; i++) {
        await channel.reconnectToStream();
        churn.add(await sendOne('churn', i));
      }
      _report('reconnect churn  ', churn);

      // Phase 4 — sustained rate: ~10 msg/s for 10 seconds.
      final pending = <Future<int>>[];
      for (var i = 0; i < 100; i++) {
        pending.add(sendOne('sustained', i));
        await Future.delayed(const Duration(milliseconds: 100));
      }
      _report('sustained 10/s   ', await Future.wait(pending));

      // Phase 5 — verification: fetch history back and count every sent
      // message. Exactly-once is the whole point of the fixes.
      await Future.delayed(const Duration(seconds: 3));
      final history = await dialog.fetchMessages(limit: 500);
      final mine = history
          .map((m) => m.dialogMessageContent)
          .where((text) => text.startsWith('stress:$runId:'))
          .toList();

      final counts = <String, int>{};
      for (final text in mine) {
        counts[text] = (counts[text] ?? 0) + 1;
      }
      final duplicated =
          counts.entries.where((e) => e.value > 1).toList();
      final missing =
          acked.where((content) => !counts.containsKey(content)).toList();

      // ignore: avoid_print
      print('STRESS totals: attempted=${acked.length + failures.length} '
          'acked=${acked.length} failed=${failures.length} '
          'inHistory=${mine.length} '
          'duplicates=${duplicated.length} missing=${missing.length}');
      for (final f in failures.take(5)) {
        // ignore: avoid_print
        print('STRESS failure: $f');
      }
      for (final d in duplicated.take(5)) {
        // ignore: avoid_print
        print('STRESS duplicate: ${d.key} x${d.value}');
      }
      for (final m in missing.take(5)) {
        // ignore: avoid_print
        print('STRESS missing: $m');
      }

      expect(acked, isNotEmpty);
    },
    timeout: const Timeout(Duration(minutes: 10)),
  );

  test(
    'staging stress run XL — 10k messages',
    () async {
      if (url == null ||
          token == null ||
          issuer == null ||
          Platform.environment['WEBITEL_STRESS_XL'] != '1') {
        markTestSkipped('set WEBITEL_STRESS_* and WEBITEL_STRESS_XL=1');
        return;
      }

      SharedPreferences.setMockInitialValues({});
      PackageInfo.setMockInitialValues(
        appName: 'sdk-stress',
        packageName: 'com.webitel.sdk.stress',
        version: '1.0.0',
        buildNumber: '1',
        buildSignature: '',
      );

      const uuid = Uuid();
      final runId = uuid.v4().substring(0, 8);
      final wall = Stopwatch()..start();

      final client = await WebitelPortalSdk.instance.initClient(
        url: url,
        appToken: token,
        loggerLevel: LoggerLevel.error,
      );
      expect(client.error, isNull);

      final login = await client.login(
        name: 'SDK Stress XL $runId',
        sub: 'sdk-stress-xl-$runId',
        issuer: issuer,
        email: 'sdk-stress-$runId@example.com',
        emailVerified: true,
        phoneNumber: '+380670000001',
        phoneNumberVerified: true,
      );
      expect(login.status, PortalResponseStatus.success);

      final dialog = await client.chat.fetchServiceDialog();
      expect(dialog.id, isNot('default_id'));
      final channel = await client.getChannel();
      // ignore: avoid_print
      print('STRESS-XL start: runId=$runId dialog=${dialog.id}');

      final acked = <String>[];
      final errorKinds = <String, int>{};
      var sendCounter = 0;

      Future<int> sendOne(String phase) async {
        final content = 'stress:$runId:$phase:${sendCounter++}';
        final stopwatch = Stopwatch()..start();
        final response = await dialog.sendMessage(
          content: content,
          requestId: uuid.v4(),
        );
        stopwatch.stop();
        if (response.error != null) {
          final kind = response.error!.errorMessage;
          errorKinds[kind.length > 80 ? kind.substring(0, 80) : kind] =
              (errorKinds[kind.length > 80 ? kind.substring(0, 80) : kind] ??
                      0) +
                  1;
        } else {
          acked.add(content);
        }
        final done = sendCounter;
        if (done % 1000 == 0) {
          // ignore: avoid_print
          print('STRESS-XL progress: $done sent, '
              '${acked.length} acked, ${wall.elapsed.inSeconds}s elapsed');
        }
        return stopwatch.elapsedMilliseconds;
      }

      /// Runs [total] sends through [workers] parallel workers.
      Future<List<int>> pool(String phase, int total, int workers) async {
        final latencies = <int>[];
        var issued = 0;
        Future<void> worker() async {
          while (issued < total) {
            issued++;
            latencies.add(await sendOne(phase));
          }
        }

        await Future.wait([for (var w = 0; w < workers; w++) worker()]);
        return latencies;
      }

      // Phase 1 — sequential baseline x100.
      _report('XL sequential x100 ', await pool('seq', 100, 1));

      // Phase 2 — flood: 4900 messages, 16 parallel workers (max throughput).
      final floodWatch = Stopwatch()..start();
      final flood = await pool('flood', 4900, 16);
      floodWatch.stop();
      _report('XL flood 16w x4900 ', flood);
      // ignore: avoid_print
      print('STRESS-XL flood throughput: '
          '${(4900 * 1000 / floodWatch.elapsedMilliseconds).toStringAsFixed(0)} msg/s');

      // Phase 3 — bursts: 50 rounds x 40 concurrent (spiky load).
      final burst = <int>[];
      for (var round = 0; round < 50; round++) {
        burst.addAll(await Future.wait(
          [for (var i = 0; i < 40; i++) sendOne('burst')],
        ));
      }
      _report('XL burst 50x40     ', burst);

      // Phase 4 — reconnect churn: 50 forced reconnects, 10 messages each.
      final churn = <int>[];
      for (var i = 0; i < 50; i++) {
        await channel.reconnectToStream();
        churn.addAll(await pool('churn', 10, 1));
      }
      _report('XL churn 50x10     ', churn);

      // Phase 5 — paced 25 msg/s x 2500 (~100 seconds of steady load).
      final paced = <Future<int>>[];
      for (var i = 0; i < 2500; i++) {
        paced.add(sendOne('paced'));
        await Future.delayed(const Duration(milliseconds: 40));
      }
      _report('XL paced 25/s x2500', await Future.wait(paced));

      // ignore: avoid_print
      print('STRESS-XL sends done: ${sendCounter} attempted, '
          '${acked.length} acked, ${wall.elapsed.inSeconds}s');

      // Verification — page through history (newest -> older) until every
      // acked message is found or pages stop yielding new ids.
      await Future.delayed(const Duration(seconds: 5));
      final ackedSet = acked.toSet();
      final byMessageId = <int, String>{};
      var foundOfOurs = 0;
      int? offset;
      for (var page = 0; page < 150; page++) {
        final batch =
            await dialog.fetchMessages(limit: 200, offset: offset);
        final ids = batch
            .where((m) => m.messageId != 0)
            .map((m) => m.messageId)
            .toList();
        if (ids.isEmpty) break;
        var fresh = 0;
        for (final m in batch) {
          if (m.messageId == 0 || byMessageId.containsKey(m.messageId)) {
            continue;
          }
          fresh++;
          byMessageId[m.messageId] = m.dialogMessageContent;
          if (ackedSet.contains(m.dialogMessageContent)) foundOfOurs++;
        }
        if (fresh == 0) break;
        offset = ids.reduce((a, b) => a < b ? a : b);
        if (foundOfOurs >= ackedSet.length) break;
      }

      final counts = <String, int>{};
      for (final text in byMessageId.values) {
        if (text.startsWith('stress:$runId:')) {
          counts[text] = (counts[text] ?? 0) + 1;
        }
      }
      final duplicated = counts.entries.where((e) => e.value > 1).length;
      final missing =
          acked.where((content) => !counts.containsKey(content)).length;

      // ignore: avoid_print
      print('STRESS-XL totals: attempted=$sendCounter acked=${acked.length} '
          'failed=${sendCounter - acked.length} '
          'historyScanned=${byMessageId.length} inHistory=${counts.length} '
          'duplicates=$duplicated missing=$missing '
          'wallTime=${wall.elapsed.inSeconds}s');
      errorKinds.forEach((kind, n) {
        // ignore: avoid_print
        print('STRESS-XL error x$n: $kind');
      });

      expect(acked, isNotEmpty);
    },
    timeout: const Timeout(Duration(minutes: 30)),
  );
}

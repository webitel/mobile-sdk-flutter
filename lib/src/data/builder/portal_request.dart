import 'package:protobuf/well_known_types/google/protobuf/any.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/connect.pb.dart'
    as portal;

final class PortalRequestBuilder {
  late String path;
  late Any data;
  late String id;

  PortalRequestBuilder setPath(String path) {
    this.path = path;
    return this;
  }

  PortalRequestBuilder setData(Any data) {
    this.data = data;
    return this;
  }

  PortalRequestBuilder setId(String id) {
    this.id = id;
    return this;
  }

  portal.Request build() {
    return portal.Request()
      ..path = path
      ..data = data
      ..id = id;
  }
}

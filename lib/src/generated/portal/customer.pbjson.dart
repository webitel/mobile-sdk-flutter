// This is a generated file - do not edit.
//
// Generated from portal/customer.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use inspectRequestDescriptor instead')
const InspectRequest$json = {
  '1': 'InspectRequest',
};

/// Descriptor for `InspectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inspectRequestDescriptor =
    $convert.base64Decode('Cg5JbnNwZWN0UmVxdWVzdA==');

@$core.Deprecated('Use logoutRequestDescriptor instead')
const LogoutRequest$json = {
  '1': 'LogoutRequest',
};

/// Descriptor for `LogoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutRequestDescriptor =
    $convert.base64Decode('Cg1Mb2dvdXRSZXF1ZXN0');

@$core.Deprecated('Use registerDeviceRequestDescriptor instead')
const RegisterDeviceRequest$json = {
  '1': 'RegisterDeviceRequest',
  '2': [
    {
      '1': 'push',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.DevicePush',
      '10': 'push'
    },
  ],
};

/// Descriptor for `RegisterDeviceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerDeviceRequestDescriptor = $convert.base64Decode(
    'ChVSZWdpc3RlckRldmljZVJlcXVlc3QSLgoEcHVzaBgBIAEoCzIaLndlYml0ZWwucG9ydGFsLk'
    'RldmljZVB1c2hSBHB1c2g=');

@$core.Deprecated('Use registerDeviceResponseDescriptor instead')
const RegisterDeviceResponse$json = {
  '1': 'RegisterDeviceResponse',
};

/// Descriptor for `RegisterDeviceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerDeviceResponseDescriptor =
    $convert.base64Decode('ChZSZWdpc3RlckRldmljZVJlc3BvbnNl');

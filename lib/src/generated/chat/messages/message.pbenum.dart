// This is a generated file - do not edit.
//
// Generated from chat/messages/message.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Type of request to share contact info
class Button_Request extends $pb.ProtobufEnum {
  /// Phone Number
  static const Button_Request phone =
      Button_Request._(0, _omitEnumNames ? '' : 'phone');

  /// Email Address
  static const Button_Request email =
      Button_Request._(1, _omitEnumNames ? '' : 'email');

  /// General Form
  static const Button_Request contact =
      Button_Request._(2, _omitEnumNames ? '' : 'contact');

  /// Current Location
  static const Button_Request location =
      Button_Request._(3, _omitEnumNames ? '' : 'location');

  static const $core.List<Button_Request> values = <Button_Request>[
    phone,
    email,
    contact,
    location,
  ];

  static final $core.List<Button_Request?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static Button_Request? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Button_Request._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');

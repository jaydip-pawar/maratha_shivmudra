// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ol_initiate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OLInitiateModel _$OLInitiateModelFromJson(Map<String, dynamic> json) {
  return _OLInitiateModel.fromJson(json);
}

/// @nodoc
mixin _$OLInitiateModel {
  String get responseType => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  InitiateResponse get response => throw _privateConstructorUsedError;

  /// Serializes this OLInitiateModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OLInitiateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OLInitiateModelCopyWith<OLInitiateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OLInitiateModelCopyWith<$Res> {
  factory $OLInitiateModelCopyWith(
          OLInitiateModel value, $Res Function(OLInitiateModel) then) =
      _$OLInitiateModelCopyWithImpl<$Res, OLInitiateModel>;
  @useResult
  $Res call(
      {String responseType,
      bool success,
      int statusCode,
      InitiateResponse response});

  $InitiateResponseCopyWith<$Res> get response;
}

/// @nodoc
class _$OLInitiateModelCopyWithImpl<$Res, $Val extends OLInitiateModel>
    implements $OLInitiateModelCopyWith<$Res> {
  _$OLInitiateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OLInitiateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responseType = null,
    Object? success = null,
    Object? statusCode = null,
    Object? response = null,
  }) {
    return _then(_value.copyWith(
      responseType: null == responseType
          ? _value.responseType
          : responseType // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as InitiateResponse,
    ) as $Val);
  }

  /// Create a copy of OLInitiateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InitiateResponseCopyWith<$Res> get response {
    return $InitiateResponseCopyWith<$Res>(_value.response, (value) {
      return _then(_value.copyWith(response: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OLInitiateModelImplCopyWith<$Res>
    implements $OLInitiateModelCopyWith<$Res> {
  factory _$$OLInitiateModelImplCopyWith(_$OLInitiateModelImpl value,
          $Res Function(_$OLInitiateModelImpl) then) =
      __$$OLInitiateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String responseType,
      bool success,
      int statusCode,
      InitiateResponse response});

  @override
  $InitiateResponseCopyWith<$Res> get response;
}

/// @nodoc
class __$$OLInitiateModelImplCopyWithImpl<$Res>
    extends _$OLInitiateModelCopyWithImpl<$Res, _$OLInitiateModelImpl>
    implements _$$OLInitiateModelImplCopyWith<$Res> {
  __$$OLInitiateModelImplCopyWithImpl(
      _$OLInitiateModelImpl _value, $Res Function(_$OLInitiateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of OLInitiateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responseType = null,
    Object? success = null,
    Object? statusCode = null,
    Object? response = null,
  }) {
    return _then(_$OLInitiateModelImpl(
      responseType: null == responseType
          ? _value.responseType
          : responseType // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as InitiateResponse,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OLInitiateModelImpl implements _OLInitiateModel {
  const _$OLInitiateModelImpl(
      {required this.responseType,
      required this.success,
      required this.statusCode,
      required this.response});

  factory _$OLInitiateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OLInitiateModelImplFromJson(json);

  @override
  final String responseType;
  @override
  final bool success;
  @override
  final int statusCode;
  @override
  final InitiateResponse response;

  @override
  String toString() {
    return 'OLInitiateModel(responseType: $responseType, success: $success, statusCode: $statusCode, response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OLInitiateModelImpl &&
            (identical(other.responseType, responseType) ||
                other.responseType == responseType) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, responseType, success, statusCode, response);

  /// Create a copy of OLInitiateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OLInitiateModelImplCopyWith<_$OLInitiateModelImpl> get copyWith =>
      __$$OLInitiateModelImplCopyWithImpl<_$OLInitiateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OLInitiateModelImplToJson(
      this,
    );
  }
}

abstract class _OLInitiateModel implements OLInitiateModel {
  const factory _OLInitiateModel(
      {required final String responseType,
      required final bool success,
      required final int statusCode,
      required final InitiateResponse response}) = _$OLInitiateModelImpl;

  factory _OLInitiateModel.fromJson(Map<String, dynamic> json) =
      _$OLInitiateModelImpl.fromJson;

  @override
  String get responseType;
  @override
  bool get success;
  @override
  int get statusCode;
  @override
  InitiateResponse get response;

  /// Create a copy of OLInitiateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OLInitiateModelImplCopyWith<_$OLInitiateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InitiateResponse _$InitiateResponseFromJson(Map<String, dynamic> json) {
  return _InitiateResponse.fromJson(json);
}

/// @nodoc
mixin _$InitiateResponse {
  String? get requestID => throw _privateConstructorUsedError;
  String? get verification => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  List<String>? get deliveryChannel => throw _privateConstructorUsedError;
  String? get authType => throw _privateConstructorUsedError;
  String? get channel => throw _privateConstructorUsedError;

  /// Serializes this InitiateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InitiateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InitiateResponseCopyWith<InitiateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InitiateResponseCopyWith<$Res> {
  factory $InitiateResponseCopyWith(
          InitiateResponse value, $Res Function(InitiateResponse) then) =
      _$InitiateResponseCopyWithImpl<$Res, InitiateResponse>;
  @useResult
  $Res call(
      {String? requestID,
      String? verification,
      String? errorMessage,
      List<String>? deliveryChannel,
      String? authType,
      String? channel});
}

/// @nodoc
class _$InitiateResponseCopyWithImpl<$Res, $Val extends InitiateResponse>
    implements $InitiateResponseCopyWith<$Res> {
  _$InitiateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InitiateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestID = freezed,
    Object? verification = freezed,
    Object? errorMessage = freezed,
    Object? deliveryChannel = freezed,
    Object? authType = freezed,
    Object? channel = freezed,
  }) {
    return _then(_value.copyWith(
      requestID: freezed == requestID
          ? _value.requestID
          : requestID // ignore: cast_nullable_to_non_nullable
              as String?,
      verification: freezed == verification
          ? _value.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryChannel: freezed == deliveryChannel
          ? _value.deliveryChannel
          : deliveryChannel // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      authType: freezed == authType
          ? _value.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as String?,
      channel: freezed == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitiateResponseImplCopyWith<$Res>
    implements $InitiateResponseCopyWith<$Res> {
  factory _$$InitiateResponseImplCopyWith(_$InitiateResponseImpl value,
          $Res Function(_$InitiateResponseImpl) then) =
      __$$InitiateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? requestID,
      String? verification,
      String? errorMessage,
      List<String>? deliveryChannel,
      String? authType,
      String? channel});
}

/// @nodoc
class __$$InitiateResponseImplCopyWithImpl<$Res>
    extends _$InitiateResponseCopyWithImpl<$Res, _$InitiateResponseImpl>
    implements _$$InitiateResponseImplCopyWith<$Res> {
  __$$InitiateResponseImplCopyWithImpl(_$InitiateResponseImpl _value,
      $Res Function(_$InitiateResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of InitiateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestID = freezed,
    Object? verification = freezed,
    Object? errorMessage = freezed,
    Object? deliveryChannel = freezed,
    Object? authType = freezed,
    Object? channel = freezed,
  }) {
    return _then(_$InitiateResponseImpl(
      requestID: freezed == requestID
          ? _value.requestID
          : requestID // ignore: cast_nullable_to_non_nullable
              as String?,
      verification: freezed == verification
          ? _value.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryChannel: freezed == deliveryChannel
          ? _value._deliveryChannel
          : deliveryChannel // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      authType: freezed == authType
          ? _value.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as String?,
      channel: freezed == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InitiateResponseImpl implements _InitiateResponse {
  const _$InitiateResponseImpl(
      {this.requestID,
      this.verification,
      this.errorMessage,
      final List<String>? deliveryChannel,
      this.authType,
      this.channel})
      : _deliveryChannel = deliveryChannel;

  factory _$InitiateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$InitiateResponseImplFromJson(json);

  @override
  final String? requestID;
  @override
  final String? verification;
  @override
  final String? errorMessage;
  final List<String>? _deliveryChannel;
  @override
  List<String>? get deliveryChannel {
    final value = _deliveryChannel;
    if (value == null) return null;
    if (_deliveryChannel is EqualUnmodifiableListView) return _deliveryChannel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? authType;
  @override
  final String? channel;

  @override
  String toString() {
    return 'InitiateResponse(requestID: $requestID, verification: $verification, errorMessage: $errorMessage, deliveryChannel: $deliveryChannel, authType: $authType, channel: $channel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitiateResponseImpl &&
            (identical(other.requestID, requestID) ||
                other.requestID == requestID) &&
            (identical(other.verification, verification) ||
                other.verification == verification) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality()
                .equals(other._deliveryChannel, _deliveryChannel) &&
            (identical(other.authType, authType) ||
                other.authType == authType) &&
            (identical(other.channel, channel) || other.channel == channel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      requestID,
      verification,
      errorMessage,
      const DeepCollectionEquality().hash(_deliveryChannel),
      authType,
      channel);

  /// Create a copy of InitiateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitiateResponseImplCopyWith<_$InitiateResponseImpl> get copyWith =>
      __$$InitiateResponseImplCopyWithImpl<_$InitiateResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InitiateResponseImplToJson(
      this,
    );
  }
}

abstract class _InitiateResponse implements InitiateResponse {
  const factory _InitiateResponse(
      {final String? requestID,
      final String? verification,
      final String? errorMessage,
      final List<String>? deliveryChannel,
      final String? authType,
      final String? channel}) = _$InitiateResponseImpl;

  factory _InitiateResponse.fromJson(Map<String, dynamic> json) =
      _$InitiateResponseImpl.fromJson;

  @override
  String? get requestID;
  @override
  String? get verification;
  @override
  String? get errorMessage;
  @override
  List<String>? get deliveryChannel;
  @override
  String? get authType;
  @override
  String? get channel;

  /// Create a copy of InitiateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitiateResponseImplCopyWith<_$InitiateResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ol_initiate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OLInitiateModel {
  String get responseType;
  bool get success;
  int get statusCode;
  InitiateResponse get response;

  /// Create a copy of OLInitiateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OLInitiateModelCopyWith<OLInitiateModel> get copyWith =>
      _$OLInitiateModelCopyWithImpl<OLInitiateModel>(
          this as OLInitiateModel, _$identity);

  /// Serializes this OLInitiateModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OLInitiateModel &&
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

  @override
  String toString() {
    return 'OLInitiateModel(responseType: $responseType, success: $success, statusCode: $statusCode, response: $response)';
  }
}

/// @nodoc
abstract mixin class $OLInitiateModelCopyWith<$Res> {
  factory $OLInitiateModelCopyWith(
          OLInitiateModel value, $Res Function(OLInitiateModel) _then) =
      _$OLInitiateModelCopyWithImpl;
  @useResult
  $Res call(
      {String responseType,
      bool success,
      int statusCode,
      InitiateResponse response});

  $InitiateResponseCopyWith<$Res> get response;
}

/// @nodoc
class _$OLInitiateModelCopyWithImpl<$Res>
    implements $OLInitiateModelCopyWith<$Res> {
  _$OLInitiateModelCopyWithImpl(this._self, this._then);

  final OLInitiateModel _self;
  final $Res Function(OLInitiateModel) _then;

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
    return _then(_self.copyWith(
      responseType: null == responseType
          ? _self.responseType
          : responseType // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      statusCode: null == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      response: null == response
          ? _self.response
          : response // ignore: cast_nullable_to_non_nullable
              as InitiateResponse,
    ));
  }

  /// Create a copy of OLInitiateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InitiateResponseCopyWith<$Res> get response {
    return $InitiateResponseCopyWith<$Res>(_self.response, (value) {
      return _then(_self.copyWith(response: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _OLInitiateModel implements OLInitiateModel {
  const _OLInitiateModel(
      {required this.responseType,
      required this.success,
      required this.statusCode,
      required this.response});
  factory _OLInitiateModel.fromJson(Map<String, dynamic> json) =>
      _$OLInitiateModelFromJson(json);

  @override
  final String responseType;
  @override
  final bool success;
  @override
  final int statusCode;
  @override
  final InitiateResponse response;

  /// Create a copy of OLInitiateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OLInitiateModelCopyWith<_OLInitiateModel> get copyWith =>
      __$OLInitiateModelCopyWithImpl<_OLInitiateModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OLInitiateModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OLInitiateModel &&
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

  @override
  String toString() {
    return 'OLInitiateModel(responseType: $responseType, success: $success, statusCode: $statusCode, response: $response)';
  }
}

/// @nodoc
abstract mixin class _$OLInitiateModelCopyWith<$Res>
    implements $OLInitiateModelCopyWith<$Res> {
  factory _$OLInitiateModelCopyWith(
          _OLInitiateModel value, $Res Function(_OLInitiateModel) _then) =
      __$OLInitiateModelCopyWithImpl;
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
class __$OLInitiateModelCopyWithImpl<$Res>
    implements _$OLInitiateModelCopyWith<$Res> {
  __$OLInitiateModelCopyWithImpl(this._self, this._then);

  final _OLInitiateModel _self;
  final $Res Function(_OLInitiateModel) _then;

  /// Create a copy of OLInitiateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? responseType = null,
    Object? success = null,
    Object? statusCode = null,
    Object? response = null,
  }) {
    return _then(_OLInitiateModel(
      responseType: null == responseType
          ? _self.responseType
          : responseType // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      statusCode: null == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      response: null == response
          ? _self.response
          : response // ignore: cast_nullable_to_non_nullable
              as InitiateResponse,
    ));
  }

  /// Create a copy of OLInitiateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InitiateResponseCopyWith<$Res> get response {
    return $InitiateResponseCopyWith<$Res>(_self.response, (value) {
      return _then(_self.copyWith(response: value));
    });
  }
}

/// @nodoc
mixin _$InitiateResponse {
  String? get requestID;
  String? get verification;
  String? get errorMessage;
  List<String>? get deliveryChannel;
  String? get authType;
  String? get channel;

  /// Create a copy of InitiateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InitiateResponseCopyWith<InitiateResponse> get copyWith =>
      _$InitiateResponseCopyWithImpl<InitiateResponse>(
          this as InitiateResponse, _$identity);

  /// Serializes this InitiateResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InitiateResponse &&
            (identical(other.requestID, requestID) ||
                other.requestID == requestID) &&
            (identical(other.verification, verification) ||
                other.verification == verification) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality()
                .equals(other.deliveryChannel, deliveryChannel) &&
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
      const DeepCollectionEquality().hash(deliveryChannel),
      authType,
      channel);

  @override
  String toString() {
    return 'InitiateResponse(requestID: $requestID, verification: $verification, errorMessage: $errorMessage, deliveryChannel: $deliveryChannel, authType: $authType, channel: $channel)';
  }
}

/// @nodoc
abstract mixin class $InitiateResponseCopyWith<$Res> {
  factory $InitiateResponseCopyWith(
          InitiateResponse value, $Res Function(InitiateResponse) _then) =
      _$InitiateResponseCopyWithImpl;
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
class _$InitiateResponseCopyWithImpl<$Res>
    implements $InitiateResponseCopyWith<$Res> {
  _$InitiateResponseCopyWithImpl(this._self, this._then);

  final InitiateResponse _self;
  final $Res Function(InitiateResponse) _then;

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
    return _then(_self.copyWith(
      requestID: freezed == requestID
          ? _self.requestID
          : requestID // ignore: cast_nullable_to_non_nullable
              as String?,
      verification: freezed == verification
          ? _self.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryChannel: freezed == deliveryChannel
          ? _self.deliveryChannel
          : deliveryChannel // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      authType: freezed == authType
          ? _self.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as String?,
      channel: freezed == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _InitiateResponse implements InitiateResponse {
  const _InitiateResponse(
      {this.requestID,
      this.verification,
      this.errorMessage,
      final List<String>? deliveryChannel,
      this.authType,
      this.channel})
      : _deliveryChannel = deliveryChannel;
  factory _InitiateResponse.fromJson(Map<String, dynamic> json) =>
      _$InitiateResponseFromJson(json);

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

  /// Create a copy of InitiateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InitiateResponseCopyWith<_InitiateResponse> get copyWith =>
      __$InitiateResponseCopyWithImpl<_InitiateResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InitiateResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InitiateResponse &&
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

  @override
  String toString() {
    return 'InitiateResponse(requestID: $requestID, verification: $verification, errorMessage: $errorMessage, deliveryChannel: $deliveryChannel, authType: $authType, channel: $channel)';
  }
}

/// @nodoc
abstract mixin class _$InitiateResponseCopyWith<$Res>
    implements $InitiateResponseCopyWith<$Res> {
  factory _$InitiateResponseCopyWith(
          _InitiateResponse value, $Res Function(_InitiateResponse) _then) =
      __$InitiateResponseCopyWithImpl;
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
class __$InitiateResponseCopyWithImpl<$Res>
    implements _$InitiateResponseCopyWith<$Res> {
  __$InitiateResponseCopyWithImpl(this._self, this._then);

  final _InitiateResponse _self;
  final $Res Function(_InitiateResponse) _then;

  /// Create a copy of InitiateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? requestID = freezed,
    Object? verification = freezed,
    Object? errorMessage = freezed,
    Object? deliveryChannel = freezed,
    Object? authType = freezed,
    Object? channel = freezed,
  }) {
    return _then(_InitiateResponse(
      requestID: freezed == requestID
          ? _self.requestID
          : requestID // ignore: cast_nullable_to_non_nullable
              as String?,
      verification: freezed == verification
          ? _self.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryChannel: freezed == deliveryChannel
          ? _self._deliveryChannel
          : deliveryChannel // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      authType: freezed == authType
          ? _self.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as String?,
      channel: freezed == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on

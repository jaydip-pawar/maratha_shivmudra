// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ol_verified_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OLVerifiedModel _$OLVerifiedModelFromJson(Map<String, dynamic> json) {
  return _OLVerifiedModel.fromJson(json);
}

/// @nodoc
mixin _$OLVerifiedModel {
  String get responseType => throw _privateConstructorUsedError;
  VerifiedResponse get response => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;

  /// Serializes this OLVerifiedModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OLVerifiedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OLVerifiedModelCopyWith<OLVerifiedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OLVerifiedModelCopyWith<$Res> {
  factory $OLVerifiedModelCopyWith(
          OLVerifiedModel value, $Res Function(OLVerifiedModel) then) =
      _$OLVerifiedModelCopyWithImpl<$Res, OLVerifiedModel>;
  @useResult
  $Res call(
      {String responseType,
      VerifiedResponse response,
      int statusCode,
      bool success});

  $VerifiedResponseCopyWith<$Res> get response;
}

/// @nodoc
class _$OLVerifiedModelCopyWithImpl<$Res, $Val extends OLVerifiedModel>
    implements $OLVerifiedModelCopyWith<$Res> {
  _$OLVerifiedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OLVerifiedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responseType = null,
    Object? response = null,
    Object? statusCode = null,
    Object? success = null,
  }) {
    return _then(_value.copyWith(
      responseType: null == responseType
          ? _value.responseType
          : responseType // ignore: cast_nullable_to_non_nullable
              as String,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as VerifiedResponse,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of OLVerifiedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VerifiedResponseCopyWith<$Res> get response {
    return $VerifiedResponseCopyWith<$Res>(_value.response, (value) {
      return _then(_value.copyWith(response: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OLVerifiedModelImplCopyWith<$Res>
    implements $OLVerifiedModelCopyWith<$Res> {
  factory _$$OLVerifiedModelImplCopyWith(_$OLVerifiedModelImpl value,
          $Res Function(_$OLVerifiedModelImpl) then) =
      __$$OLVerifiedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String responseType,
      VerifiedResponse response,
      int statusCode,
      bool success});

  @override
  $VerifiedResponseCopyWith<$Res> get response;
}

/// @nodoc
class __$$OLVerifiedModelImplCopyWithImpl<$Res>
    extends _$OLVerifiedModelCopyWithImpl<$Res, _$OLVerifiedModelImpl>
    implements _$$OLVerifiedModelImplCopyWith<$Res> {
  __$$OLVerifiedModelImplCopyWithImpl(
      _$OLVerifiedModelImpl _value, $Res Function(_$OLVerifiedModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of OLVerifiedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responseType = null,
    Object? response = null,
    Object? statusCode = null,
    Object? success = null,
  }) {
    return _then(_$OLVerifiedModelImpl(
      responseType: null == responseType
          ? _value.responseType
          : responseType // ignore: cast_nullable_to_non_nullable
              as String,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as VerifiedResponse,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OLVerifiedModelImpl implements _OLVerifiedModel {
  const _$OLVerifiedModelImpl(
      {required this.responseType,
      required this.response,
      required this.statusCode,
      required this.success});

  factory _$OLVerifiedModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OLVerifiedModelImplFromJson(json);

  @override
  final String responseType;
  @override
  final VerifiedResponse response;
  @override
  final int statusCode;
  @override
  final bool success;

  @override
  String toString() {
    return 'OLVerifiedModel(responseType: $responseType, response: $response, statusCode: $statusCode, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OLVerifiedModelImpl &&
            (identical(other.responseType, responseType) ||
                other.responseType == responseType) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, responseType, response, statusCode, success);

  /// Create a copy of OLVerifiedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OLVerifiedModelImplCopyWith<_$OLVerifiedModelImpl> get copyWith =>
      __$$OLVerifiedModelImplCopyWithImpl<_$OLVerifiedModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OLVerifiedModelImplToJson(
      this,
    );
  }
}

abstract class _OLVerifiedModel implements OLVerifiedModel {
  const factory _OLVerifiedModel(
      {required final String responseType,
      required final VerifiedResponse response,
      required final int statusCode,
      required final bool success}) = _$OLVerifiedModelImpl;

  factory _OLVerifiedModel.fromJson(Map<String, dynamic> json) =
      _$OLVerifiedModelImpl.fromJson;

  @override
  String get responseType;
  @override
  VerifiedResponse get response;
  @override
  int get statusCode;
  @override
  bool get success;

  /// Create a copy of OLVerifiedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OLVerifiedModelImplCopyWith<_$OLVerifiedModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VerifiedResponse _$VerifiedResponseFromJson(Map<String, dynamic> json) {
  return _VerifiedResponse.fromJson(json);
}

/// @nodoc
mixin _$VerifiedResponse {
  Map<String, dynamic>? get firebaseInfo => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;
  List<Identity> get identities => throw _privateConstructorUsedError;
  String get idToken => throw _privateConstructorUsedError;
  Network? get network => throw _privateConstructorUsedError;
  DeviceInfo? get deviceInfo => throw _privateConstructorUsedError;
  Map<String, dynamic>? get sessionInfo => throw _privateConstructorUsedError;

  /// Serializes this VerifiedResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerifiedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerifiedResponseCopyWith<VerifiedResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifiedResponseCopyWith<$Res> {
  factory $VerifiedResponseCopyWith(
          VerifiedResponse value, $Res Function(VerifiedResponse) then) =
      _$VerifiedResponseCopyWithImpl<$Res, VerifiedResponse>;
  @useResult
  $Res call(
      {Map<String, dynamic>? firebaseInfo,
      String token,
      String status,
      String userId,
      String timestamp,
      List<Identity> identities,
      String idToken,
      Network? network,
      DeviceInfo? deviceInfo,
      Map<String, dynamic>? sessionInfo});

  $NetworkCopyWith<$Res>? get network;
  $DeviceInfoCopyWith<$Res>? get deviceInfo;
}

/// @nodoc
class _$VerifiedResponseCopyWithImpl<$Res, $Val extends VerifiedResponse>
    implements $VerifiedResponseCopyWith<$Res> {
  _$VerifiedResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerifiedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firebaseInfo = freezed,
    Object? token = null,
    Object? status = null,
    Object? userId = null,
    Object? timestamp = null,
    Object? identities = null,
    Object? idToken = null,
    Object? network = freezed,
    Object? deviceInfo = freezed,
    Object? sessionInfo = freezed,
  }) {
    return _then(_value.copyWith(
      firebaseInfo: freezed == firebaseInfo
          ? _value.firebaseInfo
          : firebaseInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      identities: null == identities
          ? _value.identities
          : identities // ignore: cast_nullable_to_non_nullable
              as List<Identity>,
      idToken: null == idToken
          ? _value.idToken
          : idToken // ignore: cast_nullable_to_non_nullable
              as String,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as Network?,
      deviceInfo: freezed == deviceInfo
          ? _value.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as DeviceInfo?,
      sessionInfo: freezed == sessionInfo
          ? _value.sessionInfo
          : sessionInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of VerifiedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NetworkCopyWith<$Res>? get network {
    if (_value.network == null) {
      return null;
    }

    return $NetworkCopyWith<$Res>(_value.network!, (value) {
      return _then(_value.copyWith(network: value) as $Val);
    });
  }

  /// Create a copy of VerifiedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeviceInfoCopyWith<$Res>? get deviceInfo {
    if (_value.deviceInfo == null) {
      return null;
    }

    return $DeviceInfoCopyWith<$Res>(_value.deviceInfo!, (value) {
      return _then(_value.copyWith(deviceInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VerifiedResponseImplCopyWith<$Res>
    implements $VerifiedResponseCopyWith<$Res> {
  factory _$$VerifiedResponseImplCopyWith(_$VerifiedResponseImpl value,
          $Res Function(_$VerifiedResponseImpl) then) =
      __$$VerifiedResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, dynamic>? firebaseInfo,
      String token,
      String status,
      String userId,
      String timestamp,
      List<Identity> identities,
      String idToken,
      Network? network,
      DeviceInfo? deviceInfo,
      Map<String, dynamic>? sessionInfo});

  @override
  $NetworkCopyWith<$Res>? get network;
  @override
  $DeviceInfoCopyWith<$Res>? get deviceInfo;
}

/// @nodoc
class __$$VerifiedResponseImplCopyWithImpl<$Res>
    extends _$VerifiedResponseCopyWithImpl<$Res, _$VerifiedResponseImpl>
    implements _$$VerifiedResponseImplCopyWith<$Res> {
  __$$VerifiedResponseImplCopyWithImpl(_$VerifiedResponseImpl _value,
      $Res Function(_$VerifiedResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerifiedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firebaseInfo = freezed,
    Object? token = null,
    Object? status = null,
    Object? userId = null,
    Object? timestamp = null,
    Object? identities = null,
    Object? idToken = null,
    Object? network = freezed,
    Object? deviceInfo = freezed,
    Object? sessionInfo = freezed,
  }) {
    return _then(_$VerifiedResponseImpl(
      firebaseInfo: freezed == firebaseInfo
          ? _value._firebaseInfo
          : firebaseInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      identities: null == identities
          ? _value._identities
          : identities // ignore: cast_nullable_to_non_nullable
              as List<Identity>,
      idToken: null == idToken
          ? _value.idToken
          : idToken // ignore: cast_nullable_to_non_nullable
              as String,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as Network?,
      deviceInfo: freezed == deviceInfo
          ? _value.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as DeviceInfo?,
      sessionInfo: freezed == sessionInfo
          ? _value._sessionInfo
          : sessionInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifiedResponseImpl implements _VerifiedResponse {
  const _$VerifiedResponseImpl(
      {final Map<String, dynamic>? firebaseInfo,
      required this.token,
      required this.status,
      required this.userId,
      required this.timestamp,
      required final List<Identity> identities,
      required this.idToken,
      this.network,
      this.deviceInfo,
      final Map<String, dynamic>? sessionInfo})
      : _firebaseInfo = firebaseInfo,
        _identities = identities,
        _sessionInfo = sessionInfo;

  factory _$VerifiedResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifiedResponseImplFromJson(json);

  final Map<String, dynamic>? _firebaseInfo;
  @override
  Map<String, dynamic>? get firebaseInfo {
    final value = _firebaseInfo;
    if (value == null) return null;
    if (_firebaseInfo is EqualUnmodifiableMapView) return _firebaseInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String token;
  @override
  final String status;
  @override
  final String userId;
  @override
  final String timestamp;
  final List<Identity> _identities;
  @override
  List<Identity> get identities {
    if (_identities is EqualUnmodifiableListView) return _identities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_identities);
  }

  @override
  final String idToken;
  @override
  final Network? network;
  @override
  final DeviceInfo? deviceInfo;
  final Map<String, dynamic>? _sessionInfo;
  @override
  Map<String, dynamic>? get sessionInfo {
    final value = _sessionInfo;
    if (value == null) return null;
    if (_sessionInfo is EqualUnmodifiableMapView) return _sessionInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'VerifiedResponse(firebaseInfo: $firebaseInfo, token: $token, status: $status, userId: $userId, timestamp: $timestamp, identities: $identities, idToken: $idToken, network: $network, deviceInfo: $deviceInfo, sessionInfo: $sessionInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifiedResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._firebaseInfo, _firebaseInfo) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality()
                .equals(other._identities, _identities) &&
            (identical(other.idToken, idToken) || other.idToken == idToken) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.deviceInfo, deviceInfo) ||
                other.deviceInfo == deviceInfo) &&
            const DeepCollectionEquality()
                .equals(other._sessionInfo, _sessionInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_firebaseInfo),
      token,
      status,
      userId,
      timestamp,
      const DeepCollectionEquality().hash(_identities),
      idToken,
      network,
      deviceInfo,
      const DeepCollectionEquality().hash(_sessionInfo));

  /// Create a copy of VerifiedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifiedResponseImplCopyWith<_$VerifiedResponseImpl> get copyWith =>
      __$$VerifiedResponseImplCopyWithImpl<_$VerifiedResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifiedResponseImplToJson(
      this,
    );
  }
}

abstract class _VerifiedResponse implements VerifiedResponse {
  const factory _VerifiedResponse(
      {final Map<String, dynamic>? firebaseInfo,
      required final String token,
      required final String status,
      required final String userId,
      required final String timestamp,
      required final List<Identity> identities,
      required final String idToken,
      final Network? network,
      final DeviceInfo? deviceInfo,
      final Map<String, dynamic>? sessionInfo}) = _$VerifiedResponseImpl;

  factory _VerifiedResponse.fromJson(Map<String, dynamic> json) =
      _$VerifiedResponseImpl.fromJson;

  @override
  Map<String, dynamic>? get firebaseInfo;
  @override
  String get token;
  @override
  String get status;
  @override
  String get userId;
  @override
  String get timestamp;
  @override
  List<Identity> get identities;
  @override
  String get idToken;
  @override
  Network? get network;
  @override
  DeviceInfo? get deviceInfo;
  @override
  Map<String, dynamic>? get sessionInfo;

  /// Create a copy of VerifiedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifiedResponseImplCopyWith<_$VerifiedResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Identity _$IdentityFromJson(Map<String, dynamic> json) {
  return _Identity.fromJson(json);
}

/// @nodoc
mixin _$Identity {
  String get identityType => throw _privateConstructorUsedError;
  String get identityValue => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;
  List<String> get methods => throw _privateConstructorUsedError;
  bool get verified => throw _privateConstructorUsedError;
  String get verifiedAt => throw _privateConstructorUsedError;

  /// Serializes this Identity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Identity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IdentityCopyWith<Identity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IdentityCopyWith<$Res> {
  factory $IdentityCopyWith(Identity value, $Res Function(Identity) then) =
      _$IdentityCopyWithImpl<$Res, Identity>;
  @useResult
  $Res call(
      {String identityType,
      String identityValue,
      String channel,
      List<String> methods,
      bool verified,
      String verifiedAt});
}

/// @nodoc
class _$IdentityCopyWithImpl<$Res, $Val extends Identity>
    implements $IdentityCopyWith<$Res> {
  _$IdentityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Identity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityType = null,
    Object? identityValue = null,
    Object? channel = null,
    Object? methods = null,
    Object? verified = null,
    Object? verifiedAt = null,
  }) {
    return _then(_value.copyWith(
      identityType: null == identityType
          ? _value.identityType
          : identityType // ignore: cast_nullable_to_non_nullable
              as String,
      identityValue: null == identityValue
          ? _value.identityValue
          : identityValue // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      methods: null == methods
          ? _value.methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      verified: null == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      verifiedAt: null == verifiedAt
          ? _value.verifiedAt
          : verifiedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IdentityImplCopyWith<$Res>
    implements $IdentityCopyWith<$Res> {
  factory _$$IdentityImplCopyWith(
          _$IdentityImpl value, $Res Function(_$IdentityImpl) then) =
      __$$IdentityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String identityType,
      String identityValue,
      String channel,
      List<String> methods,
      bool verified,
      String verifiedAt});
}

/// @nodoc
class __$$IdentityImplCopyWithImpl<$Res>
    extends _$IdentityCopyWithImpl<$Res, _$IdentityImpl>
    implements _$$IdentityImplCopyWith<$Res> {
  __$$IdentityImplCopyWithImpl(
      _$IdentityImpl _value, $Res Function(_$IdentityImpl) _then)
      : super(_value, _then);

  /// Create a copy of Identity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityType = null,
    Object? identityValue = null,
    Object? channel = null,
    Object? methods = null,
    Object? verified = null,
    Object? verifiedAt = null,
  }) {
    return _then(_$IdentityImpl(
      identityType: null == identityType
          ? _value.identityType
          : identityType // ignore: cast_nullable_to_non_nullable
              as String,
      identityValue: null == identityValue
          ? _value.identityValue
          : identityValue // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      methods: null == methods
          ? _value._methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      verified: null == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      verifiedAt: null == verifiedAt
          ? _value.verifiedAt
          : verifiedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IdentityImpl implements _Identity {
  const _$IdentityImpl(
      {required this.identityType,
      required this.identityValue,
      required this.channel,
      required final List<String> methods,
      required this.verified,
      required this.verifiedAt})
      : _methods = methods;

  factory _$IdentityImpl.fromJson(Map<String, dynamic> json) =>
      _$$IdentityImplFromJson(json);

  @override
  final String identityType;
  @override
  final String identityValue;
  @override
  final String channel;
  final List<String> _methods;
  @override
  List<String> get methods {
    if (_methods is EqualUnmodifiableListView) return _methods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_methods);
  }

  @override
  final bool verified;
  @override
  final String verifiedAt;

  @override
  String toString() {
    return 'Identity(identityType: $identityType, identityValue: $identityValue, channel: $channel, methods: $methods, verified: $verified, verifiedAt: $verifiedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IdentityImpl &&
            (identical(other.identityType, identityType) ||
                other.identityType == identityType) &&
            (identical(other.identityValue, identityValue) ||
                other.identityValue == identityValue) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            const DeepCollectionEquality().equals(other._methods, _methods) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.verifiedAt, verifiedAt) ||
                other.verifiedAt == verifiedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      identityType,
      identityValue,
      channel,
      const DeepCollectionEquality().hash(_methods),
      verified,
      verifiedAt);

  /// Create a copy of Identity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IdentityImplCopyWith<_$IdentityImpl> get copyWith =>
      __$$IdentityImplCopyWithImpl<_$IdentityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IdentityImplToJson(
      this,
    );
  }
}

abstract class _Identity implements Identity {
  const factory _Identity(
      {required final String identityType,
      required final String identityValue,
      required final String channel,
      required final List<String> methods,
      required final bool verified,
      required final String verifiedAt}) = _$IdentityImpl;

  factory _Identity.fromJson(Map<String, dynamic> json) =
      _$IdentityImpl.fromJson;

  @override
  String get identityType;
  @override
  String get identityValue;
  @override
  String get channel;
  @override
  List<String> get methods;
  @override
  bool get verified;
  @override
  String get verifiedAt;

  /// Create a copy of Identity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IdentityImplCopyWith<_$IdentityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Network _$NetworkFromJson(Map<String, dynamic> json) {
  return _Network.fromJson(json);
}

/// @nodoc
mixin _$Network {
  String get ip => throw _privateConstructorUsedError;
  String get timezone => throw _privateConstructorUsedError;
  IPLocation? get ipLocation => throw _privateConstructorUsedError;

  /// Serializes this Network to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Network
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NetworkCopyWith<Network> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkCopyWith<$Res> {
  factory $NetworkCopyWith(Network value, $Res Function(Network) then) =
      _$NetworkCopyWithImpl<$Res, Network>;
  @useResult
  $Res call({String ip, String timezone, IPLocation? ipLocation});

  $IPLocationCopyWith<$Res>? get ipLocation;
}

/// @nodoc
class _$NetworkCopyWithImpl<$Res, $Val extends Network>
    implements $NetworkCopyWith<$Res> {
  _$NetworkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Network
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = null,
    Object? timezone = null,
    Object? ipLocation = freezed,
  }) {
    return _then(_value.copyWith(
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      ipLocation: freezed == ipLocation
          ? _value.ipLocation
          : ipLocation // ignore: cast_nullable_to_non_nullable
              as IPLocation?,
    ) as $Val);
  }

  /// Create a copy of Network
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IPLocationCopyWith<$Res>? get ipLocation {
    if (_value.ipLocation == null) {
      return null;
    }

    return $IPLocationCopyWith<$Res>(_value.ipLocation!, (value) {
      return _then(_value.copyWith(ipLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NetworkImplCopyWith<$Res> implements $NetworkCopyWith<$Res> {
  factory _$$NetworkImplCopyWith(
          _$NetworkImpl value, $Res Function(_$NetworkImpl) then) =
      __$$NetworkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String ip, String timezone, IPLocation? ipLocation});

  @override
  $IPLocationCopyWith<$Res>? get ipLocation;
}

/// @nodoc
class __$$NetworkImplCopyWithImpl<$Res>
    extends _$NetworkCopyWithImpl<$Res, _$NetworkImpl>
    implements _$$NetworkImplCopyWith<$Res> {
  __$$NetworkImplCopyWithImpl(
      _$NetworkImpl _value, $Res Function(_$NetworkImpl) _then)
      : super(_value, _then);

  /// Create a copy of Network
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = null,
    Object? timezone = null,
    Object? ipLocation = freezed,
  }) {
    return _then(_$NetworkImpl(
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      ipLocation: freezed == ipLocation
          ? _value.ipLocation
          : ipLocation // ignore: cast_nullable_to_non_nullable
              as IPLocation?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NetworkImpl implements _Network {
  const _$NetworkImpl(
      {required this.ip, required this.timezone, this.ipLocation});

  factory _$NetworkImpl.fromJson(Map<String, dynamic> json) =>
      _$$NetworkImplFromJson(json);

  @override
  final String ip;
  @override
  final String timezone;
  @override
  final IPLocation? ipLocation;

  @override
  String toString() {
    return 'Network(ip: $ip, timezone: $timezone, ipLocation: $ipLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkImpl &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.ipLocation, ipLocation) ||
                other.ipLocation == ipLocation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ip, timezone, ipLocation);

  /// Create a copy of Network
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkImplCopyWith<_$NetworkImpl> get copyWith =>
      __$$NetworkImplCopyWithImpl<_$NetworkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NetworkImplToJson(
      this,
    );
  }
}

abstract class _Network implements Network {
  const factory _Network(
      {required final String ip,
      required final String timezone,
      final IPLocation? ipLocation}) = _$NetworkImpl;

  factory _Network.fromJson(Map<String, dynamic> json) = _$NetworkImpl.fromJson;

  @override
  String get ip;
  @override
  String get timezone;
  @override
  IPLocation? get ipLocation;

  /// Create a copy of Network
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkImplCopyWith<_$NetworkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IPLocation _$IPLocationFromJson(Map<String, dynamic> json) {
  return _IPLocation.fromJson(json);
}

/// @nodoc
mixin _$IPLocation {
  City? get city => throw _privateConstructorUsedError;
  Subdivisions? get subdivisions => throw _privateConstructorUsedError;
  Country? get country => throw _privateConstructorUsedError;
  Continent? get continent => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;

  /// Serializes this IPLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IPLocationCopyWith<IPLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IPLocationCopyWith<$Res> {
  factory $IPLocationCopyWith(
          IPLocation value, $Res Function(IPLocation) then) =
      _$IPLocationCopyWithImpl<$Res, IPLocation>;
  @useResult
  $Res call(
      {City? city,
      Subdivisions? subdivisions,
      Country? country,
      Continent? continent,
      double? latitude,
      double? longitude,
      String? postalCode});

  $CityCopyWith<$Res>? get city;
  $SubdivisionsCopyWith<$Res>? get subdivisions;
  $CountryCopyWith<$Res>? get country;
  $ContinentCopyWith<$Res>? get continent;
}

/// @nodoc
class _$IPLocationCopyWithImpl<$Res, $Val extends IPLocation>
    implements $IPLocationCopyWith<$Res> {
  _$IPLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = freezed,
    Object? subdivisions = freezed,
    Object? country = freezed,
    Object? continent = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? postalCode = freezed,
  }) {
    return _then(_value.copyWith(
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as City?,
      subdivisions: freezed == subdivisions
          ? _value.subdivisions
          : subdivisions // ignore: cast_nullable_to_non_nullable
              as Subdivisions?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country?,
      continent: freezed == continent
          ? _value.continent
          : continent // ignore: cast_nullable_to_non_nullable
              as Continent?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CityCopyWith<$Res>? get city {
    if (_value.city == null) {
      return null;
    }

    return $CityCopyWith<$Res>(_value.city!, (value) {
      return _then(_value.copyWith(city: value) as $Val);
    });
  }

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubdivisionsCopyWith<$Res>? get subdivisions {
    if (_value.subdivisions == null) {
      return null;
    }

    return $SubdivisionsCopyWith<$Res>(_value.subdivisions!, (value) {
      return _then(_value.copyWith(subdivisions: value) as $Val);
    });
  }

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CountryCopyWith<$Res>? get country {
    if (_value.country == null) {
      return null;
    }

    return $CountryCopyWith<$Res>(_value.country!, (value) {
      return _then(_value.copyWith(country: value) as $Val);
    });
  }

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContinentCopyWith<$Res>? get continent {
    if (_value.continent == null) {
      return null;
    }

    return $ContinentCopyWith<$Res>(_value.continent!, (value) {
      return _then(_value.copyWith(continent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IPLocationImplCopyWith<$Res>
    implements $IPLocationCopyWith<$Res> {
  factory _$$IPLocationImplCopyWith(
          _$IPLocationImpl value, $Res Function(_$IPLocationImpl) then) =
      __$$IPLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {City? city,
      Subdivisions? subdivisions,
      Country? country,
      Continent? continent,
      double? latitude,
      double? longitude,
      String? postalCode});

  @override
  $CityCopyWith<$Res>? get city;
  @override
  $SubdivisionsCopyWith<$Res>? get subdivisions;
  @override
  $CountryCopyWith<$Res>? get country;
  @override
  $ContinentCopyWith<$Res>? get continent;
}

/// @nodoc
class __$$IPLocationImplCopyWithImpl<$Res>
    extends _$IPLocationCopyWithImpl<$Res, _$IPLocationImpl>
    implements _$$IPLocationImplCopyWith<$Res> {
  __$$IPLocationImplCopyWithImpl(
      _$IPLocationImpl _value, $Res Function(_$IPLocationImpl) _then)
      : super(_value, _then);

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = freezed,
    Object? subdivisions = freezed,
    Object? country = freezed,
    Object? continent = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? postalCode = freezed,
  }) {
    return _then(_$IPLocationImpl(
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as City?,
      subdivisions: freezed == subdivisions
          ? _value.subdivisions
          : subdivisions // ignore: cast_nullable_to_non_nullable
              as Subdivisions?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country?,
      continent: freezed == continent
          ? _value.continent
          : continent // ignore: cast_nullable_to_non_nullable
              as Continent?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IPLocationImpl implements _IPLocation {
  const _$IPLocationImpl(
      {this.city,
      this.subdivisions,
      this.country,
      this.continent,
      this.latitude,
      this.longitude,
      this.postalCode});

  factory _$IPLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$IPLocationImplFromJson(json);

  @override
  final City? city;
  @override
  final Subdivisions? subdivisions;
  @override
  final Country? country;
  @override
  final Continent? continent;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? postalCode;

  @override
  String toString() {
    return 'IPLocation(city: $city, subdivisions: $subdivisions, country: $country, continent: $continent, latitude: $latitude, longitude: $longitude, postalCode: $postalCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IPLocationImpl &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.subdivisions, subdivisions) ||
                other.subdivisions == subdivisions) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.continent, continent) ||
                other.continent == continent) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, city, subdivisions, country,
      continent, latitude, longitude, postalCode);

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IPLocationImplCopyWith<_$IPLocationImpl> get copyWith =>
      __$$IPLocationImplCopyWithImpl<_$IPLocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IPLocationImplToJson(
      this,
    );
  }
}

abstract class _IPLocation implements IPLocation {
  const factory _IPLocation(
      {final City? city,
      final Subdivisions? subdivisions,
      final Country? country,
      final Continent? continent,
      final double? latitude,
      final double? longitude,
      final String? postalCode}) = _$IPLocationImpl;

  factory _IPLocation.fromJson(Map<String, dynamic> json) =
      _$IPLocationImpl.fromJson;

  @override
  City? get city;
  @override
  Subdivisions? get subdivisions;
  @override
  Country? get country;
  @override
  Continent? get continent;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get postalCode;

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IPLocationImplCopyWith<_$IPLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

City _$CityFromJson(Map<String, dynamic> json) {
  return _City.fromJson(json);
}

/// @nodoc
mixin _$City {
  String get name => throw _privateConstructorUsedError;

  /// Serializes this City to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of City
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CityCopyWith<City> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CityCopyWith<$Res> {
  factory $CityCopyWith(City value, $Res Function(City) then) =
      _$CityCopyWithImpl<$Res, City>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$CityCopyWithImpl<$Res, $Val extends City>
    implements $CityCopyWith<$Res> {
  _$CityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of City
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CityImplCopyWith<$Res> implements $CityCopyWith<$Res> {
  factory _$$CityImplCopyWith(
          _$CityImpl value, $Res Function(_$CityImpl) then) =
      __$$CityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$CityImplCopyWithImpl<$Res>
    extends _$CityCopyWithImpl<$Res, _$CityImpl>
    implements _$$CityImplCopyWith<$Res> {
  __$$CityImplCopyWithImpl(_$CityImpl _value, $Res Function(_$CityImpl) _then)
      : super(_value, _then);

  /// Create a copy of City
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$CityImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CityImpl implements _City {
  const _$CityImpl({required this.name});

  factory _$CityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CityImplFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'City(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CityImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of City
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CityImplCopyWith<_$CityImpl> get copyWith =>
      __$$CityImplCopyWithImpl<_$CityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CityImplToJson(
      this,
    );
  }
}

abstract class _City implements City {
  const factory _City({required final String name}) = _$CityImpl;

  factory _City.fromJson(Map<String, dynamic> json) = _$CityImpl.fromJson;

  @override
  String get name;

  /// Create a copy of City
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CityImplCopyWith<_$CityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Subdivisions _$SubdivisionsFromJson(Map<String, dynamic> json) {
  return _Subdivisions.fromJson(json);
}

/// @nodoc
mixin _$Subdivisions {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this Subdivisions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Subdivisions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubdivisionsCopyWith<Subdivisions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubdivisionsCopyWith<$Res> {
  factory $SubdivisionsCopyWith(
          Subdivisions value, $Res Function(Subdivisions) then) =
      _$SubdivisionsCopyWithImpl<$Res, Subdivisions>;
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class _$SubdivisionsCopyWithImpl<$Res, $Val extends Subdivisions>
    implements $SubdivisionsCopyWith<$Res> {
  _$SubdivisionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Subdivisions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubdivisionsImplCopyWith<$Res>
    implements $SubdivisionsCopyWith<$Res> {
  factory _$$SubdivisionsImplCopyWith(
          _$SubdivisionsImpl value, $Res Function(_$SubdivisionsImpl) then) =
      __$$SubdivisionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class __$$SubdivisionsImplCopyWithImpl<$Res>
    extends _$SubdivisionsCopyWithImpl<$Res, _$SubdivisionsImpl>
    implements _$$SubdivisionsImplCopyWith<$Res> {
  __$$SubdivisionsImplCopyWithImpl(
      _$SubdivisionsImpl _value, $Res Function(_$SubdivisionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Subdivisions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_$SubdivisionsImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubdivisionsImpl implements _Subdivisions {
  const _$SubdivisionsImpl({required this.code, required this.name});

  factory _$SubdivisionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubdivisionsImplFromJson(json);

  @override
  final String code;
  @override
  final String name;

  @override
  String toString() {
    return 'Subdivisions(code: $code, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubdivisionsImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, name);

  /// Create a copy of Subdivisions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubdivisionsImplCopyWith<_$SubdivisionsImpl> get copyWith =>
      __$$SubdivisionsImplCopyWithImpl<_$SubdivisionsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubdivisionsImplToJson(
      this,
    );
  }
}

abstract class _Subdivisions implements Subdivisions {
  const factory _Subdivisions(
      {required final String code,
      required final String name}) = _$SubdivisionsImpl;

  factory _Subdivisions.fromJson(Map<String, dynamic> json) =
      _$SubdivisionsImpl.fromJson;

  @override
  String get code;
  @override
  String get name;

  /// Create a copy of Subdivisions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubdivisionsImplCopyWith<_$SubdivisionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Country _$CountryFromJson(Map<String, dynamic> json) {
  return _Country.fromJson(json);
}

/// @nodoc
mixin _$Country {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this Country to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CountryCopyWith<Country> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountryCopyWith<$Res> {
  factory $CountryCopyWith(Country value, $Res Function(Country) then) =
      _$CountryCopyWithImpl<$Res, Country>;
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class _$CountryCopyWithImpl<$Res, $Val extends Country>
    implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CountryImplCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$$CountryImplCopyWith(
          _$CountryImpl value, $Res Function(_$CountryImpl) then) =
      __$$CountryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class __$$CountryImplCopyWithImpl<$Res>
    extends _$CountryCopyWithImpl<$Res, _$CountryImpl>
    implements _$$CountryImplCopyWith<$Res> {
  __$$CountryImplCopyWithImpl(
      _$CountryImpl _value, $Res Function(_$CountryImpl) _then)
      : super(_value, _then);

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_$CountryImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CountryImpl implements _Country {
  const _$CountryImpl({required this.code, required this.name});

  factory _$CountryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountryImplFromJson(json);

  @override
  final String code;
  @override
  final String name;

  @override
  String toString() {
    return 'Country(code: $code, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountryImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, name);

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountryImplCopyWith<_$CountryImpl> get copyWith =>
      __$$CountryImplCopyWithImpl<_$CountryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CountryImplToJson(
      this,
    );
  }
}

abstract class _Country implements Country {
  const factory _Country(
      {required final String code, required final String name}) = _$CountryImpl;

  factory _Country.fromJson(Map<String, dynamic> json) = _$CountryImpl.fromJson;

  @override
  String get code;
  @override
  String get name;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountryImplCopyWith<_$CountryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Continent _$ContinentFromJson(Map<String, dynamic> json) {
  return _Continent.fromJson(json);
}

/// @nodoc
mixin _$Continent {
  String get code => throw _privateConstructorUsedError;

  /// Serializes this Continent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Continent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContinentCopyWith<Continent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContinentCopyWith<$Res> {
  factory $ContinentCopyWith(Continent value, $Res Function(Continent) then) =
      _$ContinentCopyWithImpl<$Res, Continent>;
  @useResult
  $Res call({String code});
}

/// @nodoc
class _$ContinentCopyWithImpl<$Res, $Val extends Continent>
    implements $ContinentCopyWith<$Res> {
  _$ContinentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Continent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContinentImplCopyWith<$Res>
    implements $ContinentCopyWith<$Res> {
  factory _$$ContinentImplCopyWith(
          _$ContinentImpl value, $Res Function(_$ContinentImpl) then) =
      __$$ContinentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code});
}

/// @nodoc
class __$$ContinentImplCopyWithImpl<$Res>
    extends _$ContinentCopyWithImpl<$Res, _$ContinentImpl>
    implements _$$ContinentImplCopyWith<$Res> {
  __$$ContinentImplCopyWithImpl(
      _$ContinentImpl _value, $Res Function(_$ContinentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Continent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
  }) {
    return _then(_$ContinentImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContinentImpl implements _Continent {
  const _$ContinentImpl({required this.code});

  factory _$ContinentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContinentImplFromJson(json);

  @override
  final String code;

  @override
  String toString() {
    return 'Continent(code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContinentImpl &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code);

  /// Create a copy of Continent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContinentImplCopyWith<_$ContinentImpl> get copyWith =>
      __$$ContinentImplCopyWithImpl<_$ContinentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContinentImplToJson(
      this,
    );
  }
}

abstract class _Continent implements Continent {
  const factory _Continent({required final String code}) = _$ContinentImpl;

  factory _Continent.fromJson(Map<String, dynamic> json) =
      _$ContinentImpl.fromJson;

  @override
  String get code;

  /// Create a copy of Continent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContinentImplCopyWith<_$ContinentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) {
  return _DeviceInfo.fromJson(json);
}

/// @nodoc
mixin _$DeviceInfo {
  String get userAgent => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;
  String get vendor => throw _privateConstructorUsedError;
  String get browser => throw _privateConstructorUsedError;
  String get connection => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  bool get cookieEnabled => throw _privateConstructorUsedError;
  int get screenWidth => throw _privateConstructorUsedError;
  int get screenHeight => throw _privateConstructorUsedError;
  int get screenColorDepth => throw _privateConstructorUsedError;
  double get devicePixelRatio => throw _privateConstructorUsedError;
  int get timezoneOffset => throw _privateConstructorUsedError;
  String get cpuArchitecture => throw _privateConstructorUsedError;
  String get fontFamily => throw _privateConstructorUsedError;

  /// Serializes this DeviceInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceInfoCopyWith<DeviceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInfoCopyWith<$Res> {
  factory $DeviceInfoCopyWith(
          DeviceInfo value, $Res Function(DeviceInfo) then) =
      _$DeviceInfoCopyWithImpl<$Res, DeviceInfo>;
  @useResult
  $Res call(
      {String userAgent,
      String platform,
      String vendor,
      String browser,
      String connection,
      String language,
      bool cookieEnabled,
      int screenWidth,
      int screenHeight,
      int screenColorDepth,
      double devicePixelRatio,
      int timezoneOffset,
      String cpuArchitecture,
      String fontFamily});
}

/// @nodoc
class _$DeviceInfoCopyWithImpl<$Res, $Val extends DeviceInfo>
    implements $DeviceInfoCopyWith<$Res> {
  _$DeviceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userAgent = null,
    Object? platform = null,
    Object? vendor = null,
    Object? browser = null,
    Object? connection = null,
    Object? language = null,
    Object? cookieEnabled = null,
    Object? screenWidth = null,
    Object? screenHeight = null,
    Object? screenColorDepth = null,
    Object? devicePixelRatio = null,
    Object? timezoneOffset = null,
    Object? cpuArchitecture = null,
    Object? fontFamily = null,
  }) {
    return _then(_value.copyWith(
      userAgent: null == userAgent
          ? _value.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      vendor: null == vendor
          ? _value.vendor
          : vendor // ignore: cast_nullable_to_non_nullable
              as String,
      browser: null == browser
          ? _value.browser
          : browser // ignore: cast_nullable_to_non_nullable
              as String,
      connection: null == connection
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      cookieEnabled: null == cookieEnabled
          ? _value.cookieEnabled
          : cookieEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      screenWidth: null == screenWidth
          ? _value.screenWidth
          : screenWidth // ignore: cast_nullable_to_non_nullable
              as int,
      screenHeight: null == screenHeight
          ? _value.screenHeight
          : screenHeight // ignore: cast_nullable_to_non_nullable
              as int,
      screenColorDepth: null == screenColorDepth
          ? _value.screenColorDepth
          : screenColorDepth // ignore: cast_nullable_to_non_nullable
              as int,
      devicePixelRatio: null == devicePixelRatio
          ? _value.devicePixelRatio
          : devicePixelRatio // ignore: cast_nullable_to_non_nullable
              as double,
      timezoneOffset: null == timezoneOffset
          ? _value.timezoneOffset
          : timezoneOffset // ignore: cast_nullable_to_non_nullable
              as int,
      cpuArchitecture: null == cpuArchitecture
          ? _value.cpuArchitecture
          : cpuArchitecture // ignore: cast_nullable_to_non_nullable
              as String,
      fontFamily: null == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceInfoImplCopyWith<$Res>
    implements $DeviceInfoCopyWith<$Res> {
  factory _$$DeviceInfoImplCopyWith(
          _$DeviceInfoImpl value, $Res Function(_$DeviceInfoImpl) then) =
      __$$DeviceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userAgent,
      String platform,
      String vendor,
      String browser,
      String connection,
      String language,
      bool cookieEnabled,
      int screenWidth,
      int screenHeight,
      int screenColorDepth,
      double devicePixelRatio,
      int timezoneOffset,
      String cpuArchitecture,
      String fontFamily});
}

/// @nodoc
class __$$DeviceInfoImplCopyWithImpl<$Res>
    extends _$DeviceInfoCopyWithImpl<$Res, _$DeviceInfoImpl>
    implements _$$DeviceInfoImplCopyWith<$Res> {
  __$$DeviceInfoImplCopyWithImpl(
      _$DeviceInfoImpl _value, $Res Function(_$DeviceInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userAgent = null,
    Object? platform = null,
    Object? vendor = null,
    Object? browser = null,
    Object? connection = null,
    Object? language = null,
    Object? cookieEnabled = null,
    Object? screenWidth = null,
    Object? screenHeight = null,
    Object? screenColorDepth = null,
    Object? devicePixelRatio = null,
    Object? timezoneOffset = null,
    Object? cpuArchitecture = null,
    Object? fontFamily = null,
  }) {
    return _then(_$DeviceInfoImpl(
      userAgent: null == userAgent
          ? _value.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      vendor: null == vendor
          ? _value.vendor
          : vendor // ignore: cast_nullable_to_non_nullable
              as String,
      browser: null == browser
          ? _value.browser
          : browser // ignore: cast_nullable_to_non_nullable
              as String,
      connection: null == connection
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      cookieEnabled: null == cookieEnabled
          ? _value.cookieEnabled
          : cookieEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      screenWidth: null == screenWidth
          ? _value.screenWidth
          : screenWidth // ignore: cast_nullable_to_non_nullable
              as int,
      screenHeight: null == screenHeight
          ? _value.screenHeight
          : screenHeight // ignore: cast_nullable_to_non_nullable
              as int,
      screenColorDepth: null == screenColorDepth
          ? _value.screenColorDepth
          : screenColorDepth // ignore: cast_nullable_to_non_nullable
              as int,
      devicePixelRatio: null == devicePixelRatio
          ? _value.devicePixelRatio
          : devicePixelRatio // ignore: cast_nullable_to_non_nullable
              as double,
      timezoneOffset: null == timezoneOffset
          ? _value.timezoneOffset
          : timezoneOffset // ignore: cast_nullable_to_non_nullable
              as int,
      cpuArchitecture: null == cpuArchitecture
          ? _value.cpuArchitecture
          : cpuArchitecture // ignore: cast_nullable_to_non_nullable
              as String,
      fontFamily: null == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceInfoImpl implements _DeviceInfo {
  const _$DeviceInfoImpl(
      {required this.userAgent,
      required this.platform,
      required this.vendor,
      required this.browser,
      required this.connection,
      required this.language,
      required this.cookieEnabled,
      required this.screenWidth,
      required this.screenHeight,
      required this.screenColorDepth,
      required this.devicePixelRatio,
      required this.timezoneOffset,
      required this.cpuArchitecture,
      required this.fontFamily});

  factory _$DeviceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceInfoImplFromJson(json);

  @override
  final String userAgent;
  @override
  final String platform;
  @override
  final String vendor;
  @override
  final String browser;
  @override
  final String connection;
  @override
  final String language;
  @override
  final bool cookieEnabled;
  @override
  final int screenWidth;
  @override
  final int screenHeight;
  @override
  final int screenColorDepth;
  @override
  final double devicePixelRatio;
  @override
  final int timezoneOffset;
  @override
  final String cpuArchitecture;
  @override
  final String fontFamily;

  @override
  String toString() {
    return 'DeviceInfo(userAgent: $userAgent, platform: $platform, vendor: $vendor, browser: $browser, connection: $connection, language: $language, cookieEnabled: $cookieEnabled, screenWidth: $screenWidth, screenHeight: $screenHeight, screenColorDepth: $screenColorDepth, devicePixelRatio: $devicePixelRatio, timezoneOffset: $timezoneOffset, cpuArchitecture: $cpuArchitecture, fontFamily: $fontFamily)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceInfoImpl &&
            (identical(other.userAgent, userAgent) ||
                other.userAgent == userAgent) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.vendor, vendor) || other.vendor == vendor) &&
            (identical(other.browser, browser) || other.browser == browser) &&
            (identical(other.connection, connection) ||
                other.connection == connection) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.cookieEnabled, cookieEnabled) ||
                other.cookieEnabled == cookieEnabled) &&
            (identical(other.screenWidth, screenWidth) ||
                other.screenWidth == screenWidth) &&
            (identical(other.screenHeight, screenHeight) ||
                other.screenHeight == screenHeight) &&
            (identical(other.screenColorDepth, screenColorDepth) ||
                other.screenColorDepth == screenColorDepth) &&
            (identical(other.devicePixelRatio, devicePixelRatio) ||
                other.devicePixelRatio == devicePixelRatio) &&
            (identical(other.timezoneOffset, timezoneOffset) ||
                other.timezoneOffset == timezoneOffset) &&
            (identical(other.cpuArchitecture, cpuArchitecture) ||
                other.cpuArchitecture == cpuArchitecture) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userAgent,
      platform,
      vendor,
      browser,
      connection,
      language,
      cookieEnabled,
      screenWidth,
      screenHeight,
      screenColorDepth,
      devicePixelRatio,
      timezoneOffset,
      cpuArchitecture,
      fontFamily);

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      __$$DeviceInfoImplCopyWithImpl<_$DeviceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceInfoImplToJson(
      this,
    );
  }
}

abstract class _DeviceInfo implements DeviceInfo {
  const factory _DeviceInfo(
      {required final String userAgent,
      required final String platform,
      required final String vendor,
      required final String browser,
      required final String connection,
      required final String language,
      required final bool cookieEnabled,
      required final int screenWidth,
      required final int screenHeight,
      required final int screenColorDepth,
      required final double devicePixelRatio,
      required final int timezoneOffset,
      required final String cpuArchitecture,
      required final String fontFamily}) = _$DeviceInfoImpl;

  factory _DeviceInfo.fromJson(Map<String, dynamic> json) =
      _$DeviceInfoImpl.fromJson;

  @override
  String get userAgent;
  @override
  String get platform;
  @override
  String get vendor;
  @override
  String get browser;
  @override
  String get connection;
  @override
  String get language;
  @override
  bool get cookieEnabled;
  @override
  int get screenWidth;
  @override
  int get screenHeight;
  @override
  int get screenColorDepth;
  @override
  double get devicePixelRatio;
  @override
  int get timezoneOffset;
  @override
  String get cpuArchitecture;
  @override
  String get fontFamily;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ol_verified_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OLVerifiedModel {
  String get responseType;
  VerifiedResponse get response;
  int get statusCode;
  bool get success;

  /// Create a copy of OLVerifiedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OLVerifiedModelCopyWith<OLVerifiedModel> get copyWith =>
      _$OLVerifiedModelCopyWithImpl<OLVerifiedModel>(
          this as OLVerifiedModel, _$identity);

  /// Serializes this OLVerifiedModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OLVerifiedModel &&
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

  @override
  String toString() {
    return 'OLVerifiedModel(responseType: $responseType, response: $response, statusCode: $statusCode, success: $success)';
  }
}

/// @nodoc
abstract mixin class $OLVerifiedModelCopyWith<$Res> {
  factory $OLVerifiedModelCopyWith(
          OLVerifiedModel value, $Res Function(OLVerifiedModel) _then) =
      _$OLVerifiedModelCopyWithImpl;
  @useResult
  $Res call(
      {String responseType,
      VerifiedResponse response,
      int statusCode,
      bool success});

  $VerifiedResponseCopyWith<$Res> get response;
}

/// @nodoc
class _$OLVerifiedModelCopyWithImpl<$Res>
    implements $OLVerifiedModelCopyWith<$Res> {
  _$OLVerifiedModelCopyWithImpl(this._self, this._then);

  final OLVerifiedModel _self;
  final $Res Function(OLVerifiedModel) _then;

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
    return _then(_self.copyWith(
      responseType: null == responseType
          ? _self.responseType
          : responseType // ignore: cast_nullable_to_non_nullable
              as String,
      response: null == response
          ? _self.response
          : response // ignore: cast_nullable_to_non_nullable
              as VerifiedResponse,
      statusCode: null == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of OLVerifiedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VerifiedResponseCopyWith<$Res> get response {
    return $VerifiedResponseCopyWith<$Res>(_self.response, (value) {
      return _then(_self.copyWith(response: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _OLVerifiedModel implements OLVerifiedModel {
  const _OLVerifiedModel(
      {required this.responseType,
      required this.response,
      required this.statusCode,
      required this.success});
  factory _OLVerifiedModel.fromJson(Map<String, dynamic> json) =>
      _$OLVerifiedModelFromJson(json);

  @override
  final String responseType;
  @override
  final VerifiedResponse response;
  @override
  final int statusCode;
  @override
  final bool success;

  /// Create a copy of OLVerifiedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OLVerifiedModelCopyWith<_OLVerifiedModel> get copyWith =>
      __$OLVerifiedModelCopyWithImpl<_OLVerifiedModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OLVerifiedModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OLVerifiedModel &&
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

  @override
  String toString() {
    return 'OLVerifiedModel(responseType: $responseType, response: $response, statusCode: $statusCode, success: $success)';
  }
}

/// @nodoc
abstract mixin class _$OLVerifiedModelCopyWith<$Res>
    implements $OLVerifiedModelCopyWith<$Res> {
  factory _$OLVerifiedModelCopyWith(
          _OLVerifiedModel value, $Res Function(_OLVerifiedModel) _then) =
      __$OLVerifiedModelCopyWithImpl;
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
class __$OLVerifiedModelCopyWithImpl<$Res>
    implements _$OLVerifiedModelCopyWith<$Res> {
  __$OLVerifiedModelCopyWithImpl(this._self, this._then);

  final _OLVerifiedModel _self;
  final $Res Function(_OLVerifiedModel) _then;

  /// Create a copy of OLVerifiedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? responseType = null,
    Object? response = null,
    Object? statusCode = null,
    Object? success = null,
  }) {
    return _then(_OLVerifiedModel(
      responseType: null == responseType
          ? _self.responseType
          : responseType // ignore: cast_nullable_to_non_nullable
              as String,
      response: null == response
          ? _self.response
          : response // ignore: cast_nullable_to_non_nullable
              as VerifiedResponse,
      statusCode: null == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of OLVerifiedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VerifiedResponseCopyWith<$Res> get response {
    return $VerifiedResponseCopyWith<$Res>(_self.response, (value) {
      return _then(_self.copyWith(response: value));
    });
  }
}

/// @nodoc
mixin _$VerifiedResponse {
  Map<String, dynamic>? get firebaseInfo;
  String get token;
  String get status;
  String get userId;
  String get timestamp;
  List<Identity> get identities;
  String get idToken;
  Network? get network;
  DeviceInfo? get deviceInfo;
  Map<String, dynamic>? get sessionInfo;

  /// Create a copy of VerifiedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VerifiedResponseCopyWith<VerifiedResponse> get copyWith =>
      _$VerifiedResponseCopyWithImpl<VerifiedResponse>(
          this as VerifiedResponse, _$identity);

  /// Serializes this VerifiedResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VerifiedResponse &&
            const DeepCollectionEquality()
                .equals(other.firebaseInfo, firebaseInfo) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality()
                .equals(other.identities, identities) &&
            (identical(other.idToken, idToken) || other.idToken == idToken) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.deviceInfo, deviceInfo) ||
                other.deviceInfo == deviceInfo) &&
            const DeepCollectionEquality()
                .equals(other.sessionInfo, sessionInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(firebaseInfo),
      token,
      status,
      userId,
      timestamp,
      const DeepCollectionEquality().hash(identities),
      idToken,
      network,
      deviceInfo,
      const DeepCollectionEquality().hash(sessionInfo));

  @override
  String toString() {
    return 'VerifiedResponse(firebaseInfo: $firebaseInfo, token: $token, status: $status, userId: $userId, timestamp: $timestamp, identities: $identities, idToken: $idToken, network: $network, deviceInfo: $deviceInfo, sessionInfo: $sessionInfo)';
  }
}

/// @nodoc
abstract mixin class $VerifiedResponseCopyWith<$Res> {
  factory $VerifiedResponseCopyWith(
          VerifiedResponse value, $Res Function(VerifiedResponse) _then) =
      _$VerifiedResponseCopyWithImpl;
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
class _$VerifiedResponseCopyWithImpl<$Res>
    implements $VerifiedResponseCopyWith<$Res> {
  _$VerifiedResponseCopyWithImpl(this._self, this._then);

  final VerifiedResponse _self;
  final $Res Function(VerifiedResponse) _then;

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
    return _then(_self.copyWith(
      firebaseInfo: freezed == firebaseInfo
          ? _self.firebaseInfo
          : firebaseInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      identities: null == identities
          ? _self.identities
          : identities // ignore: cast_nullable_to_non_nullable
              as List<Identity>,
      idToken: null == idToken
          ? _self.idToken
          : idToken // ignore: cast_nullable_to_non_nullable
              as String,
      network: freezed == network
          ? _self.network
          : network // ignore: cast_nullable_to_non_nullable
              as Network?,
      deviceInfo: freezed == deviceInfo
          ? _self.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as DeviceInfo?,
      sessionInfo: freezed == sessionInfo
          ? _self.sessionInfo
          : sessionInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }

  /// Create a copy of VerifiedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NetworkCopyWith<$Res>? get network {
    if (_self.network == null) {
      return null;
    }

    return $NetworkCopyWith<$Res>(_self.network!, (value) {
      return _then(_self.copyWith(network: value));
    });
  }

  /// Create a copy of VerifiedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeviceInfoCopyWith<$Res>? get deviceInfo {
    if (_self.deviceInfo == null) {
      return null;
    }

    return $DeviceInfoCopyWith<$Res>(_self.deviceInfo!, (value) {
      return _then(_self.copyWith(deviceInfo: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _VerifiedResponse implements VerifiedResponse {
  const _VerifiedResponse(
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
  factory _VerifiedResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifiedResponseFromJson(json);

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

  /// Create a copy of VerifiedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VerifiedResponseCopyWith<_VerifiedResponse> get copyWith =>
      __$VerifiedResponseCopyWithImpl<_VerifiedResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VerifiedResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VerifiedResponse &&
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

  @override
  String toString() {
    return 'VerifiedResponse(firebaseInfo: $firebaseInfo, token: $token, status: $status, userId: $userId, timestamp: $timestamp, identities: $identities, idToken: $idToken, network: $network, deviceInfo: $deviceInfo, sessionInfo: $sessionInfo)';
  }
}

/// @nodoc
abstract mixin class _$VerifiedResponseCopyWith<$Res>
    implements $VerifiedResponseCopyWith<$Res> {
  factory _$VerifiedResponseCopyWith(
          _VerifiedResponse value, $Res Function(_VerifiedResponse) _then) =
      __$VerifiedResponseCopyWithImpl;
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
class __$VerifiedResponseCopyWithImpl<$Res>
    implements _$VerifiedResponseCopyWith<$Res> {
  __$VerifiedResponseCopyWithImpl(this._self, this._then);

  final _VerifiedResponse _self;
  final $Res Function(_VerifiedResponse) _then;

  /// Create a copy of VerifiedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_VerifiedResponse(
      firebaseInfo: freezed == firebaseInfo
          ? _self._firebaseInfo
          : firebaseInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      identities: null == identities
          ? _self._identities
          : identities // ignore: cast_nullable_to_non_nullable
              as List<Identity>,
      idToken: null == idToken
          ? _self.idToken
          : idToken // ignore: cast_nullable_to_non_nullable
              as String,
      network: freezed == network
          ? _self.network
          : network // ignore: cast_nullable_to_non_nullable
              as Network?,
      deviceInfo: freezed == deviceInfo
          ? _self.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as DeviceInfo?,
      sessionInfo: freezed == sessionInfo
          ? _self._sessionInfo
          : sessionInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }

  /// Create a copy of VerifiedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NetworkCopyWith<$Res>? get network {
    if (_self.network == null) {
      return null;
    }

    return $NetworkCopyWith<$Res>(_self.network!, (value) {
      return _then(_self.copyWith(network: value));
    });
  }

  /// Create a copy of VerifiedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeviceInfoCopyWith<$Res>? get deviceInfo {
    if (_self.deviceInfo == null) {
      return null;
    }

    return $DeviceInfoCopyWith<$Res>(_self.deviceInfo!, (value) {
      return _then(_self.copyWith(deviceInfo: value));
    });
  }
}

/// @nodoc
mixin _$Identity {
  String get identityType;
  String get identityValue;
  String get channel;
  List<String> get methods;
  bool get verified;
  String get verifiedAt;

  /// Create a copy of Identity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IdentityCopyWith<Identity> get copyWith =>
      _$IdentityCopyWithImpl<Identity>(this as Identity, _$identity);

  /// Serializes this Identity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Identity &&
            (identical(other.identityType, identityType) ||
                other.identityType == identityType) &&
            (identical(other.identityValue, identityValue) ||
                other.identityValue == identityValue) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            const DeepCollectionEquality().equals(other.methods, methods) &&
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
      const DeepCollectionEquality().hash(methods),
      verified,
      verifiedAt);

  @override
  String toString() {
    return 'Identity(identityType: $identityType, identityValue: $identityValue, channel: $channel, methods: $methods, verified: $verified, verifiedAt: $verifiedAt)';
  }
}

/// @nodoc
abstract mixin class $IdentityCopyWith<$Res> {
  factory $IdentityCopyWith(Identity value, $Res Function(Identity) _then) =
      _$IdentityCopyWithImpl;
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
class _$IdentityCopyWithImpl<$Res> implements $IdentityCopyWith<$Res> {
  _$IdentityCopyWithImpl(this._self, this._then);

  final Identity _self;
  final $Res Function(Identity) _then;

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
    return _then(_self.copyWith(
      identityType: null == identityType
          ? _self.identityType
          : identityType // ignore: cast_nullable_to_non_nullable
              as String,
      identityValue: null == identityValue
          ? _self.identityValue
          : identityValue // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      methods: null == methods
          ? _self.methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      verified: null == verified
          ? _self.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      verifiedAt: null == verifiedAt
          ? _self.verifiedAt
          : verifiedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Identity implements Identity {
  const _Identity(
      {required this.identityType,
      required this.identityValue,
      required this.channel,
      required final List<String> methods,
      required this.verified,
      required this.verifiedAt})
      : _methods = methods;
  factory _Identity.fromJson(Map<String, dynamic> json) =>
      _$IdentityFromJson(json);

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

  /// Create a copy of Identity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IdentityCopyWith<_Identity> get copyWith =>
      __$IdentityCopyWithImpl<_Identity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IdentityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Identity &&
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

  @override
  String toString() {
    return 'Identity(identityType: $identityType, identityValue: $identityValue, channel: $channel, methods: $methods, verified: $verified, verifiedAt: $verifiedAt)';
  }
}

/// @nodoc
abstract mixin class _$IdentityCopyWith<$Res>
    implements $IdentityCopyWith<$Res> {
  factory _$IdentityCopyWith(_Identity value, $Res Function(_Identity) _then) =
      __$IdentityCopyWithImpl;
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
class __$IdentityCopyWithImpl<$Res> implements _$IdentityCopyWith<$Res> {
  __$IdentityCopyWithImpl(this._self, this._then);

  final _Identity _self;
  final $Res Function(_Identity) _then;

  /// Create a copy of Identity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? identityType = null,
    Object? identityValue = null,
    Object? channel = null,
    Object? methods = null,
    Object? verified = null,
    Object? verifiedAt = null,
  }) {
    return _then(_Identity(
      identityType: null == identityType
          ? _self.identityType
          : identityType // ignore: cast_nullable_to_non_nullable
              as String,
      identityValue: null == identityValue
          ? _self.identityValue
          : identityValue // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      methods: null == methods
          ? _self._methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      verified: null == verified
          ? _self.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      verifiedAt: null == verifiedAt
          ? _self.verifiedAt
          : verifiedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Network {
  String get ip;
  String get timezone;
  IPLocation? get ipLocation;

  /// Create a copy of Network
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NetworkCopyWith<Network> get copyWith =>
      _$NetworkCopyWithImpl<Network>(this as Network, _$identity);

  /// Serializes this Network to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Network &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.ipLocation, ipLocation) ||
                other.ipLocation == ipLocation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ip, timezone, ipLocation);

  @override
  String toString() {
    return 'Network(ip: $ip, timezone: $timezone, ipLocation: $ipLocation)';
  }
}

/// @nodoc
abstract mixin class $NetworkCopyWith<$Res> {
  factory $NetworkCopyWith(Network value, $Res Function(Network) _then) =
      _$NetworkCopyWithImpl;
  @useResult
  $Res call({String ip, String timezone, IPLocation? ipLocation});

  $IPLocationCopyWith<$Res>? get ipLocation;
}

/// @nodoc
class _$NetworkCopyWithImpl<$Res> implements $NetworkCopyWith<$Res> {
  _$NetworkCopyWithImpl(this._self, this._then);

  final Network _self;
  final $Res Function(Network) _then;

  /// Create a copy of Network
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = null,
    Object? timezone = null,
    Object? ipLocation = freezed,
  }) {
    return _then(_self.copyWith(
      ip: null == ip
          ? _self.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _self.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      ipLocation: freezed == ipLocation
          ? _self.ipLocation
          : ipLocation // ignore: cast_nullable_to_non_nullable
              as IPLocation?,
    ));
  }

  /// Create a copy of Network
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IPLocationCopyWith<$Res>? get ipLocation {
    if (_self.ipLocation == null) {
      return null;
    }

    return $IPLocationCopyWith<$Res>(_self.ipLocation!, (value) {
      return _then(_self.copyWith(ipLocation: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _Network implements Network {
  const _Network({required this.ip, required this.timezone, this.ipLocation});
  factory _Network.fromJson(Map<String, dynamic> json) =>
      _$NetworkFromJson(json);

  @override
  final String ip;
  @override
  final String timezone;
  @override
  final IPLocation? ipLocation;

  /// Create a copy of Network
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NetworkCopyWith<_Network> get copyWith =>
      __$NetworkCopyWithImpl<_Network>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NetworkToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Network &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.ipLocation, ipLocation) ||
                other.ipLocation == ipLocation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ip, timezone, ipLocation);

  @override
  String toString() {
    return 'Network(ip: $ip, timezone: $timezone, ipLocation: $ipLocation)';
  }
}

/// @nodoc
abstract mixin class _$NetworkCopyWith<$Res> implements $NetworkCopyWith<$Res> {
  factory _$NetworkCopyWith(_Network value, $Res Function(_Network) _then) =
      __$NetworkCopyWithImpl;
  @override
  @useResult
  $Res call({String ip, String timezone, IPLocation? ipLocation});

  @override
  $IPLocationCopyWith<$Res>? get ipLocation;
}

/// @nodoc
class __$NetworkCopyWithImpl<$Res> implements _$NetworkCopyWith<$Res> {
  __$NetworkCopyWithImpl(this._self, this._then);

  final _Network _self;
  final $Res Function(_Network) _then;

  /// Create a copy of Network
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? ip = null,
    Object? timezone = null,
    Object? ipLocation = freezed,
  }) {
    return _then(_Network(
      ip: null == ip
          ? _self.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _self.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      ipLocation: freezed == ipLocation
          ? _self.ipLocation
          : ipLocation // ignore: cast_nullable_to_non_nullable
              as IPLocation?,
    ));
  }

  /// Create a copy of Network
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IPLocationCopyWith<$Res>? get ipLocation {
    if (_self.ipLocation == null) {
      return null;
    }

    return $IPLocationCopyWith<$Res>(_self.ipLocation!, (value) {
      return _then(_self.copyWith(ipLocation: value));
    });
  }
}

/// @nodoc
mixin _$IPLocation {
  City? get city;
  Subdivisions? get subdivisions;
  Country? get country;
  Continent? get continent;
  double? get latitude;
  double? get longitude;
  String? get postalCode;

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IPLocationCopyWith<IPLocation> get copyWith =>
      _$IPLocationCopyWithImpl<IPLocation>(this as IPLocation, _$identity);

  /// Serializes this IPLocation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IPLocation &&
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

  @override
  String toString() {
    return 'IPLocation(city: $city, subdivisions: $subdivisions, country: $country, continent: $continent, latitude: $latitude, longitude: $longitude, postalCode: $postalCode)';
  }
}

/// @nodoc
abstract mixin class $IPLocationCopyWith<$Res> {
  factory $IPLocationCopyWith(
          IPLocation value, $Res Function(IPLocation) _then) =
      _$IPLocationCopyWithImpl;
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
class _$IPLocationCopyWithImpl<$Res> implements $IPLocationCopyWith<$Res> {
  _$IPLocationCopyWithImpl(this._self, this._then);

  final IPLocation _self;
  final $Res Function(IPLocation) _then;

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
    return _then(_self.copyWith(
      city: freezed == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as City?,
      subdivisions: freezed == subdivisions
          ? _self.subdivisions
          : subdivisions // ignore: cast_nullable_to_non_nullable
              as Subdivisions?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country?,
      continent: freezed == continent
          ? _self.continent
          : continent // ignore: cast_nullable_to_non_nullable
              as Continent?,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      postalCode: freezed == postalCode
          ? _self.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CityCopyWith<$Res>? get city {
    if (_self.city == null) {
      return null;
    }

    return $CityCopyWith<$Res>(_self.city!, (value) {
      return _then(_self.copyWith(city: value));
    });
  }

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubdivisionsCopyWith<$Res>? get subdivisions {
    if (_self.subdivisions == null) {
      return null;
    }

    return $SubdivisionsCopyWith<$Res>(_self.subdivisions!, (value) {
      return _then(_self.copyWith(subdivisions: value));
    });
  }

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CountryCopyWith<$Res>? get country {
    if (_self.country == null) {
      return null;
    }

    return $CountryCopyWith<$Res>(_self.country!, (value) {
      return _then(_self.copyWith(country: value));
    });
  }

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContinentCopyWith<$Res>? get continent {
    if (_self.continent == null) {
      return null;
    }

    return $ContinentCopyWith<$Res>(_self.continent!, (value) {
      return _then(_self.copyWith(continent: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _IPLocation implements IPLocation {
  const _IPLocation(
      {this.city,
      this.subdivisions,
      this.country,
      this.continent,
      this.latitude,
      this.longitude,
      this.postalCode});
  factory _IPLocation.fromJson(Map<String, dynamic> json) =>
      _$IPLocationFromJson(json);

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

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IPLocationCopyWith<_IPLocation> get copyWith =>
      __$IPLocationCopyWithImpl<_IPLocation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IPLocationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IPLocation &&
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

  @override
  String toString() {
    return 'IPLocation(city: $city, subdivisions: $subdivisions, country: $country, continent: $continent, latitude: $latitude, longitude: $longitude, postalCode: $postalCode)';
  }
}

/// @nodoc
abstract mixin class _$IPLocationCopyWith<$Res>
    implements $IPLocationCopyWith<$Res> {
  factory _$IPLocationCopyWith(
          _IPLocation value, $Res Function(_IPLocation) _then) =
      __$IPLocationCopyWithImpl;
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
class __$IPLocationCopyWithImpl<$Res> implements _$IPLocationCopyWith<$Res> {
  __$IPLocationCopyWithImpl(this._self, this._then);

  final _IPLocation _self;
  final $Res Function(_IPLocation) _then;

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? city = freezed,
    Object? subdivisions = freezed,
    Object? country = freezed,
    Object? continent = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? postalCode = freezed,
  }) {
    return _then(_IPLocation(
      city: freezed == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as City?,
      subdivisions: freezed == subdivisions
          ? _self.subdivisions
          : subdivisions // ignore: cast_nullable_to_non_nullable
              as Subdivisions?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country?,
      continent: freezed == continent
          ? _self.continent
          : continent // ignore: cast_nullable_to_non_nullable
              as Continent?,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      postalCode: freezed == postalCode
          ? _self.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CityCopyWith<$Res>? get city {
    if (_self.city == null) {
      return null;
    }

    return $CityCopyWith<$Res>(_self.city!, (value) {
      return _then(_self.copyWith(city: value));
    });
  }

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubdivisionsCopyWith<$Res>? get subdivisions {
    if (_self.subdivisions == null) {
      return null;
    }

    return $SubdivisionsCopyWith<$Res>(_self.subdivisions!, (value) {
      return _then(_self.copyWith(subdivisions: value));
    });
  }

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CountryCopyWith<$Res>? get country {
    if (_self.country == null) {
      return null;
    }

    return $CountryCopyWith<$Res>(_self.country!, (value) {
      return _then(_self.copyWith(country: value));
    });
  }

  /// Create a copy of IPLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContinentCopyWith<$Res>? get continent {
    if (_self.continent == null) {
      return null;
    }

    return $ContinentCopyWith<$Res>(_self.continent!, (value) {
      return _then(_self.copyWith(continent: value));
    });
  }
}

/// @nodoc
mixin _$City {
  String get name;

  /// Create a copy of City
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CityCopyWith<City> get copyWith =>
      _$CityCopyWithImpl<City>(this as City, _$identity);

  /// Serializes this City to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is City &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'City(name: $name)';
  }
}

/// @nodoc
abstract mixin class $CityCopyWith<$Res> {
  factory $CityCopyWith(City value, $Res Function(City) _then) =
      _$CityCopyWithImpl;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$CityCopyWithImpl<$Res> implements $CityCopyWith<$Res> {
  _$CityCopyWithImpl(this._self, this._then);

  final City _self;
  final $Res Function(City) _then;

  /// Create a copy of City
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _City implements City {
  const _City({required this.name});
  factory _City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  @override
  final String name;

  /// Create a copy of City
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CityCopyWith<_City> get copyWith =>
      __$CityCopyWithImpl<_City>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _City &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'City(name: $name)';
  }
}

/// @nodoc
abstract mixin class _$CityCopyWith<$Res> implements $CityCopyWith<$Res> {
  factory _$CityCopyWith(_City value, $Res Function(_City) _then) =
      __$CityCopyWithImpl;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$CityCopyWithImpl<$Res> implements _$CityCopyWith<$Res> {
  __$CityCopyWithImpl(this._self, this._then);

  final _City _self;
  final $Res Function(_City) _then;

  /// Create a copy of City
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
  }) {
    return _then(_City(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Subdivisions {
  String get code;
  String get name;

  /// Create a copy of Subdivisions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubdivisionsCopyWith<Subdivisions> get copyWith =>
      _$SubdivisionsCopyWithImpl<Subdivisions>(
          this as Subdivisions, _$identity);

  /// Serializes this Subdivisions to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Subdivisions &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, name);

  @override
  String toString() {
    return 'Subdivisions(code: $code, name: $name)';
  }
}

/// @nodoc
abstract mixin class $SubdivisionsCopyWith<$Res> {
  factory $SubdivisionsCopyWith(
          Subdivisions value, $Res Function(Subdivisions) _then) =
      _$SubdivisionsCopyWithImpl;
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class _$SubdivisionsCopyWithImpl<$Res> implements $SubdivisionsCopyWith<$Res> {
  _$SubdivisionsCopyWithImpl(this._self, this._then);

  final Subdivisions _self;
  final $Res Function(Subdivisions) _then;

  /// Create a copy of Subdivisions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Subdivisions implements Subdivisions {
  const _Subdivisions({required this.code, required this.name});
  factory _Subdivisions.fromJson(Map<String, dynamic> json) =>
      _$SubdivisionsFromJson(json);

  @override
  final String code;
  @override
  final String name;

  /// Create a copy of Subdivisions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubdivisionsCopyWith<_Subdivisions> get copyWith =>
      __$SubdivisionsCopyWithImpl<_Subdivisions>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubdivisionsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Subdivisions &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, name);

  @override
  String toString() {
    return 'Subdivisions(code: $code, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$SubdivisionsCopyWith<$Res>
    implements $SubdivisionsCopyWith<$Res> {
  factory _$SubdivisionsCopyWith(
          _Subdivisions value, $Res Function(_Subdivisions) _then) =
      __$SubdivisionsCopyWithImpl;
  @override
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class __$SubdivisionsCopyWithImpl<$Res>
    implements _$SubdivisionsCopyWith<$Res> {
  __$SubdivisionsCopyWithImpl(this._self, this._then);

  final _Subdivisions _self;
  final $Res Function(_Subdivisions) _then;

  /// Create a copy of Subdivisions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_Subdivisions(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Country {
  String get code;
  String get name;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CountryCopyWith<Country> get copyWith =>
      _$CountryCopyWithImpl<Country>(this as Country, _$identity);

  /// Serializes this Country to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Country &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, name);

  @override
  String toString() {
    return 'Country(code: $code, name: $name)';
  }
}

/// @nodoc
abstract mixin class $CountryCopyWith<$Res> {
  factory $CountryCopyWith(Country value, $Res Function(Country) _then) =
      _$CountryCopyWithImpl;
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class _$CountryCopyWithImpl<$Res> implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._self, this._then);

  final Country _self;
  final $Res Function(Country) _then;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Country implements Country {
  const _Country({required this.code, required this.name});
  factory _Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  @override
  final String code;
  @override
  final String name;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CountryCopyWith<_Country> get copyWith =>
      __$CountryCopyWithImpl<_Country>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CountryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Country &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, name);

  @override
  String toString() {
    return 'Country(code: $code, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$CountryCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$CountryCopyWith(_Country value, $Res Function(_Country) _then) =
      __$CountryCopyWithImpl;
  @override
  @useResult
  $Res call({String code, String name});
}

/// @nodoc
class __$CountryCopyWithImpl<$Res> implements _$CountryCopyWith<$Res> {
  __$CountryCopyWithImpl(this._self, this._then);

  final _Country _self;
  final $Res Function(_Country) _then;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
    Object? name = null,
  }) {
    return _then(_Country(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Continent {
  String get code;

  /// Create a copy of Continent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContinentCopyWith<Continent> get copyWith =>
      _$ContinentCopyWithImpl<Continent>(this as Continent, _$identity);

  /// Serializes this Continent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Continent &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code);

  @override
  String toString() {
    return 'Continent(code: $code)';
  }
}

/// @nodoc
abstract mixin class $ContinentCopyWith<$Res> {
  factory $ContinentCopyWith(Continent value, $Res Function(Continent) _then) =
      _$ContinentCopyWithImpl;
  @useResult
  $Res call({String code});
}

/// @nodoc
class _$ContinentCopyWithImpl<$Res> implements $ContinentCopyWith<$Res> {
  _$ContinentCopyWithImpl(this._self, this._then);

  final Continent _self;
  final $Res Function(Continent) _then;

  /// Create a copy of Continent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
  }) {
    return _then(_self.copyWith(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Continent implements Continent {
  const _Continent({required this.code});
  factory _Continent.fromJson(Map<String, dynamic> json) =>
      _$ContinentFromJson(json);

  @override
  final String code;

  /// Create a copy of Continent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContinentCopyWith<_Continent> get copyWith =>
      __$ContinentCopyWithImpl<_Continent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContinentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Continent &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code);

  @override
  String toString() {
    return 'Continent(code: $code)';
  }
}

/// @nodoc
abstract mixin class _$ContinentCopyWith<$Res>
    implements $ContinentCopyWith<$Res> {
  factory _$ContinentCopyWith(
          _Continent value, $Res Function(_Continent) _then) =
      __$ContinentCopyWithImpl;
  @override
  @useResult
  $Res call({String code});
}

/// @nodoc
class __$ContinentCopyWithImpl<$Res> implements _$ContinentCopyWith<$Res> {
  __$ContinentCopyWithImpl(this._self, this._then);

  final _Continent _self;
  final $Res Function(_Continent) _then;

  /// Create a copy of Continent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
  }) {
    return _then(_Continent(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$DeviceInfo {
  String get userAgent;
  String get platform;
  String get vendor;
  String get browser;
  String get connection;
  String get language;
  bool get cookieEnabled;
  int get screenWidth;
  int get screenHeight;
  int get screenColorDepth;
  double get devicePixelRatio;
  int get timezoneOffset;
  String get cpuArchitecture;
  String get fontFamily;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeviceInfoCopyWith<DeviceInfo> get copyWith =>
      _$DeviceInfoCopyWithImpl<DeviceInfo>(this as DeviceInfo, _$identity);

  /// Serializes this DeviceInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeviceInfo &&
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

  @override
  String toString() {
    return 'DeviceInfo(userAgent: $userAgent, platform: $platform, vendor: $vendor, browser: $browser, connection: $connection, language: $language, cookieEnabled: $cookieEnabled, screenWidth: $screenWidth, screenHeight: $screenHeight, screenColorDepth: $screenColorDepth, devicePixelRatio: $devicePixelRatio, timezoneOffset: $timezoneOffset, cpuArchitecture: $cpuArchitecture, fontFamily: $fontFamily)';
  }
}

/// @nodoc
abstract mixin class $DeviceInfoCopyWith<$Res> {
  factory $DeviceInfoCopyWith(
          DeviceInfo value, $Res Function(DeviceInfo) _then) =
      _$DeviceInfoCopyWithImpl;
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
class _$DeviceInfoCopyWithImpl<$Res> implements $DeviceInfoCopyWith<$Res> {
  _$DeviceInfoCopyWithImpl(this._self, this._then);

  final DeviceInfo _self;
  final $Res Function(DeviceInfo) _then;

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
    return _then(_self.copyWith(
      userAgent: null == userAgent
          ? _self.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _self.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      vendor: null == vendor
          ? _self.vendor
          : vendor // ignore: cast_nullable_to_non_nullable
              as String,
      browser: null == browser
          ? _self.browser
          : browser // ignore: cast_nullable_to_non_nullable
              as String,
      connection: null == connection
          ? _self.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      cookieEnabled: null == cookieEnabled
          ? _self.cookieEnabled
          : cookieEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      screenWidth: null == screenWidth
          ? _self.screenWidth
          : screenWidth // ignore: cast_nullable_to_non_nullable
              as int,
      screenHeight: null == screenHeight
          ? _self.screenHeight
          : screenHeight // ignore: cast_nullable_to_non_nullable
              as int,
      screenColorDepth: null == screenColorDepth
          ? _self.screenColorDepth
          : screenColorDepth // ignore: cast_nullable_to_non_nullable
              as int,
      devicePixelRatio: null == devicePixelRatio
          ? _self.devicePixelRatio
          : devicePixelRatio // ignore: cast_nullable_to_non_nullable
              as double,
      timezoneOffset: null == timezoneOffset
          ? _self.timezoneOffset
          : timezoneOffset // ignore: cast_nullable_to_non_nullable
              as int,
      cpuArchitecture: null == cpuArchitecture
          ? _self.cpuArchitecture
          : cpuArchitecture // ignore: cast_nullable_to_non_nullable
              as String,
      fontFamily: null == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _DeviceInfo implements DeviceInfo {
  const _DeviceInfo(
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
  factory _DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);

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

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeviceInfoCopyWith<_DeviceInfo> get copyWith =>
      __$DeviceInfoCopyWithImpl<_DeviceInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DeviceInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeviceInfo &&
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

  @override
  String toString() {
    return 'DeviceInfo(userAgent: $userAgent, platform: $platform, vendor: $vendor, browser: $browser, connection: $connection, language: $language, cookieEnabled: $cookieEnabled, screenWidth: $screenWidth, screenHeight: $screenHeight, screenColorDepth: $screenColorDepth, devicePixelRatio: $devicePixelRatio, timezoneOffset: $timezoneOffset, cpuArchitecture: $cpuArchitecture, fontFamily: $fontFamily)';
  }
}

/// @nodoc
abstract mixin class _$DeviceInfoCopyWith<$Res>
    implements $DeviceInfoCopyWith<$Res> {
  factory _$DeviceInfoCopyWith(
          _DeviceInfo value, $Res Function(_DeviceInfo) _then) =
      __$DeviceInfoCopyWithImpl;
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
class __$DeviceInfoCopyWithImpl<$Res> implements _$DeviceInfoCopyWith<$Res> {
  __$DeviceInfoCopyWithImpl(this._self, this._then);

  final _DeviceInfo _self;
  final $Res Function(_DeviceInfo) _then;

  /// Create a copy of DeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_DeviceInfo(
      userAgent: null == userAgent
          ? _self.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _self.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      vendor: null == vendor
          ? _self.vendor
          : vendor // ignore: cast_nullable_to_non_nullable
              as String,
      browser: null == browser
          ? _self.browser
          : browser // ignore: cast_nullable_to_non_nullable
              as String,
      connection: null == connection
          ? _self.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      cookieEnabled: null == cookieEnabled
          ? _self.cookieEnabled
          : cookieEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      screenWidth: null == screenWidth
          ? _self.screenWidth
          : screenWidth // ignore: cast_nullable_to_non_nullable
              as int,
      screenHeight: null == screenHeight
          ? _self.screenHeight
          : screenHeight // ignore: cast_nullable_to_non_nullable
              as int,
      screenColorDepth: null == screenColorDepth
          ? _self.screenColorDepth
          : screenColorDepth // ignore: cast_nullable_to_non_nullable
              as int,
      devicePixelRatio: null == devicePixelRatio
          ? _self.devicePixelRatio
          : devicePixelRatio // ignore: cast_nullable_to_non_nullable
              as double,
      timezoneOffset: null == timezoneOffset
          ? _self.timezoneOffset
          : timezoneOffset // ignore: cast_nullable_to_non_nullable
              as int,
      cpuArchitecture: null == cpuArchitecture
          ? _self.cpuArchitecture
          : cpuArchitecture // ignore: cast_nullable_to_non_nullable
              as String,
      fontFamily: null == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on

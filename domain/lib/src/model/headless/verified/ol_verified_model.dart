import 'package:freezed_annotation/freezed_annotation.dart';

part 'ol_verified_model.freezed.dart';
part 'ol_verified_model.g.dart';

@freezed
class OLVerifiedModel with _$OLVerifiedModel {
  const factory OLVerifiedModel({
    required String responseType,
    required VerifiedResponse response,
    required int statusCode,
    required bool success,
  }) = _OLVerifiedModel;

  factory OLVerifiedModel.fromJson(Map<String, dynamic> json) =>
      _$OLVerifiedModelFromJson(json);
}

@freezed
class VerifiedResponse with _$VerifiedResponse {
  const factory VerifiedResponse({
    Map<String, dynamic>? firebaseInfo,
    required String token,
    required String status,
    required String userId,
    required String timestamp,
    required List<Identity> identities,
    required String idToken,
    Network? network,
    DeviceInfo? deviceInfo,
    Map<String, dynamic>? sessionInfo,
  }) = _VerifiedResponse;

  factory VerifiedResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifiedResponseFromJson(json);
}

@freezed
class Identity with _$Identity {
  const factory Identity({
    required String identityType,
    required String identityValue,
    required String channel,
    required List<String> methods,
    required bool verified,
    required String verifiedAt,
  }) = _Identity;

  factory Identity.fromJson(Map<String, dynamic> json) =>
      _$IdentityFromJson(json);
}

@freezed
class Network with _$Network {
  const factory Network({
    required String ip,
    required String timezone,
    IPLocation? ipLocation,
  }) = _Network;

  factory Network.fromJson(Map<String, dynamic> json) =>
      _$NetworkFromJson(json);
}

@freezed
class IPLocation with _$IPLocation {
  const factory IPLocation({
    City? city,
    Subdivisions? subdivisions,
    Country? country,
    Continent? continent,
    double? latitude,
    double? longitude,
    String? postalCode,
  }) = _IPLocation;

  factory IPLocation.fromJson(Map<String, dynamic> json) =>
      _$IPLocationFromJson(json);
}

@freezed
class City with _$City {
  const factory City({
    required String name,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}

@freezed
class Subdivisions with _$Subdivisions {
  const factory Subdivisions({
    required String code,
    required String name,
  }) = _Subdivisions;

  factory Subdivisions.fromJson(Map<String, dynamic> json) =>
      _$SubdivisionsFromJson(json);
}

@freezed
class Country with _$Country {
  const factory Country({
    required String code,
    required String name,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}

@freezed
class Continent with _$Continent {
  const factory Continent({
    required String code,
  }) = _Continent;

  factory Continent.fromJson(Map<String, dynamic> json) =>
      _$ContinentFromJson(json);
}

@freezed
class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    required String userAgent,
    required String platform,
    required String vendor,
    required String browser,
    required String connection,
    required String language,
    required bool cookieEnabled,
    required int screenWidth,
    required int screenHeight,
    required int screenColorDepth,
    required double devicePixelRatio,
    required int timezoneOffset,
    required String cpuArchitecture,
    required String fontFamily,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ol_verified_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OLVerifiedModel _$OLVerifiedModelFromJson(Map<String, dynamic> json) =>
    _OLVerifiedModel(
      responseType: json['responseType'] as String,
      response:
          VerifiedResponse.fromJson(json['response'] as Map<String, dynamic>),
      statusCode: (json['statusCode'] as num).toInt(),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$OLVerifiedModelToJson(_OLVerifiedModel instance) =>
    <String, dynamic>{
      'responseType': instance.responseType,
      'response': instance.response,
      'statusCode': instance.statusCode,
      'success': instance.success,
    };

_VerifiedResponse _$VerifiedResponseFromJson(Map<String, dynamic> json) =>
    _VerifiedResponse(
      firebaseInfo: json['firebaseInfo'] as Map<String, dynamic>?,
      token: json['token'] as String,
      status: json['status'] as String,
      userId: json['userId'] as String,
      timestamp: json['timestamp'] as String,
      identities: (json['identities'] as List<dynamic>)
          .map((e) => Identity.fromJson(e as Map<String, dynamic>))
          .toList(),
      idToken: json['idToken'] as String,
      network: json['network'] == null
          ? null
          : Network.fromJson(json['network'] as Map<String, dynamic>),
      deviceInfo: json['deviceInfo'] == null
          ? null
          : DeviceInfo.fromJson(json['deviceInfo'] as Map<String, dynamic>),
      sessionInfo: json['sessionInfo'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$VerifiedResponseToJson(_VerifiedResponse instance) =>
    <String, dynamic>{
      'firebaseInfo': instance.firebaseInfo,
      'token': instance.token,
      'status': instance.status,
      'userId': instance.userId,
      'timestamp': instance.timestamp,
      'identities': instance.identities,
      'idToken': instance.idToken,
      'network': instance.network,
      'deviceInfo': instance.deviceInfo,
      'sessionInfo': instance.sessionInfo,
    };

_Identity _$IdentityFromJson(Map<String, dynamic> json) => _Identity(
      identityType: json['identityType'] as String,
      identityValue: json['identityValue'] as String,
      channel: json['channel'] as String,
      methods:
          (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
      verified: json['verified'] as bool,
      verifiedAt: json['verifiedAt'] as String,
    );

Map<String, dynamic> _$IdentityToJson(_Identity instance) => <String, dynamic>{
      'identityType': instance.identityType,
      'identityValue': instance.identityValue,
      'channel': instance.channel,
      'methods': instance.methods,
      'verified': instance.verified,
      'verifiedAt': instance.verifiedAt,
    };

_Network _$NetworkFromJson(Map<String, dynamic> json) => _Network(
      ip: json['ip'] as String,
      timezone: json['timezone'] as String,
      ipLocation: json['ipLocation'] == null
          ? null
          : IPLocation.fromJson(json['ipLocation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkToJson(_Network instance) => <String, dynamic>{
      'ip': instance.ip,
      'timezone': instance.timezone,
      'ipLocation': instance.ipLocation,
    };

_IPLocation _$IPLocationFromJson(Map<String, dynamic> json) => _IPLocation(
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      subdivisions: json['subdivisions'] == null
          ? null
          : Subdivisions.fromJson(json['subdivisions'] as Map<String, dynamic>),
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      continent: json['continent'] == null
          ? null
          : Continent.fromJson(json['continent'] as Map<String, dynamic>),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      postalCode: json['postalCode'] as String?,
    );

Map<String, dynamic> _$IPLocationToJson(_IPLocation instance) =>
    <String, dynamic>{
      'city': instance.city,
      'subdivisions': instance.subdivisions,
      'country': instance.country,
      'continent': instance.continent,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'postalCode': instance.postalCode,
    };

_City _$CityFromJson(Map<String, dynamic> json) => _City(
      name: json['name'] as String,
    );

Map<String, dynamic> _$CityToJson(_City instance) => <String, dynamic>{
      'name': instance.name,
    };

_Subdivisions _$SubdivisionsFromJson(Map<String, dynamic> json) =>
    _Subdivisions(
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SubdivisionsToJson(_Subdivisions instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

_Country _$CountryFromJson(Map<String, dynamic> json) => _Country(
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CountryToJson(_Country instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

_Continent _$ContinentFromJson(Map<String, dynamic> json) => _Continent(
      code: json['code'] as String,
    );

Map<String, dynamic> _$ContinentToJson(_Continent instance) =>
    <String, dynamic>{
      'code': instance.code,
    };

_DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => _DeviceInfo(
      userAgent: json['userAgent'] as String,
      platform: json['platform'] as String,
      vendor: json['vendor'] as String,
      browser: json['browser'] as String,
      connection: json['connection'] as String,
      language: json['language'] as String,
      cookieEnabled: json['cookieEnabled'] as bool,
      screenWidth: (json['screenWidth'] as num).toInt(),
      screenHeight: (json['screenHeight'] as num).toInt(),
      screenColorDepth: (json['screenColorDepth'] as num).toInt(),
      devicePixelRatio: (json['devicePixelRatio'] as num).toDouble(),
      timezoneOffset: (json['timezoneOffset'] as num).toInt(),
      cpuArchitecture: json['cpuArchitecture'] as String,
      fontFamily: json['fontFamily'] as String,
    );

Map<String, dynamic> _$DeviceInfoToJson(_DeviceInfo instance) =>
    <String, dynamic>{
      'userAgent': instance.userAgent,
      'platform': instance.platform,
      'vendor': instance.vendor,
      'browser': instance.browser,
      'connection': instance.connection,
      'language': instance.language,
      'cookieEnabled': instance.cookieEnabled,
      'screenWidth': instance.screenWidth,
      'screenHeight': instance.screenHeight,
      'screenColorDepth': instance.screenColorDepth,
      'devicePixelRatio': instance.devicePixelRatio,
      'timezoneOffset': instance.timezoneOffset,
      'cpuArchitecture': instance.cpuArchitecture,
      'fontFamily': instance.fontFamily,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ol_verified_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OLVerifiedModelImpl _$$OLVerifiedModelImplFromJson(
        Map<String, dynamic> json) =>
    _$OLVerifiedModelImpl(
      responseType: json['responseType'] as String,
      response:
          VerifiedResponse.fromJson(json['response'] as Map<String, dynamic>),
      statusCode: (json['statusCode'] as num).toInt(),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$$OLVerifiedModelImplToJson(
        _$OLVerifiedModelImpl instance) =>
    <String, dynamic>{
      'responseType': instance.responseType,
      'response': instance.response,
      'statusCode': instance.statusCode,
      'success': instance.success,
    };

_$VerifiedResponseImpl _$$VerifiedResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$VerifiedResponseImpl(
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

Map<String, dynamic> _$$VerifiedResponseImplToJson(
        _$VerifiedResponseImpl instance) =>
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

_$IdentityImpl _$$IdentityImplFromJson(Map<String, dynamic> json) =>
    _$IdentityImpl(
      identityType: json['identityType'] as String,
      identityValue: json['identityValue'] as String,
      channel: json['channel'] as String,
      methods:
          (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
      verified: json['verified'] as bool,
      verifiedAt: json['verifiedAt'] as String,
    );

Map<String, dynamic> _$$IdentityImplToJson(_$IdentityImpl instance) =>
    <String, dynamic>{
      'identityType': instance.identityType,
      'identityValue': instance.identityValue,
      'channel': instance.channel,
      'methods': instance.methods,
      'verified': instance.verified,
      'verifiedAt': instance.verifiedAt,
    };

_$NetworkImpl _$$NetworkImplFromJson(Map<String, dynamic> json) =>
    _$NetworkImpl(
      ip: json['ip'] as String,
      timezone: json['timezone'] as String,
      ipLocation: json['ipLocation'] == null
          ? null
          : IPLocation.fromJson(json['ipLocation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$NetworkImplToJson(_$NetworkImpl instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'timezone': instance.timezone,
      'ipLocation': instance.ipLocation,
    };

_$IPLocationImpl _$$IPLocationImplFromJson(Map<String, dynamic> json) =>
    _$IPLocationImpl(
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

Map<String, dynamic> _$$IPLocationImplToJson(_$IPLocationImpl instance) =>
    <String, dynamic>{
      'city': instance.city,
      'subdivisions': instance.subdivisions,
      'country': instance.country,
      'continent': instance.continent,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'postalCode': instance.postalCode,
    };

_$CityImpl _$$CityImplFromJson(Map<String, dynamic> json) => _$CityImpl(
      name: json['name'] as String,
    );

Map<String, dynamic> _$$CityImplToJson(_$CityImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

_$SubdivisionsImpl _$$SubdivisionsImplFromJson(Map<String, dynamic> json) =>
    _$SubdivisionsImpl(
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$SubdivisionsImplToJson(_$SubdivisionsImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

_$CountryImpl _$$CountryImplFromJson(Map<String, dynamic> json) =>
    _$CountryImpl(
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$CountryImplToJson(_$CountryImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

_$ContinentImpl _$$ContinentImplFromJson(Map<String, dynamic> json) =>
    _$ContinentImpl(
      code: json['code'] as String,
    );

Map<String, dynamic> _$$ContinentImplToJson(_$ContinentImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
    };

_$DeviceInfoImpl _$$DeviceInfoImplFromJson(Map<String, dynamic> json) =>
    _$DeviceInfoImpl(
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

Map<String, dynamic> _$$DeviceInfoImplToJson(_$DeviceInfoImpl instance) =>
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

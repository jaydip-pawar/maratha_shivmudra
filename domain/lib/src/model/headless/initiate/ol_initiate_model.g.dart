// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ol_initiate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OLInitiateModelImpl _$$OLInitiateModelImplFromJson(
        Map<String, dynamic> json) =>
    _$OLInitiateModelImpl(
      responseType: json['responseType'] as String,
      success: json['success'] as bool,
      statusCode: (json['statusCode'] as num).toInt(),
      response:
          InitiateResponse.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OLInitiateModelImplToJson(
        _$OLInitiateModelImpl instance) =>
    <String, dynamic>{
      'responseType': instance.responseType,
      'success': instance.success,
      'statusCode': instance.statusCode,
      'response': instance.response,
    };

_$InitiateResponseImpl _$$InitiateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$InitiateResponseImpl(
      requestID: json['requestID'] as String?,
      verification: json['verification'] as String?,
      errorMessage: json['errorMessage'] as String?,
      deliveryChannel: (json['deliveryChannel'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      authType: json['authType'] as String?,
      channel: json['channel'] as String?,
    );

Map<String, dynamic> _$$InitiateResponseImplToJson(
        _$InitiateResponseImpl instance) =>
    <String, dynamic>{
      'requestID': instance.requestID,
      'verification': instance.verification,
      'errorMessage': instance.errorMessage,
      'deliveryChannel': instance.deliveryChannel,
      'authType': instance.authType,
      'channel': instance.channel,
    };

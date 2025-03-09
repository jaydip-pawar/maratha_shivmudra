// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ol_initiate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OLInitiateModel _$OLInitiateModelFromJson(Map<String, dynamic> json) =>
    _OLInitiateModel(
      responseType: json['responseType'] as String,
      success: json['success'] as bool,
      statusCode: (json['statusCode'] as num).toInt(),
      response:
          InitiateResponse.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OLInitiateModelToJson(_OLInitiateModel instance) =>
    <String, dynamic>{
      'responseType': instance.responseType,
      'success': instance.success,
      'statusCode': instance.statusCode,
      'response': instance.response,
    };

_InitiateResponse _$InitiateResponseFromJson(Map<String, dynamic> json) =>
    _InitiateResponse(
      requestID: json['requestID'] as String?,
      verification: json['verification'] as String?,
      errorMessage: json['errorMessage'] as String?,
      deliveryChannel: (json['deliveryChannel'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      authType: json['authType'] as String?,
      channel: json['channel'] as String?,
    );

Map<String, dynamic> _$InitiateResponseToJson(_InitiateResponse instance) =>
    <String, dynamic>{
      'requestID': instance.requestID,
      'verification': instance.verification,
      'errorMessage': instance.errorMessage,
      'deliveryChannel': instance.deliveryChannel,
      'authType': instance.authType,
      'channel': instance.channel,
    };

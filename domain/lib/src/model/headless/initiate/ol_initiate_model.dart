import 'package:freezed_annotation/freezed_annotation.dart';

part 'ol_initiate_model.freezed.dart';
part 'ol_initiate_model.g.dart';

@freezed
class OLInitiateModel with _$OLInitiateModel {
  const factory OLInitiateModel({
    required String responseType,
    required bool success,
    required int statusCode,
    required InitiateResponse response,
  }) = _OLInitiateModel;

  factory OLInitiateModel.fromJson(Map<String, dynamic> json) =>
      _$OLInitiateModelFromJson(json);
}

@freezed
class InitiateResponse with _$InitiateResponse {
  const factory InitiateResponse({
    String? requestID,
    String? verification,
    String? errorMessage,
    List<String>? deliveryChannel,
    String? authType,
    String? channel,
  }) = _InitiateResponse;

  factory InitiateResponse.fromJson(Map<String, dynamic> json) =>
      _$InitiateResponseFromJson(json);
}

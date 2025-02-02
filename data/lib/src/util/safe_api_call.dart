import 'dart:io';

import 'package:data/src/entity/remote/error/error_entity.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:retrofit/retrofit.dart';

Future<Either<NetworkError, T>> safeApiCall<T>(Future<T> apiCall) async {
  try {
    final originalResponse = await apiCall;
    final eitherResponse = originalResponse as HttpResponse<dynamic>;

    if (eitherResponse.response.statusCode == 200) {
      return right(originalResponse);
    } else {
      if (eitherResponse.response.data != null) {
        try {
          final ErrorEntity errorResponseEntity =
              ErrorEntity.fromJson(eitherResponse.response.data);
          return left(
            NetworkError(
              httpError: errorResponseEntity.code,
              message: errorResponseEntity.message,
              cause: Exception("Server Response Error"),
            ),
          );
        } catch (exception) {
          // exception.printStackTrace();
          return left(
            NetworkError(
              cause: Exception("Server Response Error"),
              httpError: eitherResponse.response.statusCode ?? 404,
              message: eitherResponse.response.statusMessage ?? '',
            ),
          );
        }
      } else {
        return left(
          NetworkError(
            cause: Exception("Server Response Error"),
            httpError: eitherResponse.response.statusCode ?? 404,
            message: eitherResponse.response.statusMessage ?? '',
          ),
        );
      }
    }
  } on DioException catch (e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return left(
          NetworkError(
            message: 'Connection timeout with API server',
            httpError: 504,
            cause: e,
          ),
        );
      case DioExceptionType.sendTimeout:
        return left(
          NetworkError(
            message: 'Send timeout exception',
            httpError: 504,
            cause: e,
          ),
        );
      case DioExceptionType.receiveTimeout:
        return left(
          NetworkError(
            message: 'Receive timeout in connection with API server',
            httpError: 504,
            cause: e,
          ),
        );
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
      case DioExceptionType.cancel:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return left(
          NetworkError(
            message: 'Unknown error',
            httpError: 502,
            cause: e,
          ),
        );
    }
  } on IOException catch (e) {
    return left(
      NetworkError(
        message: e.toString(),
        httpError: 502,
        cause: e,
      ),
    );
  }
  // on HttpException catch (e) {
  //   return left(NetworkError(message: e.message, httpError: 502, cause: e));
  // } catch (e) {
  //   return left(NetworkError(message: e.toString(), httpError: 502, cause: e));
  // }
}

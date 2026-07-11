import 'dart:io';

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

Future<Either<NetworkError, T>> safeApiCall<T>(Future<T> apiCall) async {
  try {
    final originalResponse = await apiCall;

    return right(originalResponse);
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
        final data = e.response?.data;

        final details = data['Details'];
        final code = details == 'OTP Mismatch' ? 1001 : 502;
        return left(NetworkError(message: details, httpError: code, cause: e));

      case DioExceptionType.cancel:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return left(
          NetworkError(message: 'Unknown error', httpError: 502, cause: e),
        );
    }
  } on IOException catch (e) {
    return left(NetworkError(message: e.toString(), httpError: 502, cause: e));
  }
  // on HttpException catch (e) {
  //   return left(NetworkError(message: e.message, httpError: 502, cause: e));
  // } catch (e) {
  //   return left(NetworkError(message: e.toString(), httpError: 502, cause: e));
  // }
}

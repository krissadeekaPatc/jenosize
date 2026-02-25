import 'package:jenosize/domain/core/app_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppError.fromError', () {
    test('should return the same AppError if passed an AppError', () {
      const originalError = AppError(
        message: 'Original error',
        statusCode: 400,
      );

      final result = AppError.from(originalError);

      expect(result, originalError);
    });

    test(
      'should return an AppError with the response message for DioExceptionType.badResponse',
      () {
        final requestOptions = RequestOptions(
          path: 'https://example.com/test',
          method: 'GET',
        );

        final response = Response(
          requestOptions: requestOptions,
          statusCode: 404,
          data: {'message': 'Not Found'},
        );

        final dioError = DioException(
          requestOptions: requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Some default message',
        );

        final appError = AppError.from(dioError);

        expect(appError.message, equals('Not Found'));
      },
    );

    test(
      'should return an AppError with message "No Internet" for DioExceptionType.unknown with SocketException',
      () {
        final requestOptions = RequestOptions(
          path: 'https://example.com/test',
          method: 'GET',
        );

        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.unknown,
          message: 'SocketException: connection failed',
        );

        final appError = AppError.from(dioError);

        expect(appError.message, equals('No Internet'));
      },
    );

    test(
      'should return an AppError with message from error.toString() for non-Dio errors',
      () {
        final genericError = Exception('Some error occurred');

        final appError = AppError.from(genericError);

        expect(appError.message, equals(genericError.toString()));
      },
    );
  });
}

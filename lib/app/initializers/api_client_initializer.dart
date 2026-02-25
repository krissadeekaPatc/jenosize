import 'package:jenosize/app/env.dart';
import 'package:jenosize/common/curl_logger.dart';
import 'package:jenosize/data/api_client/api_client_impl.dart';
import 'package:jenosize/domain/api_client/api_client.dart';
import 'package:jenosize/domain/storages/token_vault.dart';
import 'package:jenosize/ui/cubits/app_language_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

ApiClient initializeApiClient({
  required TokenVault tokenVault,
  required AppLanguageCubit appLanguageCubit,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.baseUrl,
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(seconds: 45),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await tokenVault.getAccessToken();
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        } else {
          options.headers.remove('Authorization');
        }

        final languageCode = appLanguageCubit.state.languageCode;
        options.headers['Accept-Language'] = languageCode;

        if (kDebugMode) {
          CurlLogger.log(options);
        }

        return handler.next(options);
      },
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
      ),
    );
  }

  return ApiClientImpl(dio);
}

ApiClient initializeExternalApiClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.baseUrl,
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(seconds: 45),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        if (kDebugMode) {
          CurlLogger.log(options);
        }

        return handler.next(options);
      },
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
      ),
    );
  }

  return ApiClientImpl(dio);
}

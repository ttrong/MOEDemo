import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:moe_cfims/infrastructure/core/hive_box_names.dart';

const _defaultConnectTimeout = 3000;
const _defaultReceiveTimeout = 3000;

class DioClient {
  final String baseUrl = dotenv.env['API_URL'] ?? '';
  final Dio _dio = Dio();
  final List<Interceptor> interceptors;

  String? token = Hive.box(BoxNames.settingsBox).get(BoxKeys.currentToken) as String;
  String? typeLogin = Hive.box(BoxNames.settingsBox).get(BoxKeys.currentTypeLogin) as String;

  DioClient(this.interceptors) {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout as Duration
      ..options.receiveTimeout = _defaultReceiveTimeout as Duration
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
    if (token?.isNotEmpty ?? false) {
      _dio.options.headers['Authorization'] = "Bearer $token";
    }
    if (typeLogin?.isNotEmpty ?? false) {
      _dio.options.headers['login_type'] = "$typeLogin";
    }
    if (interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(responseBody: true, error: true, requestHeader: false, responseHeader: false, request: false, requestBody: false));
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}

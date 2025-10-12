
// lib/core/network/interceptors/logging_interceptor.dart
import 'package:dio/dio.dart';
import '../../utils/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.debug(
      'REQUEST[${options.method}] => ${options.uri}',
      tag: 'HTTP',
      data: {
        'headers': options.headers,
        'data': options.data,
        'queryParameters': options.queryParameters,
      },
    );
    handler.next(options);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.info(
      'RESPONSE[${response.statusCode}] => ${response.requestOptions.uri}',
      tag: 'HTTP',
      data: response.data,
    );
    handler.next(response);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger.error(
      'ERROR[${err.response?.statusCode}] => ${err.requestOptions.uri}',
      tag: 'HTTP',
      error: {
        'type': err.type,
        'message': err.message,
        'data': err.response?.data,
      },
    );
    handler.next(err);
  }
}
import 'package:dio/dio.dart';
import 'package:ricknotmorty/core/services/logger/app_logger.dart';

/// An interceptor for logging network requests, responses, and errors in the application.
///
/// This interceptor provides detailed logging of HTTP interactions using the [AppLogger] mixin,
/// capturing request details, response status, and any encountered errors during network operations.
class LoggingInterceptor extends Interceptor with AppLogger {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log.severe('Request: ${options.method} ${options.uri}');
    log.severe('Headers: ${options.headers}');
    log.severe('Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log.severe('Response: ${response.statusCode} ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log.severe('Error: ${err.message}');
    super.onError(err, handler);
  }
}

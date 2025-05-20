import 'package:dio/dio.dart';
import 'package:ricknotmorty/core/routing/router.dart';
import 'package:ricknotmorty/core/routing/router.gr.dart';

/// An interceptor for handling network-related errors in Dio HTTP requests.
///
/// This interceptor specifically manages different types of network exceptions
/// and can redirect to a network error route when certain connection or timeout
/// errors occur.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, handler) async {
    switch (err.type) {
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.unknown:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
        if (router.current.name != NetworkErrorRoute.name) {
          router.push(const NetworkErrorRoute());
        }
        break;
      default:
        break;
    }

    handler.next(err);
  }
}

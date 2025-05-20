import 'package:dio/dio.dart';
import 'package:ricknotmorty/core/app/app_constants.dart';

/// An interceptor for managing and setting the base URL for network requests.
///
/// This interceptor automatically sets the base URL for outgoing HTTP requests
/// using the environment-specific URL from [AppConstants].
class HostInterceptor extends Interceptor {
  @override
  void onRequest(options, handler) async {
    options.baseUrl = AppConstants.environment.url;
    handler.next(options);
  }
}

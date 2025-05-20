import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ricknotmorty/core/app/app_constants.dart';
import 'package:ricknotmorty/core/network/dio/interceptors/host_intercepter.dart';
import 'package:ricknotmorty/core/network/dio/interceptors/logging_interceptor.dart';

/// An abstract base class for creating and configuring Dio HTTP clients
/// with custom interceptors and timeout settings.
///
/// This class provides a standardized way to initialize Dio instances
/// with predefined options and interceptors for network requests.
abstract class DioClient {
  late Dio dio;
  DioClient() {
    dio = createDio(
      BaseOptions(
        receiveTimeout: const Duration(milliseconds: 60000),
        connectTimeout: const Duration(milliseconds: 60000),
        sendTimeout: const Duration(milliseconds: 60000),
        validateStatus: (status) {
          return true;
        },
      ),
    );
  }

  Dio createDio(BaseOptions baseOptions) {
    final dio = Dio(baseOptions);
    dio.interceptors.addAll([
      HostInterceptor(),
      LoggingInterceptor(),
      if (AppConstants.debugRequests)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
        ),
    ]);

    return dio;
  }
}

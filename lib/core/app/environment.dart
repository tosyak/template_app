import 'package:ricknotmorty/core/app/app_constants.dart';

/// An enumeration representing different deployment environments for the application.
///
/// Provides configuration for different API base URLs and environment-specific utilities.
/// Supports development, production, and pre-production environments with their respective base URLs.
///
/// Allows checking if the current environment is development and resetting to a default environment.
enum Environment {
  development("https://rickandmortyapi.com/api/"),
  production("https://rickandmortyapi.com/api/"),
  preprod("https://rickandmortyapi.com/api/");

  const Environment(this.url);

  /// Base request url of the environment. [HostInterceptor] uses this value
  /// to set Dio request url host.
  final String url;

  bool get isDev => this == Environment.development;

  /// Resets environment to it's default value.
  static void reset() {
    AppConstants.environment = AppConstants.defaultEnvironment;
  }
}

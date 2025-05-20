import 'dart:core';

import 'package:ricknotmorty/core/app/environment.dart';

class AppConstants {
  /// Dynamic environment variable to determine request hosts.
  /// When store user logged in, this variable changes to development.
  /// When change user triggered, this variable changes according to
  /// [defaultEnvironment].
  ///
  /// ***Should be same with default environment.***
  ///

  static Environment environment = Environment.development;

  /// Application's default environment. Used to determine which environment
  /// should use after change user.
  ///
  /// This is a constant variable, never changes according to conditions.
  ///
  /// Set this variable to prod before production releases.
  ///
  /// {@macro Constants.env}
  static const defaultEnvironment = Environment.development;

  /// Sets dio requests printed to console or not.
  static const debugRequests = false;

  /// Controls the security of the application enabled or not.
  static const enableSecurity = false;

  ///FingerPrints for security certificates
  static const List<String> fingerPrints = [];
}

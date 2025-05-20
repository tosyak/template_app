import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:ricknotmorty/core/app/app_constants.dart';
import 'package:ricknotmorty/core/app/platform_feature_initializer.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';
import 'package:ricknotmorty/core/services/analytics_service/analytics_service.dart';

/// A service implementation for Firebase Analytics that handles event logging, screen view tracking, and user property management.
///
/// This service provides methods to log analytics events, screen views, and set user properties
/// while respecting the platform's service availability and development environment constraints.
///
/// Implements [AnalyticsService] to provide a consistent analytics interface with Firebase-specific implementations.
class FirebaseAnalyticsService implements AnalyticsService {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsService();

  bool get _canSendAnalytics =>
      getIt<PlatformServiceInterface>().isGServiceAvailable &&
      AppConstants.environment.isDev;

  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    if (!_canSendAnalytics) return;
    await analytics.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    if (!_canSendAnalytics) return;
    await analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }

  @override
  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    if (!_canSendAnalytics) return;
    await analytics.setUserProperty(name: name, value: value);
  }

  @override
  Future<void> setUserId(String? userId) async {
    if (!_canSendAnalytics) return;
    await analytics.setUserId(id: userId);
  }
}

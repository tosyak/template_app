import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:ricknotmorty/core/error/exceptions.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';
import 'package:ricknotmorty/core/services/firebase_service/firebase_service.dart';
import 'package:ricknotmorty/core/services/logger/app_logger.dart';
import 'package:ricknotmorty/core/services/notification_service/firebase_notification_service.dart';

class PlatformServiceInitializer with AppLogger {
  static Future<void> initializePlatformFeatures() async {
    // Get platform service from GetIt
    final platformService = getIt<PlatformServiceInterface>();

    try {
      await platformService.initialize();
    } catch (e) {
      final log = AppLogger.staticLog('AppInitializerError');
      // Handle platform initialization errors properly
      log.severe('Platform initialization failed: $e');
      // Potentially log to analytics or show appropriate UI
    }
  }

  // Helper method to check if Google Services are available anywhere in the app
  static bool get isGServiceAvailable {
    try {
      return getIt<PlatformServiceInterface>().isGServiceAvailable;
    } catch (e) {
      // If service isn't initialized yet
      return false;
    }
  }
}

abstract class PlatformServiceInterface {
  Future<bool> initialize();
  bool get isGServiceAvailable;
}

class GoogleServicesChecker {
  Future<bool> checkAvailability() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final availability = await GoogleApiAvailability.instance
          .checkGooglePlayServicesAvailability();
      return availability == GooglePlayServicesAvailability.success;
    }
    return defaultTargetPlatform == TargetPlatform.iOS;
  }
}

class AndroidPlatformService implements PlatformServiceInterface {
  final FirebaseService _firebaseService;
  final GoogleServicesChecker _googleServicesChecker;
  bool _isGServiceAvailable = false;

  AndroidPlatformService({
    required FirebaseService firebaseService,
    required GoogleServicesChecker googleServicesChecker,
  })  : _firebaseService = firebaseService,
        _googleServicesChecker = googleServicesChecker;

  @override
  bool get isGServiceAvailable => _isGServiceAvailable;

  @override
  Future<bool> initialize() async {
    _isGServiceAvailable = await _googleServicesChecker.checkAvailability();

    if (!_isGServiceAvailable) {
      throw PlatformFeatureException('Google Play Services unavailable');
    }

    await _firebaseService.initialize();
    await getIt<NotificationService>().initialize();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    return _isGServiceAvailable;
  }
}

class IOSPlatformService implements PlatformServiceInterface {
  final FirebaseService _firebaseService;
  final GoogleServicesChecker _googleServicesChecker;
  bool _isGServiceAvailable = false;

  IOSPlatformService({
    required FirebaseService firebaseService,
    required GoogleServicesChecker googleServicesChecker,
  })  : _firebaseService = firebaseService,
        _googleServicesChecker = googleServicesChecker;

  @override
  bool get isGServiceAvailable => _isGServiceAvailable;

  @override
  Future<bool> initialize() async {
    _isGServiceAvailable = await _googleServicesChecker.checkAvailability();
    await _firebaseService.initialize();
    await getIt<NotificationService>().initialize();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    return _isGServiceAvailable;
  }
}

class WebPlatformService implements PlatformServiceInterface {
  @override
  bool get isGServiceAvailable => false;

  @override
  Future<bool> initialize() async {
    // Web-specific initialization if needed
    return false;
  }
}

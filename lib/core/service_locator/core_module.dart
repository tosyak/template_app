import 'package:app_links/app_links.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:ricknotmorty/core/app/platform_feature_initializer.dart';
import 'package:ricknotmorty/core/data_base/app_preferences.dart';
import 'package:ricknotmorty/core/routing/router.dart';
import 'package:ricknotmorty/core/services/analytics_service/analytics_service.dart';
import 'package:ricknotmorty/core/services/analytics_service/firebase_analytics.dart';
import 'package:ricknotmorty/core/services/crashlytics_service/crashlytics_service.dart';
import 'package:ricknotmorty/core/services/deep_link_service/deep_link_service.dart';
import 'package:ricknotmorty/core/services/firebase_service/firebase_service.dart';
import 'package:ricknotmorty/core/services/notification_service/firebase_notification_service.dart';
import 'package:ricknotmorty/core/utils/debouncer.dart';
import 'package:ricknotmorty/data/data_sources/local/shared_prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreModule {
  static final GetIt _getIt = GetIt.instance;

  static Future<void> register() async {
    // Register infrastructure components
    await _registerInfrastructure();

    // Register platform-specific services
    _registerPlatformServices();
  }

  static Future<void> _registerInfrastructure() async {
    // Shared preferences
    _getIt.registerSingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance(),
    );
    _getIt.registerSingletonWithDependencies<AppPreferences>(
      () => SharedPrefsManager(_getIt<SharedPreferences>()),
      dependsOn: [SharedPreferences],
    );

    // Core services
    _getIt.registerSingleton<AppRouter>(AppRouter());
    _getIt.registerSingleton<Connectivity>(Connectivity());
    _getIt.registerLazySingleton<Debouncer>(() => Debouncer());
    _getIt.registerLazySingleton<CacheManager>(
      () => CacheManager(
        Config('characterImageCacheKey', stalePeriod: const Duration(days: 7)),
      ),
    );

    // Firebase services
    _getIt.registerLazySingleton<FirebaseService>(() => FirebaseService());
    _getIt.registerLazySingleton<GoogleServicesChecker>(
      () => GoogleServicesChecker(),
    );
    _getIt.registerLazySingleton<CrashlyticsService>(
      () => FirebaseCrashlyticsService(),
    );
    _getIt.registerLazySingleton<NotificationService>(
      () => NotificationService(),
    );
    _getIt.registerLazySingleton<AnalyticsService>(
      () => FirebaseAnalyticsService(),
    );

    // Deep linking
    _getIt.registerLazySingleton<DeepLinkService>(
      () => AppLinksService(AppLinks())..initialize(),
    );
  }

  static void _registerPlatformServices() {
    if (kIsWeb) {
      // Web-specific services
      _getIt.registerLazySingleton<PlatformServiceInterface>(
        () => WebPlatformService(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      // Android-specific services
      _getIt.registerLazySingleton<PlatformServiceInterface>(
        () => AndroidPlatformService(
          firebaseService: _getIt<FirebaseService>(),
          googleServicesChecker: _getIt<GoogleServicesChecker>(),
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      // iOS-specific services
      _getIt.registerLazySingleton<PlatformServiceInterface>(
        () => IOSPlatformService(
          firebaseService: _getIt<FirebaseService>(),
          googleServicesChecker: _getIt<GoogleServicesChecker>(),
        ),
      );
    } else {
      // Fallback to web services for other platforms
      _getIt.registerLazySingleton<PlatformServiceInterface>(
        () => WebPlatformService(),
      );
    }
  }
}

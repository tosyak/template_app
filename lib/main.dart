import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ricknotmorty/core/app/platform_feature_initializer.dart';
import 'package:ricknotmorty/core/data_base/app_preferences.dart';
import 'package:ricknotmorty/core/error/global_error_handler.dart';
import 'package:ricknotmorty/core/localization/app_localizations_enum.dart';
import 'package:ricknotmorty/core/localization/app_localizations_setup.dart';
import 'package:ricknotmorty/core/localization/locale_cubit/cubit/locale_cubit.dart';
import 'package:ricknotmorty/core/providers/global_provider.dart';
import 'package:ricknotmorty/core/routing/router.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';
import 'package:ricknotmorty/core/services/analytics_service/analytics_auto_route_observer.dart';
import 'package:ricknotmorty/core/services/analytics_service/analytics_service.dart';
import 'package:ricknotmorty/core/services/connectivity_checker/lifecycle_observer.dart';
import 'package:ricknotmorty/core/services/connectivity_checker/security_checker.dart';
import 'package:ricknotmorty/core/services/logger/app_logger.dart';
import 'package:ricknotmorty/core/shared/themes/theme.dart';
import 'package:ricknotmorty/core/shared/themes/theme_cubit/theme_cubit.dart';

void main() {
  GlobalErrorHandler(
    builder: () async {
      WidgetsFlutterBinding.ensureInitialized();

      await ServiceLocator.registerDependencies();
      await PlatformServiceInitializer.initializePlatformFeatures();
      initializeLogger();

      final appPreferences = getIt<AppPreferences>();
      String? selectedLanguage = await appPreferences.locale;
      if (selectedLanguage == null || selectedLanguage.isEmpty) {
        selectedLanguage = AppLocalizationEnum.ru.label;
        appPreferences.saveLocale(selectedLanguage);
      }
      return GlobalProvider(
        userLocale: selectedLanguage,
        child: const AppRoot(),
      );
    },
  );
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late final AnalyticsAutoRouteObserver analyticsObserver;

  @override
  void initState() {
    super.initState();
    final AnalyticsService analyticsService = getIt<AnalyticsService>();
    analyticsObserver = AnalyticsAutoRouteObserver(analyticsService);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              final themeMode = themeState is GetThemeState
                  ? themeState.theme
                  : ThemeMode.system;
              return MaterialApp.router(
                title: 'RickNotMorty',
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: themeMode,
                routerDelegate: AutoRouterDelegate(
                  router,
                  navigatorObservers: () => [analyticsObserver],
                ),
                routeInformationParser: router.defaultRouteParser(),
                locale: state.locale,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                localizationsDelegates:
                    AppLocalizationsSetup.localizationsDelegates,
                localeResolutionCallback:
                    AppLocalizationsSetup.localeResolutionCallback,
                builder: (context, child) {
                  final MediaQueryData data = MediaQuery.of(context);
                  return MediaQuery(
                    data: data.copyWith(
                      textScaler: TextScaler.linear(
                        data.textScaler.scale(1) > 1.5 ? 1.5 : 1,
                      ),
                    ),
                    child: LifecycleObserver(
                      child: SecurityChecker(
                        child: child!,
                        //  ConnectionChecker(child: child!),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

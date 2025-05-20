import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricknotmorty/core/localization/locale_cubit/cubit/locale_cubit.dart';
import 'package:ricknotmorty/core/localization/locale_cubit/data/locale_datasource.dart';
import 'package:ricknotmorty/core/localization/locale_cubit/data/locale_repository.dart';
import 'package:ricknotmorty/core/shared/themes/theme_cubit/theme_cubit.dart';
import 'package:ricknotmorty/features/splash/bloc/splash_bloc.dart';

/// A widget that provides global providers for the application.
///
/// This widget sets up multiple BlocProviders for theme, locale, and splash functionality,
/// and wraps the child widget with these providers. It allows centralized management
/// of application-wide state and configuration.
///
/// [child] is the widget to be wrapped with global providers.
/// [userLocale] is the initial locale setting for the application.
class GlobalProvider extends StatelessWidget {
  const GlobalProvider({
    super.key,
    required this.child,
    required this.userLocale,
  });

  final Widget child;
  final String userLocale;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<LanguageRepository>(
      create: (context) => LanguageRepositoryImpl(
        remoteDataSource: LanguageDataSourceImpl(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit()..getTheme(),
          ),
          BlocProvider<LocaleCubit>(
            create: (context) => LocaleCubit(
              langRepository: context.read<LanguageRepository>(),
              locale: userLocale,
            )..initialize(),
          ),
          BlocProvider(
            create: (context) => SplashBloc()..add(SplashEventStarted()),
          ),
        ],
        child: child,
      ),
    );
  }
}

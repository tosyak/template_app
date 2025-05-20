import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricknotmorty/core/data_base/app_preferences.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(InitialState()) {
    getTheme();
  }

  Future<void> changeTheme(ThemeMode theme) async {
    final prefs = getIt<AppPreferences>();
    await prefs.saveThemeMode(theme);
    _setSystemOverlayStyle(theme);
    emit(GetThemeState(theme));
  }

  Future<void> getTheme() async {
    final prefs = getIt<AppPreferences>();
    final theme = await prefs.themeMode;
    _setSystemOverlayStyle(theme);
    emit(GetThemeState(theme));
  }

  void _setSystemOverlayStyle(ThemeMode theme) {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final isDark = theme == ThemeMode.dark ||
        (theme == ThemeMode.system && brightness == Brightness.dark);

    SystemChrome.setSystemUIOverlayStyle(
      isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
    );
  }
}

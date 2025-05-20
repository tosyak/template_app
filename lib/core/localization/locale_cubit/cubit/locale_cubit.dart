import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricknotmorty/core/data_base/app_preferences.dart';
import 'package:ricknotmorty/core/localization/app_localizations_enum.dart';
import 'package:ricknotmorty/core/localization/locale_cubit/data/locale_repository.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';

/// A Cubit responsible for managing the application's locale state and language preferences.
///
/// This cubit handles saving, initializing, and updating the application's language settings.
/// It interacts with [LanguageRepository] to retrieve language lists and [AppPreferences]
/// to persist locale selections.
///
/// Emits [SelectedLocale] states to represent the current locale configuration.

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit({required this.langRepository, required String locale})
      : super(SelectedLocale(Locale(locale)));

  final LanguageRepository langRepository;

  Future<void> saveLanguages() async {
    final appPreferences = getIt<AppPreferences>();
    final val = await appPreferences.locale;

    final languages = await langRepository.getLanguageList();

    for (var entry in languages.entries) {
      final langCode = entry.key;
      final localizations = json.encode(entry.value);
      appPreferences.saveLanguageByCode(langCode, localizations);
    }

    if (val != null && val.isNotEmpty) emit(SelectedLocale(Locale(val)));
  }

  Future<void> initialize() async {
    await saveLanguages();
  }

  Future<void> update(AppLocalizationEnum locale) async {
    emit(SelectedLocale(Locale(locale.label)));
    await getIt<AppPreferences>().saveLocale(locale.label);
  }
}

abstract class LocaleState {
  final Locale locale;
  const LocaleState(this.locale);
}

class SelectedLocale extends LocaleState {
  const SelectedLocale(super.locale);
}

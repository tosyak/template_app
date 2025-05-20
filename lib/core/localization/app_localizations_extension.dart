import 'package:flutter/widgets.dart';
import 'package:ricknotmorty/core/localization/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  String translate(String key) {
    return AppLocalizations.of(this)?.translate(key) ?? key;
  }
}

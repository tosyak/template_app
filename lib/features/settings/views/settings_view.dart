import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ricknotmorty/core/localization/app_localizations.dart';
import 'package:ricknotmorty/core/localization/app_localizations_enum.dart';
import 'package:ricknotmorty/core/localization/app_localizations_extension.dart';
import 'package:ricknotmorty/core/localization/locale_cubit/cubit/locale_cubit.dart';
import 'package:ricknotmorty/core/routing/router.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';
import 'package:ricknotmorty/core/services/analytics_service/analytics_service.dart';
import 'package:ricknotmorty/core/shared/themes/theme_cubit/theme_cubit.dart';

class SettingsScreenView extends StatefulWidget {
  const SettingsScreenView({super.key});

  @override
  SettingsScreenViewState createState() => SettingsScreenViewState();
}

class SettingsScreenViewState extends State<SettingsScreenView> {
  final AnalyticsService _analyticsService = getIt<AnalyticsService>();
  bool isDark = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isDark = Theme.of(context).brightness == Brightness.dark;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String titleLang = AppLocalizationEnum.values
        .firstWhere(
          (e) =>
              e.label ==
              AppLocalizations.of(context)!.currentLocale.toLowerCase(),
        )
        .labelFull;

    return Scaffold(
      appBar: AppBar(title: Text(context.translate('settings'))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.translate('language')),
                ElevatedButton(
                  key: UniqueKey(),
                  onPressed: () async {
                    await LangSelectSheet.showLangs(context);
                    _analyticsService.logEvent(name: 'change_lang');
                    setState(() {});
                  },
                  child: Text(titleLang),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.translate('theme')),
                Switch(
                  value: isDark,
                  onChanged: (bool value) {
                    context.read<ThemeCubit>().changeTheme(
                          !isDark ? ThemeMode.dark : ThemeMode.light,
                        );
                    setState(() {
                      isDark = value;
                    });
                    _analyticsService.logEvent(
                      name: 'change_theme',
                      parameters: {'theme': value ? 'dark' : 'light'},
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LangSelectSheet {
  static Future<void> showLangs(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.translate('language')),
              SizedBox(height: 27.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppLocalizationEnum.values.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final localeEnum = AppLocalizationEnum.values[index];
                  final titleLang = localeEnum.labelFull;
                  final title = localeEnum.label;

                  return RadioListTile<String>(
                    title: Text(titleLang),
                    value: title,
                    groupValue: AppLocalizations.of(context)!
                        .currentLocale
                        .toLowerCase(),
                    onChanged: (value) async {
                      router.maybePop(title);
                      await context.read<LocaleCubit>().update(localeEnum);
                    },
                  );
                },
                separatorBuilder: (context, _) => SizedBox(height: 10.h),
              ),
              SizedBox(height: 22.h),
            ],
          ),
        );
      },
    );
  }
}

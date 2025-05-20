import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ricknotmorty/features/settings/views/settings_view.dart';

@RoutePage(name: "SettingsRoute")
class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings-route';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreenView();
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ricknotmorty/core/localization/app_localizations_extension.dart';
import 'package:ricknotmorty/core/routing/router.dart';
import 'package:ricknotmorty/features/widgets/error_dialog.dart';

@RoutePage(name: "NetworkErrorRoute")
class NetworkErrorDialog extends StatelessWidget {
  static const routeName = '/network-error-dialog';
  const NetworkErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorDialog(
      errorDescription: context.translate('no-internet-connection'),
      onTap: () => router.maybePop(),
    );
  }
}

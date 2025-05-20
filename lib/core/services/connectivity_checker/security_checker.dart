import 'package:flutter/material.dart';
import 'package:ricknotmorty/core/app/app_constants.dart';
import 'package:ricknotmorty/core/localization/app_localizations_extension.dart';
import 'package:ricknotmorty/core/security/security_mobile_check.dart';
import 'package:ricknotmorty/core/security/threat.dart';
import 'package:ricknotmorty/features/widgets/error_dialog.dart';

/// A widget that performs security checks on the application before rendering its child widget.
///
/// This widget checks for potential security threats such as installation source,
/// device type, device authenticity, and developer mode status. If a significant
/// threat is detected, it can display a warning or error dialog.
class SecurityChecker extends StatefulWidget {
  const SecurityChecker({required this.child, super.key});

  final Widget child;

  @override
  State<SecurityChecker> createState() => _SecurityCheckerState();
}

class _SecurityCheckerState extends State<SecurityChecker> {
  Threat? _threat;

  @override
  void initState() {
    super.initState();
    () async {
      if (AppConstants.enableSecurity) {
        try {
          await checkInstallationSource();
          await checkDeviceType();
          await checkDeviceAuthenticity();
          await checkDeveloperMode();
        } on Threat catch (threat) {
          _setThreat(threat);
        }
      }
    }();
  }

  void _setThreat(Threat threat) {
    if (_threat == threat) return;

    bool shouldUpdate =
        !(_threat != null && threat.severity.index <= _threat!.severity.index);
    if (shouldUpdate) setState(() => _threat = threat);
  }

  Widget _buildThreatDialog() {
    return Container(
      color: Colors.black.withAlpha(122),
      child: ErrorDialog(
        errorDescription: context.translate(_threat!.message),
        errorType: !_threat!.severity.shouldBlockApp
            ? ErrorType.warning
            : ErrorType.error,
        hasButton: !_threat!.severity.shouldBlockApp,
        errorButtonLabel: context.translate('continue'),
        onTap: () => setState(() => _threat = null),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_threat == null) return widget.child;

    return Stack(
      fit: StackFit.expand,
      children: [widget.child, _buildThreatDialog()],
    );
  }
}

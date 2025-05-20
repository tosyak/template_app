import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:protect_app/protect_app.dart';
import 'package:ricknotmorty/core/security/threat.dart' as app_threat;
import 'package:store_checker/store_checker.dart';

/// Checks if the current device is a physical device or a simulator.
///
/// Throws an [app_threat.Threat.simulator] if the device is running on a simulator
/// for either Android or iOS platforms.
///
/// This method is part of the device security validation process.
Future<void> checkDeviceType() async {
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    if (!androidInfo.isPhysicalDevice) throw app_threat.Threat.simulator;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    if (!iosInfo.isPhysicalDevice) throw app_threat.Threat.simulator;
  }
}

/// Checks if the device is jailbroken (iOS) or rooted (Android).
///
/// Verifies the device's integrity by checking if it has been compromised through
/// jailbreaking or rooting. If the device is found to be jailbroken or rooted,
/// it throws a corresponding [app_threat.Threat] based on the platform.
///
/// Throws [app_threat.Threat.jailbreak] for iOS devices or [app_threat.Threat.root] for Android
/// if the device is detected as jailbroken or rooted.
Future<void> checkDeviceAuthenticity() async {
  bool? isBroken;
  try {
    isBroken = await ProtectApp().isUseJailBrokenOrRoot();
  } catch (_) {
    isBroken = false;
  }

  if (isBroken != null && isBroken) {
    throw Platform.isIOS ? app_threat.Threat.jailbreak : app_threat.Threat.root;
  }
}

/// Checks if the device's developer mode is enabled.
///
/// Verifies the device's security by detecting if developer mode is active.
/// If developer mode is detected, it throws a [app_threat.Threat.developerMode] threat.
///
/// This method is part of the device security validation process.
Future<void> checkDeveloperMode() async {
  bool? developerMode;
  try {
    developerMode = await ProtectApp().checkIsTheDeveloperModeOn();
  } catch (_) {
    developerMode = false;
  }
  if (developerMode != null && developerMode) {
    throw app_threat.Threat.developerMode;
  }
}

/// Verifies the application's installation source for security purposes.
///
/// Checks if the app is installed from a trusted source such as official app stores.
/// If the installation source is not recognized as trusted, it throws a
/// [app_threat.Threat.untrustedInstallation] threat.
///
/// Allowed installation sources include App Store, TestFlight, Play Store,
/// and Huawei App Gallery. Any other source is considered untrusted.
///
/// Throws [app_threat.Threat.untrustedInstallation] if the app is installed
/// from an unrecognized or potentially unsafe source.
Future<void> checkInstallationSource() async {
  Source installationSource;

  try {
    installationSource = await StoreChecker.getSource;
  } catch (_) {
    return;
  }

  final allowedSources = [
    Source.IS_INSTALLED_FROM_APP_STORE,
    Source.IS_INSTALLED_FROM_TEST_FLIGHT,
    Source.IS_INSTALLED_FROM_PLAY_STORE,
    Source.IS_INSTALLED_FROM_HUAWEI_APP_GALLERY,
  ];

  if (!allowedSources.contains(installationSource)) {
    throw app_threat.Threat.untrustedInstallation;
  }
}

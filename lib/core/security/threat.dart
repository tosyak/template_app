/// Represents different types of security threats that can be detected on a device.
///
/// Each threat is associated with a [Severity] level and a localization message key
/// that can be used to display appropriate warnings or take preventive actions.
///
/// Threats include scenarios like rooted/jailbroken devices, developer mode,
/// untrusted installations, and simulator environments.
enum Threat {
  root(Severity.minor, "rooted-device-message"),
  developerMode(Severity.low, "developer-mode-message"),
  jailbreak(Severity.critical, "jailbroken-device-message"),
  untrustedInstallation(Severity.critical, "invalid-store-message"),
  simulator(Severity.critical, "physical-device-messaage");

  const Threat(this.severity, this.message);

  final Severity severity;
  final String message;
}

/// Represents the severity levels of security threats.
///
/// Provides an enumeration of threat severity with an additional method
/// to determine if the threat is severe enough to block an application.
///
/// The severity levels are ordered from least to most critical:
/// [low], [minor], and [critical].
enum Severity {
  low,
  minor,
  critical;

  bool get shouldBlockApp => index >= Severity.critical.index;
}

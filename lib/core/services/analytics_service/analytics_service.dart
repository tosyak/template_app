/// A service for tracking and logging analytics events, screen views, and user properties.
/// 
/// This abstract class defines the contract for analytics tracking in the application,
/// allowing for flexible implementation of different analytics providers.
abstract class AnalyticsService {
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  });
  Future<void> logScreenView({required String screenName, String? screenClass});
  Future<void> setUserProperty({required String name, required String? value});
  Future<void> setUserId(String? userId);
}

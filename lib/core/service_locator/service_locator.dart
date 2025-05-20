import 'package:get_it/get_it.dart';
import 'package:ricknotmorty/core/service_locator/character_module.dart';
import 'package:ricknotmorty/core/service_locator/core_module.dart';

final GetIt getIt = GetIt.instance;

/// Manages dependency injection and service registration for the application.
///
/// This class provides a centralized way to register and access dependencies
/// across different modules of the application using the GetIt service locator.
class ServiceLocator {
  static Future<void> registerDependencies() async {
    // Register core dependencies
    await CoreModule.register();

    // Register feature-specific dependencies
    await CharacterModule.register();

    // Ensure all async registrations are complete
    await getIt.allReady();
  }
}

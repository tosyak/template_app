import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ricknotmorty/core/data_base/app_preferences.dart';
import 'package:ricknotmorty/core/routing/router.dart';
import 'package:ricknotmorty/data/data_sources/local/shared_prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockConnectivity extends Mock implements Connectivity {}

class MockAppRouter extends Mock implements AppRouter {}

void main() {
  final getIt = GetIt.instance;

  setUp(() async {
    await getIt.reset();
  });

  test('setupServices registers all dependencies', () async {
    final mockSharedPreferences = MockSharedPreferences();
    final mockConnectivity = MockConnectivity();
    final mockAppRouter = MockAppRouter();

    getIt.registerSingletonAsync<SharedPreferences>(
      () async => mockSharedPreferences,
    );

    getIt.registerSingletonWithDependencies<AppPreferences>(
      () => SharedPrefsManager(getIt<SharedPreferences>()),
      dependsOn: [SharedPreferences],
    );

    getIt.registerSingleton<Connectivity>(mockConnectivity);
    getIt.registerSingleton<AppRouter>(mockAppRouter);

    await getIt.allReady();

    expect(getIt.isRegistered<SharedPreferences>(), isTrue);
    expect(getIt.isRegistered<AppPreferences>(), isTrue);
    expect(getIt.isRegistered<Connectivity>(), isTrue);
    expect(getIt.isRegistered<AppRouter>(), isTrue);
  });
}

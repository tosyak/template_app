import 'package:get_it/get_it.dart';
import 'package:ricknotmorty/data/data_sources/local/character_local_data_source.dart';
import 'package:ricknotmorty/data/data_sources/remote/characters_data_source.dart';
import 'package:ricknotmorty/data/repositories/character_repository_impl.dart';
import 'package:ricknotmorty/domain/repositories/character_repository.dart';
import 'package:ricknotmorty/domain/usecases/get_character_usecase.dart';
import 'package:ricknotmorty/features/characters_list/bloc/characters_bloc.dart';
import 'package:ricknotmorty/features/favorites_list/bloc/favorites_bloc.dart';

class CharacterModule {
  static final GetIt _getIt = GetIt.instance;

  static Future<void> register() async {
    _registerDataSources();
    _registerRepositories();
    _registerUseCases();
    _registerBlocs();
  }

  static void _registerDataSources() {
    _getIt.registerLazySingleton<CharacterRemoteDataSource>(
      () => CharacterRemoteDataSourceImpl(),
    );

    _getIt.registerLazySingleton<CharacterLocalDataSource>(
      () => CharacterLocalDataSourceImpl(),
    );
  }

  static void _registerRepositories() {
    _getIt.registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(
        remoteDataSource: _getIt<CharacterRemoteDataSource>(),
        localDataSource: _getIt<CharacterLocalDataSource>(),
      ),
    );
  }

  static void _registerUseCases() {
    _getIt.registerLazySingleton<GetCharactersUseCase>(
      () => GetCharactersUseCase(
        repository: _getIt<CharacterRepository>(),
      ),
    );
  }

  static void _registerBlocs() {
    _getIt.registerFactory<CharactersBloc>(
      () => CharactersBloc(usecase: _getIt<GetCharactersUseCase>()),
    );
    _getIt.registerFactory<FavoritesBloc>(
      () => FavoritesBloc(usecase: _getIt<GetCharactersUseCase>()),
    );
  }
}

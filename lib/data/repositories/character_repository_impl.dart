import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:ricknotmorty/core/error/exceptions.dart';
import 'package:ricknotmorty/core/error/failures.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';
import 'package:ricknotmorty/data/data_sources/local/character_local_data_source.dart';
import 'package:ricknotmorty/data/data_sources/remote/characters_data_source.dart';
import 'package:ricknotmorty/data/mapper/characters_mapper.dart';
import 'package:ricknotmorty/data/models/character_model/character_model.dart';
import 'package:ricknotmorty/domain/entities/character_entity.dart';
import 'package:ricknotmorty/domain/entities/info_entity.dart';
import 'package:ricknotmorty/domain/repositories/character_repository.dart';

/// Implementation of the [CharacterRepository] for retrieving and managing character data
/// across local and remote data sources.
///
/// This repository handles fetching characters with support for various filtering
/// options and manages caching and connectivity-based data retrieval strategies.
class CharacterRepositoryImpl extends CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;
  final CharacterLocalDataSource localDataSource;

  static const cacheDuration = Duration(hours: 1);

  CharacterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, CharacterResponse>> getCharactersList({
    required int page,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    try {
      final connectivity = getIt<Connectivity>();
      final onlineResult = await connectivity.checkConnectivity();
      final isConnected = !onlineResult.contains(ConnectivityResult.none);

      if (isConnected) {
        final remoteResponse = await remoteDataSource.getCharactersList(
          page: page,
          name: name,
          status: status,
          species: species,
          type: type,
          gender: gender,
        );
        final characters = CharacterResponseMapper.toEntity(remoteResponse);

        await localDataSource.cacheCharacters(remoteResponse.results);

        return Right(characters);
      } else {
        final totalCount = await localDataSource.getCharactersCount(
          name: name,
          status: status,
          species: species,
          type: type,
          gender: gender,
        );
        final pageSize = 20;
        final totalPages = (totalCount / pageSize).ceil();

        final List<CharacterModel> localCharacters =
            await localDataSource.getCharacters(
          page: page,
          name: name,
          status: status,
          species: species,
          type: type,
          gender: gender,
          limit: pageSize,
        );

        if (localCharacters.isEmpty) {
          return Left(CacheFailure('No cached data available'));
        }

        final characters = CharacterMapper.toEntity(localCharacters);

        final String? nextPage = page < totalPages ? 'page=${page + 1}' : null;
        final String? prevPage = page > 1 ? 'page=${page - 1}' : null;

        return Right(
          CharacterResponse(
            info: Info(
              count: totalCount,
              pages: totalPages,
              next: nextPage,
              prev: prevPage,
            ),
            results: characters,
          ),
        );
      }
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, e.statusCode));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on AppDatabaseException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getFavoriteIds() async {
    try {
      final ids = await localDataSource.getFavoriteIds();
      return Right(ids);
    } on AppDatabaseException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(int id) async {
    try {
      await localDataSource.addFavorite(id);
      return const Right(null);
    } on AppDatabaseException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(int id) async {
    try {
      await localDataSource.removeFavorite(id);
      return const Right(null);
    } on AppDatabaseException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getFavoriteCharactersList() async {
    try {
      final favoriteIds = await localDataSource.getFavoriteIds();

      if (favoriteIds.isEmpty) {
        return const Right([]);
      }

      final connectivity = getIt<Connectivity>();
      final onlineResult = await connectivity.checkConnectivity();
      final isConnected = !onlineResult.contains(ConnectivityResult.none);

      if (isConnected) {
        final remoteCharacters =
            await remoteDataSource.getFavoriteCharacters(ids: favoriteIds);

        await localDataSource.cacheCharacters(remoteCharacters);

        final characters = CharacterMapper.toEntity(remoteCharacters);

        return Right(characters);
      } else {
        final localCharacters =
            await localDataSource.getFavoriteCharactersList();

        if (localCharacters.isEmpty) {
          return Left(CacheFailure('No cached favorites available'));
        }

        final characters = CharacterMapper.toEntity(localCharacters);

        return Right(characters);
      }
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, e.statusCode));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on AppDatabaseException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:ricknotmorty/core/error/exceptions.dart';
import 'package:ricknotmorty/core/error/failures.dart';
import 'package:ricknotmorty/data/data_sources/remote/episode_data_source.dart';
import 'package:ricknotmorty/data/mapper/episode_mapper.dart';
import 'package:ricknotmorty/data/models/episode_model/episode_model.dart';
import 'package:ricknotmorty/domain/entities/episode_entity.dart';
import 'package:ricknotmorty/domain/repositories/episode_repository.dart';

/// Implementation of the [EpisodesRepository] interface for fetching episode data.
///
/// This repository handles retrieving episode information from a remote data source
/// and converts the raw data models to domain entities.
class EpisodesRepositoryImpl implements EpisodesRepository {
  final EpisodesRemoteDataSource remoteDataSource;

  EpisodesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, EpisodeResponse>> getEpisodes({
    required int page,
  }) async {
    try {
      final EpisodeResponseModel episodeResponse =
          await remoteDataSource.getEpisodes(page: page);

      final EpisodeResponse events = EpisodeMapper.toEntity(episodeResponse);

      return Right(events);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, e.statusCode));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}

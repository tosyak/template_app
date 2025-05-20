import 'package:dartz/dartz.dart';
import 'package:ricknotmorty/core/error/failures.dart';
import 'package:ricknotmorty/domain/entities/episode_entity.dart';

/// Repository for managing episodes in the application.
///
/// Provides methods for retrieving episode data from a data source.

abstract class EpisodesRepository {
  Future<Either<Failure, EpisodeResponse>> getEpisodes({required int page});
}

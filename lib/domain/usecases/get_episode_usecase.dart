import 'package:dartz/dartz.dart';
import 'package:ricknotmorty/core/error/failures.dart';
import 'package:ricknotmorty/domain/entities/episode_entity.dart';
import 'package:ricknotmorty/domain/repositories/episode_repository.dart';

/// Use case for retrieving episodes from the repository
///
/// This use case handles fetching episodes with pagination support
/// and returns either a failure or a successful episode response.
class GetEpisodesUseCase {
  final EpisodesRepository repository;

  GetEpisodesUseCase({required this.repository});

  Future<Either<Failure, EpisodeResponse>> call({required int page}) async {
    return await repository.getEpisodes(page: page);
  }
}

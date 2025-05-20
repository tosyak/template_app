import 'package:graphql/client.dart';
import 'package:ricknotmorty/core/error/exceptions.dart' as error;
import 'package:ricknotmorty/core/network/graphql/graphql_queries.dart';
import 'package:ricknotmorty/data/models/episode_model/episode_model.dart';

/// Abstract data source for retrieving episodes from a remote source
///
/// This interface defines the contract for fetching episode data from a remote API
/// and allows for different implementations of remote episode data retrieval

abstract class EpisodesRemoteDataSource {
  Future<EpisodeResponseModel> getEpisodes({required int page});
}

class EpisodesRemoteDataSourceImpl implements EpisodesRemoteDataSource {
  final GraphQLClient graphQLClient;

  EpisodesRemoteDataSourceImpl({required this.graphQLClient});

  @override
  Future<EpisodeResponseModel> getEpisodes({required int page}) async {
    final options = QueryOptions(
      document: gql(GraphQLQueries.episodesQuery),
      variables: {'page': page},
    );

    final result = await graphQLClient.query(options);

    if (result.hasException) {
      if (result.exception!.linkException != null) {
        throw error.NetworkException(result.exception.toString());
      } else {
        throw error.ServerException(result.exception.toString());
      }
    }

    final episodesData = result.data?['episodes'];
    return EpisodeResponseModel.fromJson(episodesData);
  }
}

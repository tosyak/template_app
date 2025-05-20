import 'package:graphql/client.dart';

/// A utility class for managing GraphQL clients in the application.
/// 
/// Provides static methods for creating and configuring GraphQL client instances
/// used for network communication with GraphQL APIs.
class GraphQLClients {
  static GraphQLClient client() {
    return GraphQLClient(
      link: HttpLink('https://rickandmortyapi.com/graphql'),
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }
}

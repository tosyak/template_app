/// A utility class containing GraphQL query definitions for retrieving episodes data.
/// 
/// This class provides static GraphQL query strings used for fetching episode-related 
/// information from the GraphQL API, such as episode details, pagination info, etc.
class GraphQLQueries {
  static const String episodesQuery = '''
    query Episodes(\$page: Int) {
      episodes(page: \$page) {
        info {
          count
          pages
          next
          pages
        }
        results {
          id
          name
          air_date
          episode
          created
        }
      }
    }
  ''';
}

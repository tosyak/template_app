import 'package:dio/dio.dart';
import 'package:ricknotmorty/core/error/exceptions.dart';
import 'package:ricknotmorty/core/network/dio/dio_client.dart';
import 'package:ricknotmorty/data/models/character_model/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<CharacterResponseModel> getCharactersList({
    required int page,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  });

  Future<List<CharacterModel>> getFavoriteCharacters({required List<int> ids});
}

class CharacterRemoteDataSourceImpl extends DioClient
    implements CharacterRemoteDataSource {
  CharacterRemoteDataSourceImpl();

  @override
  Future<CharacterResponseModel> getCharactersList({
    required int page,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    try {
      final response = await dio.get(
        'character',
        queryParameters: {
          'page': page,
          'name': name,
          'status': status,
          'species': species,
          'type': type,
          'gender': gender,
        },
      );
      if (response.statusCode == 200) {
        final eventsListModel = CharacterResponseModel.fromJson(response.data);
        return eventsListModel;
      } else {
        throw ServerException(
          response.statusMessage ?? '',
          response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw NetworkException(
        e.message ?? 'Network error',
        e.response?.statusCode,
      );
    }
  }

  @override
  Future<List<CharacterModel>> getFavoriteCharacters({
    required List<int> ids,
  }) async {
    try {
      final idsParam = ids.join(',');
      final response = await dio.get('character/$idsParam');

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          return data
              .map<CharacterModel>((json) => CharacterModel.fromJson(json))
              .toList();
        } else if (data is Map<String, dynamic>) {
          return [CharacterModel.fromJson(data)];
        } else {
          throw FormatException('Unexpected response format');
        }
      } else {
        throw ServerException(
          response.statusMessage ?? 'Unknown server error',
          response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw NetworkException(
        e.message ?? 'Network error',
        e.response?.statusCode,
      );
    }
  }
}

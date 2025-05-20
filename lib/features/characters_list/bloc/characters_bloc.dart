import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricknotmorty/core/error/failures.dart';
import 'package:ricknotmorty/core/usecase/usecase.dart';
import 'package:ricknotmorty/domain/entities/character_entity.dart';
import 'package:ricknotmorty/domain/usecases/get_character_usecase.dart';

part 'characters_bloc.freezed.dart';
part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharactersUseCase usecase;

  late CharacterResponse _currentCharacters;
  List<int> _currentFavoriteIds = [];
  CharactersBloc({required this.usecase}) : super(const _Initial()) {
    on<_GetCharactersList>((event, emit) async {
      emit(const Loading());
      final Either<Failure, CharacterResponse> charactersResponse =
          await usecase.getCharactersList(
        page: event.pageKey,
        name: event.name,
        status: event.status,
        species: event.species,
        type: event.type,
        gender: event.gender,
      );

      final Either<Failure, List<int>> favoriteIdsResponse =
          await usecase.getFavoriteIds();

      if (charactersResponse.isRight() && favoriteIdsResponse.isRight()) {
        // Both succeeded
        _currentCharacters = charactersResponse.getRight();
        _currentFavoriteIds = favoriteIdsResponse.getRight();

        emit(CharacterResponseLoaded(
          characters: _currentCharacters,
          favoriteIds: _currentFavoriteIds,
        ));
      } else if (charactersResponse.isLeft()) {
        // Characters failed
        final failure = charactersResponse.getLeft();
        emit(Error(failure.message));
      } else {
        // Characters succeeded but favoriteIds failed
        final failure = favoriteIdsResponse.getLeft();
        emit(Error(failure.message));
      }
    });

    on<_GetFavoriteIds>((event, emit) async {
      emit(const Loading());
      FavoriteIdsLoaded();
    });
    on<_AddFavorite>((event, emit) async {
      await usecase.addFavorite(event.id);
    });
    on<_RemoveFavorite>((event, emit) async {
      await usecase.removeFavorite(event.id);
    });
    on<_ResetState>((event, emit) {
      emit(const _Initial());
    });
  }
}

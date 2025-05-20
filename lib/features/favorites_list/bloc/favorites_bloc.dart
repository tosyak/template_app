import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricknotmorty/core/error/failures.dart';
import 'package:ricknotmorty/core/usecase/usecase.dart';
import 'package:ricknotmorty/domain/entities/character_entity.dart';
import 'package:ricknotmorty/domain/usecases/get_character_usecase.dart';

part 'favorites_bloc.freezed.dart';
part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetCharactersUseCase usecase;

  // Keep track of current data
  List<Character> _currentCharacters = [];
  List<int> _currentFavoriteIds = [];

  FavoritesBloc({required this.usecase}) : super(const _Initial()) {
    on<_GetFavoritesList>((event, emit) async {
      emit(const FavoritesLoading());

      // Get both responses
      final Either<Failure, List<Character>> charactersResponse =
          await usecase.getFavoriteCharactersList();

      final Either<Failure, List<int>> favoriteIdsResponse =
          await usecase.getFavoriteIds();

      // Handle different combinations of success and failure
      if (charactersResponse.isRight() && favoriteIdsResponse.isRight()) {
        // Both succeeded
        _currentCharacters = charactersResponse.getRight();
        _currentFavoriteIds = favoriteIdsResponse.getRight();

        emit(FavoriteListLoaded(
          characters: _currentCharacters,
          favoriteIds: _currentFavoriteIds,
        ));
      } else if (charactersResponse.isLeft()) {
        // Characters failed
        final failure = charactersResponse.getLeft();
        emit(FavoritesError(failure.message));
      } else {
        // Characters succeeded but favoriteIds failed
        final failure = favoriteIdsResponse.getLeft();
        emit(FavoritesError(failure.message));
      }
    });

    on<_RemoveFavorite>((event, emit) async {
      // First emit current state with loading flag
      if (state is FavoriteListLoaded) {
        emit((state as FavoriteListLoaded).copyWith(isRemoving: true));
      }

      // Call the remove favorite method
      final result = await usecase.removeFavorite(event.characterId);

      result.fold(
        (failure) => emit(FavoritesError(failure.message)),
        (_) {
          // Update local lists
          _currentFavoriteIds.remove(event.characterId);
          _currentCharacters
              .removeWhere((character) => character.id == event.characterId);

          // Emit updated state
          emit(FavoriteListLoaded(
            characters: _currentCharacters,
            favoriteIds: _currentFavoriteIds,
          ));
        },
      );
    });

    // on<_AddFavorite>((event, emit) async {
    //   if (state is FavoriteListLoaded) {
    //     emit((state as FavoriteListLoaded).copyWith(isAdding: true));
    //   }

    //   final result = await usecase.addFavorite(event.characterId);
    //   final characterResult = await usecase.getCharacterById(event.characterId);

    //   if (result.isRight() && characterResult.isRight()) {
    //     // Add to local lists
    //     _currentFavoriteIds.add(event.characterId);
    //     _currentCharacters.add(characterResult.getRight());

    //     // Emit updated state
    //     emit(FavoriteListLoaded(
    //       characters: _currentCharacters,
    //       favoriteIds: _currentFavoriteIds,
    //     ));
    //   } else {
    //     // Handle failure
    //     final failure =
    //         result.isLeft() ? result.getLeft() : characterResult.getLeft();
    //     emit(Error(failure.message));
    //   }
    // });

    on<_RefreshFavorites>((event, emit) async {
      // Refetch both lists without changing the current UI state to loading
      final Either<Failure, List<Character>> charactersResponse =
          await usecase.getFavoriteCharactersList();

      final Either<Failure, List<int>> favoriteIdsResponse =
          await usecase.getFavoriteIds();

      if (charactersResponse.isRight() && favoriteIdsResponse.isRight()) {
        _currentCharacters = charactersResponse.getRight();
        _currentFavoriteIds = favoriteIdsResponse.getRight();

        emit(FavoriteListLoaded(
          characters: _currentCharacters,
          favoriteIds: _currentFavoriteIds,
        ));
      }
    });

    on<_RefreshState>((event, emit) async {
      emit(_Initial());
    });
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricknotmorty/core/error/failures.dart';
import 'package:ricknotmorty/domain/entities/episode_entity.dart';
import 'package:ricknotmorty/domain/usecases/get_episode_usecase.dart';

part 'episodes_bloc.freezed.dart';
part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final GetEpisodesUseCase usecase;
  EpisodesBloc({required this.usecase}) : super(const _Initial()) {
    on<_GetEpisodesList>((event, emit) async {
      emit(const Loading());
      final Either<Failure, EpisodeResponse> response =
          await usecase.call(page: event.pageKey);

      response.fold(
        (failure) => emit(Error(failure.message)),
        (episodes) => emit(Success(episodes)),
      );
    });
  }
}

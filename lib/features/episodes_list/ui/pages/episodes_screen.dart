import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricknotmorty/core/network/graphql/graphql_clients.dart';
import 'package:ricknotmorty/data/data_sources/remote/episode_data_source.dart';
import 'package:ricknotmorty/data/repositories/episode_repository_impl.dart';
import 'package:ricknotmorty/domain/usecases/get_episode_usecase.dart';
import 'package:ricknotmorty/features/episodes_list/bloc/episodes_bloc.dart';
import 'package:ricknotmorty/features/episodes_list/ui/views/episodes_view.dart';

@RoutePage(name: "EpisodesRoute")
class EpisodesScreen extends StatelessWidget {
  static const routeName = 'episodes-route';
  const EpisodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EpisodesRepositoryImpl(
        remoteDataSource: EpisodesRemoteDataSourceImpl(
          graphQLClient: GraphQLClients.client(),
        ),
      ),
      child: BlocProvider(
        create: (context) => EpisodesBloc(
          usecase: GetEpisodesUseCase(
            repository: context.read<EpisodesRepositoryImpl>(),
          ),
        ),
        child: const EpisodesView(),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ricknotmorty/core/localization/app_localizations_extension.dart';
import 'package:ricknotmorty/core/routing/router.dart';
import 'package:ricknotmorty/core/routing/router.gr.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';
import 'package:ricknotmorty/core/shared/themes/app_colors.dart';
import 'package:ricknotmorty/domain/entities/character_entity.dart';
import 'package:ricknotmorty/features/favorites_list/bloc/favorites_bloc.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final CacheManager _cacheManager = getIt<CacheManager>();

  @override
  void initState() {
    super.initState();
    // Load favorites when the page is first opened
    context.read<FavoritesBloc>().add(const FavoritesEvent.getFavoritesList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Characters ${context.translate('title')}"),
        actions: [
          IconButton(
            onPressed: () => context.router.push(const SettingsRoute()),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is FavoriteListLoaded) {
            final characters = state.characters;
            final favoriteIds = state.favoriteIds;

            if (characters.isEmpty) {
              return const Center(child: Text('No Favorites Found'));
            }

            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                return _buildCharacterItem(
                  characters[index],
                  favoriteIds,
                );
              },
            );
          }

          return const Center(child: Text('No Favorites Yet'));
        },
      ),
    );
  }

  Widget _buildCharacterItem(
    Character character,
    List<int> favoriteIds,
  ) {
    final bool isFavorite = favoriteIds.contains(character.id);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              onTap: () =>
                  router.push(CharacterDetailsRoute(character: character)),
              leading: Hero(
                tag: 'character_image_${character.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: character.image,
                    height: 50.h,
                    width: 50.w,
                    cacheManager: _cacheManager,
                    placeholder: (context, url) =>
                        const CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              title: Text(
                '${character.id} ${character.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${character.species} ${character.gender}'),
                  Text(
                    'Status: ${character.status}',
                    style: TextStyle(
                      color: character.status.toLowerCase() == 'alive'
                          ? Colors.green
                          : character.status.toLowerCase() == 'dead'
                              ? Colors.red
                              : Colors.grey,
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: () => context.read<FavoritesBloc>().add(
                      FavoritesEvent.removeFavorite(character.id),
                    ),
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? AppColors.darkIcon : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

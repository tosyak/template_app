import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ricknotmorty/core/localization/app_localizations_extension.dart';
import 'package:ricknotmorty/core/routing/router.dart';
import 'package:ricknotmorty/core/routing/router.gr.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';
import 'package:ricknotmorty/core/shared/themes/app_colors.dart';
import 'package:ricknotmorty/core/utils/debouncer.dart';
import 'package:ricknotmorty/domain/entities/character_entity.dart';
import 'package:ricknotmorty/features/characters_list/bloc/characters_bloc.dart';
import 'package:ricknotmorty/features/widgets/error_dialog.dart';

// Enums for filter types
enum GenderFilter { male, female, genderless, unknown }

enum StatusFilter { alive, dead, unknown }

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> with AutoRouteAware {
  late final TextEditingController _nameTextController;
  final PagingController<int, Character> _pagingController = PagingController(
    firstPageKey: 1,
  );

  // Managers & Services
  final CacheManager _cacheManager = getIt<CacheManager>();
  final Debouncer _debouncer = getIt<Debouncer>();

  // State variables
  int _openFilterId = 0;
  int _currentPageIndex = 1;
  StatusFilter? _selectedStatus;
  GenderFilter? _selectedGender;
  String _nameFilter = '';
  String _statusFilter = '';
  String _genderFilter = '';
  List<int> _favoriteIds = [];

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      _currentPageIndex = pageKey;
      _loadCharactersPage(pageKey);
    });
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  // Load characters with current filters
  void _loadCharactersPage(int pageKey) {
    context.read<CharactersBloc>().add(
          CharactersEvent.getCharactersList(
            pageKey: pageKey,
            name: _nameFilter,
            status: _statusFilter,
            gender: _genderFilter,
          ),
        );
  }

  // Toggle filter menu visibility
  void _toggleFilterMenu(int filterId) {
    setState(() {
      _openFilterId = _openFilterId == filterId ? 0 : filterId;
    });
  }

  // Reset paging controller and refresh data
  void _refreshData() {
    _pagingController.refresh();
  }

  // Set name filter
  void _setNameFilter(String name) {
    setState(() {
      _nameFilter = name;
      _refreshData();
    });
  }

  // Clear name filter
  void _clearNameFilter() {
    setState(() {
      _nameFilter = '';
      _nameTextController.clear();
      _refreshData();
    });
  }

  // Set gender filter
  void _setGenderFilter(GenderFilter? gender) {
    setState(() {
      _selectedGender = gender;
      _genderFilter = gender?.name ?? '';
      _refreshData();
    });
  }

  // Set status filter
  void _setStatusFilter(StatusFilter? status) {
    setState(() {
      _selectedStatus = status;
      _statusFilter = status?.name ?? '';
      _refreshData();
    });
  }

  // Toggle favorite for a character
  void _toggleFavorite(int characterId) {
    setState(() {
      if (_favoriteIds.contains(characterId)) {
        _favoriteIds.remove(characterId);
        context.read<CharactersBloc>().add(
              CharactersEvent.removeFavorite(characterId),
            );
      } else {
        _favoriteIds.add(characterId);
        context.read<CharactersBloc>().add(
              CharactersEvent.addFavorite(characterId),
            );
      }
    });
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return ErrorDialog(
          errorDescription: message,
          errorType: ErrorType.error,
          onTap: () {
            router.maybePop();
          },
        );
      },
    );
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
      body: BlocConsumer<CharactersBloc, CharactersState>(
        listener: _handleBlocState,
        builder: (context, state) {
          return Column(
            children: [
              _buildFilterBar(),
              if (_openFilterId == 1) _buildNameFilterContent(),
              if (_openFilterId == 2) _buildGenderFilterContent(),
              if (_openFilterId == 3) _buildStatusFilterContent(),
              Expanded(child: _buildCharactersList()),
            ],
          );
        },
      ),
    );
  }

  // Handle bloc state changes
  void _handleBlocState(BuildContext context, CharactersState state) {
    if (state is CharacterResponseLoaded) {
      _favoriteIds = List<int>.from(state.favoriteIds);
      final isFirstPage = state.characters.info.prev == null;
      final nextPage = state.characters.info.next != null;

      if (isFirstPage) {
        _pagingController.itemList = [];
      }

      if (nextPage) {
        _pagingController.appendPage(
          state.characters.results,
          _currentPageIndex + 1,
        );
      } else {
        _pagingController.appendLastPage(state.characters.results);
      }
    } else if (state is Error) {
      _pagingController.error = state.message;
      _showErrorDialog(state.message);
      context.read<CharactersBloc>().add(
            CharactersEvent.reset(),
          );
    }
  }

  // Build the filter bar with buttons
  Widget _buildFilterBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterButton(
              1,
              _nameFilter.isEmpty ? 'name' : _nameFilter,
              _nameFilter.isNotEmpty,
            ),
            SizedBox(width: 10.w),
            _buildFilterButton(
              2,
              _genderFilter.isEmpty ? 'gender' : _genderFilter,
              _genderFilter.isNotEmpty,
            ),
            SizedBox(width: 10.w),
            _buildFilterButton(
              3,
              _statusFilter.isEmpty ? 'status' : _statusFilter,
              _statusFilter.isNotEmpty,
            ),
          ],
        ),
      ),
    );
  }

  // Build filter button
  Widget _buildFilterButton(int id, String label, bool isActive) {
    return ElevatedButton(
      onPressed: () => _toggleFilterMenu(id),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10),
        backgroundColor: isActive ? Colors.green[100] : Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Text(label),
    );
  }

  // Build name filter content
  Widget _buildNameFilterContent() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: MediaQuery.of(context).size.width - 16.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: SizedBox(
        height: 50.h,
        child: TextField(
          controller: _nameTextController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            hintText: 'enter name',
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_nameTextController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _clearNameFilter,
                  ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Apply the filter and close the filter menu
                    _setNameFilter(_nameTextController.text);
                    _toggleFilterMenu(0);
                  },
                ),
              ],
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            ),
          ),
          onChanged: (value) {
            _debouncer(() => _setNameFilter(value));
          },
        ),
      ),
    );
  }

  // Build gender filter content
  Widget _buildGenderFilterContent() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: MediaQuery.of(context).size.width - 16.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              spacing: 8.0,
              children: [
                ...GenderFilter.values.map((gender) {
                  return ChoiceChip(
                    label: Text(gender.name),
                    selected: _selectedGender == gender,
                    onSelected: (selected) {
                      _setGenderFilter(selected ? gender : null);
                      _toggleFilterMenu(0);
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build status filter content
  Widget _buildStatusFilterContent() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: MediaQuery.of(context).size.width - 16.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Wrap(
              spacing: 8.0,
              children: [
                ...StatusFilter.values.map((status) {
                  return ChoiceChip(
                    label: Text(status.name),
                    selected: _selectedStatus == status,
                    onSelected: (selected) {
                      _setStatusFilter(selected ? status : null);
                      _toggleFilterMenu(0);
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build the characters list
  Widget _buildCharactersList() {
    return PagedListView<int, Character>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Character>(
        itemBuilder: (context, character, index) {
          return _buildCharacterItem(character, index);
        },
        firstPageProgressIndicatorBuilder: (context) =>
            const Center(child: CircularProgressIndicator()),
        newPageProgressIndicatorBuilder: (context) =>
            const Center(child: CircularProgressIndicator()),
        noItemsFoundIndicatorBuilder: (context) =>
            const Center(child: Text('No Items Found')),
      ),
    );
  }

  // Build individual character item
  Widget _buildCharacterItem(Character character, int index) {
    final int itemsLength = _pagingController.itemList?.length ?? 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (index == 0) SizedBox(height: 10.h),
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
                        Center(child: const CircularProgressIndicator()),
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
                onPressed: () => _toggleFavorite(character.id),
                icon: Icon(
                  _favoriteIds.contains(character.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: _favoriteIds.contains(character.id)
                      ? AppColors.darkIcon
                      : null,
                ),
              ),
            ),
          ),
        ),
        if (index == itemsLength - 1) SizedBox(height: 70.h),
      ],
    );
  }
}

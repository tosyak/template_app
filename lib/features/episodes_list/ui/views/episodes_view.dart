import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ricknotmorty/domain/entities/episode_entity.dart';
import 'package:ricknotmorty/features/episodes_list/bloc/episodes_bloc.dart';

class EpisodesView extends StatefulWidget {
  const EpisodesView({super.key});

  @override
  State<EpisodesView> createState() => _EpisodesViewState();
}

class _EpisodesViewState extends State<EpisodesView> {
  final PagingController<int, Episode> _pagingController = PagingController(
    firstPageKey: 1,
  );

  int initialPageKey = 1;

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      context.read<EpisodesBloc>().add(
            EpisodesEvent.getEpisodesList(pageKey: pageKey),
          );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Episodes")),
      body: BlocConsumer<EpisodesBloc, EpisodesState>(
        listener: (context, state) {
          if (state is Success) {
            if (state.episodes.info.next != null) {
              _pagingController.appendPage(
                state.episodes.results,
                initialPageKey + 1,
              );
              initialPageKey += 1;
            } else {
              _pagingController.appendLastPage(state.episodes.results);
            }
          }
        },
        builder: (context, state) {
          return PagedListView<int, Episode>.separated(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Episode>(
              itemBuilder: (context, item, index) {
                final int itemsLength = _pagingController.itemList?.length ?? 0;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (index == 0) SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: ListTile(
                        title: Text('${item.id} ${item.name}'),
                        subtitle: Text(item.episode),
                        trailing: Text(item.airDate),
                      ),
                    ),
                    if (index == itemsLength - 1) SizedBox(height: 70.h),
                  ],
                );
              },
              firstPageProgressIndicatorBuilder: (context) =>
                  const Center(child: CupertinoActivityIndicator()),
              newPageProgressIndicatorBuilder: (context) =>
                  const CupertinoActivityIndicator(),
              noItemsFoundIndicatorBuilder: (context) {
                return const Center(child: Text('No Items Found'));
              },
            ),
            separatorBuilder: (context, ind) {
              return const SizedBox(height: 12);
            },
          );
        },
      ),
    );
  }
}

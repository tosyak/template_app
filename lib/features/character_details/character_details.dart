import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';
import 'package:ricknotmorty/core/shared/themes/app_colors.dart';
import 'package:ricknotmorty/domain/entities/character_entity.dart';

@RoutePage(name: "CharacterDetailsRoute")
class CharacterDetails extends StatefulWidget {
  static const routeName = "/character-details";
  final Character character;

  const CharacterDetails({super.key, required this.character});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  final CacheManager _cacheManager = getIt<CacheManager>();

  Color _getStatusColor() {
    final status = widget.character.status.toLowerCase();
    if (status == 'alive') return Colors.green;
    if (status == 'dead') return Colors.red;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black26,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCharacterInfo(),
                  SizedBox(height: 24.h),
                  _buildLocationSection(),
                  SizedBox(height: 24.h),
                  _buildEpisodesSection(),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 300.h,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'character_image_${widget.character.id}',
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: widget.character.image,
                fit: BoxFit.cover,
                cacheManager: _cacheManager,
                placeholder: (context, url) =>
                    const Center(child: CupertinoActivityIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 16.h,
                left: 16.w,
                right: 16.w,
                child: Text(
                  widget.character.name,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 1),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterInfo() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Character Info',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(height: 24.h, thickness: 1),
            _buildInfoRow(
              'Status',
              widget.character.status,
              leading: Container(
                width: 12.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: _getStatusColor(),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            _buildInfoRow('Species', widget.character.species),
            if (widget.character.type.isNotEmpty)
              _buildInfoRow('Type', widget.character.type),
            _buildInfoRow('Gender', widget.character.gender),
            _buildInfoRow('ID', '#${widget.character.id}'),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(height: 24.h, thickness: 1),
            _buildInfoRow(
              'Origin',
              widget.character.origin.name,
              leading:
                  const Icon(Icons.place_outlined, color: AppColors.darkIcon),
            ),
            _buildInfoRow(
              'Last Known Location',
              widget.character.location.name,
              leading: const Icon(Icons.my_location, color: AppColors.darkIcon),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEpisodesSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Episodes',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.character.episode.length} episode${widget.character.episode.length > 1 ? 's' : ''}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Divider(height: 24.h, thickness: 1),
            _buildEpisodesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildEpisodesList() {
    final episodesToShow = widget.character.episode.length > 3
        ? widget.character.episode.sublist(0, 3)
        : widget.character.episode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...episodesToShow.map((episode) {
          final episodeId = episode.split('/').last;
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text(
                episodeId,
                style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text('Episode $episodeId'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Episode $episodeId details')),
              );
            },
          );
        }),
        if (widget.character.episode.length > 3)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Center(
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('View all episodes')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                    'View all ${widget.character.episode.length} episodes'),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {Widget? leading}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          if (leading != null) ...[
            leading,
            SizedBox(width: 8.w),
          ],
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

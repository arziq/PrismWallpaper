import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prism/controllers/settings_controller.dart';
import 'package:prism/model/settings/wall_thumb_quality.dart';
import 'package:prism/model/wallpaper/model.dart';
import 'package:prism/services/logger.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class WallpaperCard extends StatelessWidget {
  const WallpaperCard({
    Key? key,
    required this.wallpaper,
  }) : super(key: key);

  final Wallpaper wallpaper;

  @override
  Widget build(BuildContext context) {
    final wallpaperUrl = context.watch<SettingsController>().wallThumbQuality ==
            WallThumbQuality.high
        ? wallpaper.wallpaper_url
        : wallpaper.wallpaper_thumb;
    return Column(
      children: [
        Expanded(
          flex: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onTap: () {
                logger.d('Tapped on ${wallpaper.wallpaper_url}');
              },
              child: Container(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                child: CachedNetworkImage(
                  imageUrl: wallpaperUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  timeago.format(wallpaper.createdAt ?? DateTime.now(),
                      allowFromNow: true),
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontSize: 10, fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                    child: Icon(
                      Icons.more_horiz,
                      color: Theme.of(context).textTheme.caption?.color,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
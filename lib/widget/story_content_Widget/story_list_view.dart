import 'package:flutter/material.dart';

import '../../services/localization_service.dart';
import 'story_tile.dart';

class StoryListView extends StatelessWidget {
  const StoryListView({
    super.key,
    required this.contents,
    this.storyTileSize = 50,
  });

  final List<StoryTileContent> contents;
  final double storyTileSize;
  final double _storkWidth = 1.2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: storyTileSize + _storkWidth * 4,
      child: ListView.builder(
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(
          left: LocalizationService.textDirection == TextDirection.ltr ? 20 : 0,
          right:
              LocalizationService.textDirection == TextDirection.rtl ? 20 : 0,
        ),
        itemCount: contents.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: StoryTile(
              content: contents[index],
              storkWidth: _storkWidth,
              imgSize: storyTileSize,
            ),
          );
        },
      ),
    );
  }
}

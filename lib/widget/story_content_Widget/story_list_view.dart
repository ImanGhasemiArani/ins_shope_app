import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../services/localization_service.dart';
import 'story_tile.dart';

class StoryListView extends StatelessWidget {
  const StoryListView({
    super.key,
    required this.contentDelegates,
    this.storyTileSize = 50,
  });

  final List<StoryTileContentDelegate> contentDelegates;
  final double storyTileSize;
  final double _storkWidth = 1.2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: storyTileSize + _storkWidth * 4,
      child: AnimationLimiter(
        child: ListView.builder(
          clipBehavior: Clip.none,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: contentDelegates.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              duration: const Duration(milliseconds: 500),
              position: index,
              child: SlideAnimation(
                horizontalOffset: -50 *
                    (LocalizationService.textDirection == TextDirection.ltr
                        ? -1
                        : 1),
                child: FadeInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: StoryTile(
                      delegate: contentDelegates[index],
                      storkWidth: _storkWidth,
                      imgSize: storyTileSize,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

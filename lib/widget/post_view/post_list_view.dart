import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../services/localization_service.dart';
import 'post_view.dart';

class PostListView extends StatelessWidget {
  const PostListView({
    super.key,
    required this.contentDelegates,
  });

  final List<PostContentDelegate> contentDelegates;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => AnimationConfiguration.staggeredList(
            duration: const Duration(milliseconds: 500),
            position: index + 2,
            child: SlideAnimation(
              horizontalOffset: 50 *
                  (LocalizationService.textDirection == TextDirection.ltr
                      ? -1
                      : 1),
              child: FadeInAnimation(
                child: PostView(
                  delegate: contentDelegates[index],
                ),
              ),
            ),
          ),
          childCount: contentDelegates.length,
        ),
      ),
    );
  }
}

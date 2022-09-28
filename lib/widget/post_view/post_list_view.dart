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
          //   //   for AutomaticKeepAlive Posts we should use bellow block
          //     (context, index) => ListItemWithAutoKeepAlive(
          //         contentDelegates: contentDelegates, index: index),
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

class ListItemWithAutoKeepAlive extends StatefulWidget {
  const ListItemWithAutoKeepAlive({
    Key? key,
    required this.contentDelegates,
    required this.index,
  }) : super(key: key);

  final int index;
  final List<PostContentDelegate> contentDelegates;

  @override
  State<ListItemWithAutoKeepAlive> createState() =>
      _ListItemWithAutoKeepAliveState();
}

class _ListItemWithAutoKeepAliveState extends State<ListItemWithAutoKeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimationConfiguration.staggeredList(
      duration: const Duration(milliseconds: 500),
      position: widget.index + 2,
      child: SlideAnimation(
        horizontalOffset: 50 *
            (LocalizationService.textDirection == TextDirection.ltr ? -1 : 1),
        child: FadeInAnimation(
          child: PostView(
            delegate: widget.contentDelegates[widget.index],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../services/player_controller_services.dart';
import 'explore_view_widget/explore_post_view.dart';

var lazyExplorePost = [].obs;

typedef OnExplorePostPressed = void Function(
    ExplorePostContentDelegate contentDelegates);

class ExploreListView extends StatefulWidget {
  const ExploreListView({
    super.key,
    required this.contentDelegates,
    this.onExplorePostPressed,
  });

  final List<ExplorePostContentDelegate> contentDelegates;
  final OnExplorePostPressed? onExplorePostPressed;

  @override
  State<ExploreListView> createState() => _ExploreListViewState();
}

class _ExploreListViewState extends State<ExploreListView> {
  @override
  void dispose() {
    PlayerControllerServices().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    lazyExplorePost = widget.contentDelegates.obs;
    return AnimationLimiter(
      child: Obx(
        () => SliverGrid(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            pattern: const [
              QuiltedGridTile(2, 2),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              //
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              //
              QuiltedGridTile(1, 1),
              QuiltedGridTile(2, 2),
              QuiltedGridTile(1, 1),
              //
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
            ],
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return AnimationConfiguration.staggeredGrid(
                duration: const Duration(milliseconds: 500),
                columnCount: 3,
                position: index + 3,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: index != lazyExplorePost.length
                        ? CupertinoButton(
                            onPressed: () {
                              widget.onExplorePostPressed
                                  ?.call(lazyExplorePost[index]);
                            },
                            padding: EdgeInsets.zero,
                            minSize: 0,
                            child: ExplorePostViewDelegate(
                              delegate: lazyExplorePost[index],
                            ),
                          )
                        : Center(
                            child: LoadingAnimationWidget.waveDots(
                              color: Get.theme.colorScheme.primary,
                              size: 40,
                            ),
                          ),
                  ),
                ),
              );
            },
            childCount: lazyExplorePost.length + 1,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../services/localization_service.dart';
import '../../services/player_controller_services.dart';
import 'post_view.dart';

var lazyList = [].obs;

class PostListView extends StatefulWidget {
  const PostListView({
    super.key,
    required this.contentDelegates,
  });

  final List<PostContentDelegate> contentDelegates;

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  @override
  void dispose() {
    PlayerControllerServices().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    lazyList = widget.contentDelegates.obs;
    return AnimationLimiter(
      child: Obx(
        () => SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return AnimationConfiguration.staggeredList(
                duration: const Duration(milliseconds: 500),
                position: index + 3,
                child: SlideAnimation(
                  horizontalOffset: 50 *
                      (LocalizationService.textDirection == TextDirection.ltr
                          ? -1
                          : 1),
                  child: FadeInAnimation(
                    child: index != lazyList.length
                        ? PostView(
                            delegate: lazyList[index],
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
            childCount: lazyList.length + 1,
          ),
        ),
      ),
    );
  }
}

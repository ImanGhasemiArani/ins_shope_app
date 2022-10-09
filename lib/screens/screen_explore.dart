import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../assets/assets.gen.dart';
import '../lang/strs.dart';
import '../services/localization_service.dart';
import '../utils/fake_data_generator.dart';
import '../widget/explore_list_view/explore_list_view.dart';
import '../widget/my_app_bar/my_app_bar.dart';

var canLoadMoreExplorePost = true;

class ScreenExplore extends StatelessWidget {
  const ScreenExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification.metrics.pixels >=
            scrollNotification.metrics.maxScrollExtent) {
          _loadMoreExplorePost();
        }
        return false;
      },
      child: CustomScrollView(
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          _buildAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 25)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: _buildExploreListContent(),
          ),
        ],
      ),
    );
  }

  MySliverAppBar _buildAppBar() {
    return MySliverAppBar(
      floating: true,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      titleSpacing: 0,
      title: configAnimation(
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 10,
              cornerSmoothing: 1,
            ),
          ),
          child: CupertinoSearchTextField(
            placeholder: Strs.searchStr.tr,
            style: Get.theme.textTheme.button?.copyWith(fontSize: null),
            prefixIcon: Assets.icons.searchNormal1TwoTone.svg(
              width: 20,
              height: 20,
              color: Get.theme.colorScheme.primary,
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
        0,
        hO: 0,
        vO: -50,
      ),
    );
  }

  Widget _buildExploreListContent() {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (_) => true,
      child: ExploreListView(
        contentDelegates: FkDataGenerator.generateExplorePostContentDelegate(),
      ),
    );
  }

  Widget configAnimation(
    Widget child,
    int pos, {
    double hO = 50,
    double vO = 0,
  }) {
    return AnimationConfiguration.staggeredList(
      duration: const Duration(milliseconds: 500),
      position: pos,
      child: SlideAnimation(
        horizontalOffset: hO *
            (LocalizationService.textDirection == TextDirection.ltr ? -1 : 1),
        verticalOffset: vO,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }

  void _loadMoreExplorePost() {
    if (!canLoadMoreExplorePost) return;
    canLoadMoreExplorePost = false;
    Future.delayed(
      const Duration(seconds: 1),
      () {
        lazyExplorePost
            .addAll(FkDataGenerator.generateExplorePostContentDelegate());
      },
    ).then((value) => canLoadMoreExplorePost = true);
  }
}

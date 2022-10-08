import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../assets/assets.gen.dart';
import '../lang/strs.dart';
import '../services/localization_service.dart';
import '../utils/fake_data_generator.dart';
import '../widget/ad_slider_widget/ad_slider_view.dart';
import '../widget/my_app_bar/my_app_bar.dart';
import '../widget/post_view/post_list_view.dart';
import '../widget/special_offers_content.dart/special_offers_list_view.dart';
import '../widget/story_content_Widget/story_list_view.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const BodyContent(),
    );
  }

  PreferredSizeWidget buildAppBar() => MyAppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: AnimationConfiguration.staggeredList(
          position: 0,
          duration: const Duration(milliseconds: 500),
          child: SlideAnimation(
            horizontalOffset: 50 *
                (LocalizationService.textDirection == TextDirection.ltr
                    ? -1
                    : 1),
            child: FadeInAnimation(
              child: Text(
                Strs.appNameStr.tr,
                style: Get.theme.textTheme.headline6
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        actions: [
          AnimationConfiguration.staggeredList(
            position: 0,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: -40,
              child: FadeInAnimation(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  onPressed: onDirectBtnPressed,
                  child: Card(
                    color: Get.theme.colorScheme.primary,
                    margin: EdgeInsets.zero,
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 15,
                        cornerSmoothing: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Assets.icons.directNormalTwoTone.svg(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      );

  void onDirectBtnPressed() {}
}

class BodyContent extends StatelessWidget {
  const BodyContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.none,
        slivers: [
          SliverToBoxAdapter(child: _buildStoryContent()),
          const SliverToBoxAdapter(child: SizedBox(height: 25)),
          SliverToBoxAdapter(
              child: configAnimation(_buildCarouselSlider(), 1, hO: 0, vO: 50)),
          const SliverToBoxAdapter(child: SizedBox(height: 25)),
          SliverToBoxAdapter(child: _buildSpecOffersContent()),
          const SliverToBoxAdapter(child: SizedBox(height: 15)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: _buildPostContent(),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 1000) {
          _loadMorePost();
        }
        return false;
      },
    );
  }

  Widget _buildStoryContent() {
    //if its used for slivers, this return should Wrap to SliverToBoxAdapter
    return StoryListView(
      storyItemSize: (Get.width - 40 * 2) / 6,
      contentDelegates: FkDataGenerator.generateStoryContentsDelegate(),
    );
  }

  Widget _buildCarouselSlider() {
    // if its used for slivers, this return should Wrap to SliverToBoxAdapter
    return AdSliderView(
      contentDelegates: FkDataGenerator.generateAdContentsDelegate(),
    );
  }

  Widget _buildSpecOffersContent() {
    //if its used for slivers, this return should Wrap to SliverToBoxAdapter
    return SpecOffersListView(
      contentDelegates: FkDataGenerator.generateSpecContentsDelegate(),
    );
  }

  Widget _buildPostContent() {
    return PostListView(
      contentDelegates: FkDataGenerator.generatePostContentsDelegate(),
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

  void _loadMorePost() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        lazyList.addAll(FkDataGenerator.generatePostContentsDelegate());
      },
    );
  }
}

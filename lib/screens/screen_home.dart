import 'dart:math';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;

import '../assets/assets.gen.dart';
import '../lang/strs.dart';
import '../services/localization_service.dart';
import '../widget/ad_slider_widget/ad_slider_tile.dart';
import '../widget/ad_slider_widget/ad_slider_view.dart';
import '../widget/my_app_bar/my_app_bar.dart';
import '../widget/post_view/post_list_view.dart';
import '../widget/post_view/post_view.dart';
import '../widget/special_offers_content.dart/special_offers_list_view.dart';
import '../widget/special_offers_content.dart/special_offers_tile.dart';
import '../widget/story_content_Widget/story_list_view.dart';
import '../widget/story_content_Widget/story_tile.dart';

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
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      slivers: [
        SliverToBoxAdapter(child: _buildStoryContent()),
        const SliverToBoxAdapter(child: SizedBox(height: 25)),
        SliverToBoxAdapter(
            child: configAnimation(_buildCarouselSlider(), 1, hO: 0, vO: 50)),
        const SliverToBoxAdapter(child: SizedBox(height: 15)),
        SliverToBoxAdapter(child: _buildSpecOffersContent()),
        const SliverToBoxAdapter(child: SizedBox(height: 15)),
        _buildPostContent(),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildStoryContent() {
    //if its used for slivers, this return should Wrap to SliverToBoxAdapter
    return StoryListView(
      storyTileSize: (Get.width - 40 * 2) / 6,
      contentDelegates: List.generate(
        20,
        (index) => StoryTileContentDelegate(
          'https://picsum.photos/${Random().nextInt(50) + 50}',
          index >= 3,
          () {},
        ),
      ),
    );
  }

  Widget _buildCarouselSlider() {
    // if its used for slivers, this return should Wrap to SliverToBoxAdapter
    return AdSliderView(
      contentDelegates: List.generate(
        5,
        (index) => AdSliderTileContentDelegate(
          'https://picsum.photos/${Random().nextInt(50) + 300}/150',
          () {},
        ),
      ),
    );
  }

  Widget _buildSpecOffersContent() {
    //if its used for slivers, this return should Wrap to SliverToBoxAdapter
    return SpecOffersListView(
      contentDelegates: List.generate(
        20,
        (index) => SpecOffersTileContentDelegate(
          "کفش ورزشی آدیداس مدل تام کروز",
          'https://picsum.photos/${Random().nextInt(50) + 100}',
          "200,000",
          () {},
        ),
      ),
    );
  }

  Widget _buildPostContent() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: PostListView(
        contentDelegates: List.generate(
          20 + 3,
          (index) {
            final String mediaLink;
            if (index == 0) {
              mediaLink =
                  'https://s-v4.tamasha.com/statics/videos_file/9f/04/GKPn7_9f04a2fdcd701870780773e474f10dbf21144c30_n_360.mp4';
            } else if (index == 1) {
              mediaLink =
                  'https://s-v52.tamasha.com/statics/videos_file/f1/d3/k5j2M_f1d3ee539ded921a4113ab14073b54adea6f0a2c_n_360.mp4';
            } else if (index == 2) {
              mediaLink =
                  'https://s-v52.tamasha.com/statics/videos_file/dd/60/EBamR_dd60ca4399bbdaf927c4d0cedd1b698bd59e4d73_n_360.mp4';
            } else {
              mediaLink =
                  'https://picsum.photos/${Random().nextInt(100) + 300}';
            }
            return PostContentDelegate(
              'Iman.Casper',
              "Tehran, Iran",
              'https://picsum.photos/${Random().nextInt(50) + 50}',
              mediaLink,
              "میلیاردها انسان در جهان متولد شده اند؛ اما هیچ یک اثر انگشت مشابه نداشته‌اند. اثر انگشت تو، امضای خداوند است که اتفاقی به دنیا نیامده‌ای و دعوت شده‌ای تو منحصر به فردی مشابه یا بدل نداری تو اصل اصل هستی و تکرار نشدنی وقتی انتخاب شده بودن و منحصر به فرد بودنت را یادآوری کنی؛ دیگر خودت را با هیچکس مقایسه نمی‌کنی و احساس حقارت یا برتری که حاصل مقایسه کردن است از وجودت محو می‌شود.\n\nحسین الهی قمشه‌ای\n\n\n\n#Iman\n@Casper\n\n",
              Random().nextInt(10000),
              "کفش ورزشی",
              PostMediaType.fromExtension(p.extension(mediaLink)),
              isFollowing: Random().nextBool(),
              isLiked: Random().nextBool(),
              isBookmarked: Random().nextBool(),
            );
          },
        ),
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
}

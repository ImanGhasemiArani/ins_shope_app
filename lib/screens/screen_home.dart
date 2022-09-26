import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../assets/assets.gen.dart';
import '../lang/strs.dart';
import '../widget/ad_slider_widget/ad_slider_tile.dart';
import '../widget/ad_slider_widget/ad_slider_view.dart';
import '../widget/my_app_bar/my_app_bar.dart';
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
        automaticallyImplyLeading: false,
        title: Text(
          Strs.appNameStr.tr,
          style: Get.theme.textTheme.headline6
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          SizedBox(
            height: 40,
            width: 40,
            child: ClipSmoothRect(
              radius: SmoothBorderRadius(
                cornerRadius: 15,
                cornerSmoothing: 0.6,
              ),
              child: CupertinoButton.filled(
                padding: EdgeInsets.zero,
                onPressed: onDirectBtnPressed,
                child: Assets.icons.directNormalTwoTone.svg(),
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
      slivers: [
        _buildStoryContent(),
        const SliverToBoxAdapter(child: SizedBox(height: 25)),
        _buildCarouselSlider(),
        const SliverToBoxAdapter(child: SizedBox(height: 25)),
      ],
    );
  }

  SliverToBoxAdapter _buildStoryContent() {
    return SliverToBoxAdapter(
      child: StoryListView(
        storyTileSize: (Get.width - 40 * 2) / 6,
        contents: List.generate(
          20,
          (index) => StoryTileContent(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtWCdZIODyqzU2774g_rxjf8hwq8Qi06Qyrw&usqp=CAU',
            index >= 3,
            () {},
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildCarouselSlider() {
    return SliverToBoxAdapter(
      child: AdSliderView(
        contents: [
          AdSliderTileContent(
              'https://mir-s3-cdn-cf.behance.net/project_modules/fs/2bbcfa99737217.5ef9be3dbb9a9.jpg',
              () {}),
          AdSliderTileContent(
              'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/shoes-sale-bannuer-design-template-38d8c87b5b44afb4906d2d55743a98ae_screen.jpg?ts=1616352652',
              () {}),
          AdSliderTileContent(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSM007iJ4BhAywUDqx9tMX0bxOPo68KELs6JPYIWq8rY78l-Nxwf_qbdfd8etBNFLfB8g&usqp=CAU',
              () {}),
          AdSliderTileContent(
              'https://assets-1.placeit.net/smart_templates/1515ef3eb8ded7f7d8e96b4fecc69c38/assets/33e413340c3a69c9869fcf9c978ad1e8.png',
              () {}),
          AdSliderTileContent(
              'https://de3uph0m5upal.cloudfront.net/wp-content/uploads/2021/10/tenis.jpg',
              () {}),
        ],
      ),
    );
  }
}

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../assets/assets.gen.dart';
import '../lang/strs.dart';
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
        SliverToBoxAdapter(
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
        ),
      ],
    );
  }
}

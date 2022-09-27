import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../assets/assets.gen.dart';
import '../widget/bottom_nav_bar/bottom_nav_bar.dart';
import 'screen_cart.dart';
import 'screen_category.dart';
import 'screen_explore.dart';
import 'screen_home.dart';
import 'screen_profile.dart';

class ScreenHolder extends HookWidget {
  const ScreenHolder({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController(initialPage: 2);
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ScreenProfile(),
          ScreenExplore(),
          ScreenHome(),
          ScreenCategory(),
          ScreenCart(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MyNavBar(pageController: pageController),
    );
  }
}

class MyNavBar extends StatelessWidget {
  const MyNavBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        child: FadeInAnimation(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: FNavBar(
              initItemIndex: 2,
              onChange: (index) {
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                );
              },
              items: [
                FNavBarItem(
                  icon: Assets.icons.profileTwoTone.svg(),
                  selectedIcon: Assets.icons.profileBulk.svg(),
                ),
                FNavBarItem(
                  icon: Assets.icons.searchNormal1TwoTone.svg(),
                  selectedIcon: Assets.icons.searchNormal1Bulk.svg(),
                ),
                FNavBarItem(
                  icon: Assets.icons.home1TwoTone.svg(),
                  selectedIcon: Assets.icons.home1Bulk.svg(),
                ),
                FNavBarItem(
                  icon: Assets.icons.category2TwoTone.svg(),
                  selectedIcon: Assets.icons.category2Bulk.svg(),
                ),
                FNavBarItem(
                  icon: Assets.icons.bag2TwoTone.svg(),
                  selectedIcon: Assets.icons.bag2Bulk.svg(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../assets/assets.gen.dart';
import '../assets/text_styles.dart';
import '../lang/strs.dart';
import '../widget/my_app_bar/my_app_bar.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
    );
  }

  void onDirectBtnPressed() {}

  PreferredSizeWidget buildAppBar() => MyAppBar(
        automaticallyImplyLeading: false,
        title: Text(
          Strs.appNameStr.tr,
          style: TextStyles.headline6Bold,
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
                //   minSize: 0,
                onPressed: onDirectBtnPressed,
                child: Assets.icons.directNormalTwoTone.svg(),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      );
}

import 'dart:ui';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../assets/assets.gen.dart';

List<String> images = [
  "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
  "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
  "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
  "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
  "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
  "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
];

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});
  @override
  Widget build(BuildContext context) {
    bool isFirstTime = true;
    return SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 500),
                      childAnimationBuilder: (widget) {
                        var fade = FadeInAnimation(
                          child: widget,
                        );
                        if (isFirstTime) {
                          isFirstTime = false;
                          return SlideAnimation(
                              verticalOffset: -50, child: fade);
                        }
                        return SlideAnimation(
                            horizontalOffset: 50, child: fade);
                      },
                      children: [_buildTop(context)],
                    ),
                  ),
                ),
              ),
            )));
  }

  Stack _buildTop(BuildContext context) {
    final coverHight = Get.height * 0.25;
    const profileHight = 116.0;
    final profileTop = coverHight - profileHight * 0.5;
    const coverBottom = profileHight * 0.5;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: coverBottom),
          child: Container(
            color: Colors.grey,
            child: _buildCoverImg(coverHight),
          ),
        ),
        Positioned(
            top: profileTop * 0.2,
            child: Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: profileTop * 0.5,
                ),
                const Text(
                  'فروشگاه خانه هنر',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(mainAxisSize: MainAxisSize.max, children: [
                  _buildProfileImg(profileHight),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.25),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const [
                            Text(
                              '53',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'محصول',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            )
                          ],
                        ),
                        Column(
                          children: const [
                            Text(
                              '293',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'دنبال کننده',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            )
                          ],
                        ),
                        Column(
                          children: const [
                            Text(
                              '4.2',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'امتیاز',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
                ]),
                const SizedBox(
                  height: 10,
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: Colors.black.withOpacity(0.7),
                        shape: SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: 10,
                            cornerSmoothing: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "تنظیمات حساب کاربری",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      )),
                ),
                _buildTabSection(context),
              ],
            )))
      ],
    );
  }

  SizedBox _buildCoverImg(double coverHight) => SizedBox(
        height: coverHight,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.img1.image().image,
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Get.theme.colorScheme.background,
                ],
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: const SizedBox(),
            ),
          ),
        ),
      );

  Widget _buildProfileImg(double profileHight) => Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            margin: EdgeInsets.only(right: 15, left: 15),
            child: Container(
              height: 75,
              width: 75,
              margin: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: Assets.img1.image().image,
                  fit: BoxFit.cover,
                ),
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 20,
                    cornerSmoothing: 1,
                  ),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image(
                image: Assets.img1.image().image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: -10,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Card(
                // color: Get.theme.colorScheme.background,
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 10,
                    cornerSmoothing: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Assets.icons.camera.svg(),
                ),
              ),
            ),
          ),
        ],
      );

  Widget _buildTabSection(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Colors.black.withOpacity(0.7),
            child: const TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 5.0,
              labelColor: Colors.white,
              labelPadding: EdgeInsets.only(top: 10.0),
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: 'محصولات'),
                Tab(
                  text: 'چند رسانه ای',
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              children: [
                Container(
                    padding: EdgeInsets.all(12.0),
                    child: GridView.builder(
                      itemCount: images.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(images[index]);
                      },
                    )),
                Container(
                    padding: EdgeInsets.all(12.0),
                    child: GridView.builder(
                      itemCount: images.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(images[index]);
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

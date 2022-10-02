import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ad_slider_tile.dart';

class AdSliderView extends StatelessWidget {
  const AdSliderView({
    super.key,
    required this.contentDelegates,
    this.height = 150,
  });

  final List<AdSliderTileContentDelegate> contentDelegates;
  final double height;

  @override
  Widget build(BuildContext context) {
    final currentAdIndex = 0.obs;
    return CarouselSlider.builder(
      carouselController: CarouselController(),
      itemCount: contentDelegates.length,
      itemBuilder: (context, index, realIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AdSliderTile(
            delegate: contentDelegates[index],
            imgSize: Size(double.infinity, height),
          ),
        );
      },
      options: CarouselOptions(
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1,
        height: height,
        onPageChanged: (index, reason) => currentAdIndex.value = index,
        clipBehavior: Clip.none,
      ),
    );
  }
}

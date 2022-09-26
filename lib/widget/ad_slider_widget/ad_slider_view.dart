import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ad_slider_tile.dart';

class AdSliderView extends StatelessWidget {
  const AdSliderView({
    super.key,
    required this.contents,
  });

  final List<AdSliderTileContent> contents;

  @override
  Widget build(BuildContext context) {
    final currentAdIndex = 0.obs;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          itemCount: contents.length,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AdSliderTile(
                content: contents[index],
                imgSize: const Size(double.infinity, 150),
              ),
            );
          },
          options: CarouselOptions(
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
            height: 150,
            onPageChanged: (index, reason) => currentAdIndex.value = index,
          ),
        ),
        Obx(
          () => DotsIndicator(
            dotsCount: contents.length,
            position: currentAdIndex.value.toDouble(),
            decorator: DotsDecorator(
              color: Colors.grey,
              activeColor: Get.theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

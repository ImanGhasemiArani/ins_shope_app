import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../assets/assets.gen.dart';
import '../../lang/strs.dart';
import '../../services/localization_service.dart';
import 'special_offers_item.dart';

class SpecOffersListView extends StatelessWidget {
  const SpecOffersListView({
    super.key,
    required this.contentDelegates,
  });

  final List<SpecOffersItemContentDelegate> contentDelegates;
  final double itemHeight = 150;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight +
          15 +
          _textSize('\n\n', Get.textTheme.bodyText1, itemHeight).height +
          15 +
          _textSize('\n\n', Get.textTheme.bodyText1, itemHeight).height +
          20,
      child: AnimationLimiter(
        child: ListView.builder(
          clipBehavior: Clip.none,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: min(contentDelegates.length, 10) + 2,
          itemBuilder: (context, index) {
            Widget child;
            if (index == 0) {
              child = _buildTitleWidget();
            } else {
              try {
                if (min(contentDelegates.length, 10) < index) {
                  throw Exception();
                }
                child = SpecOffersItem(
                  delegate: contentDelegates[index - 1],
                  imgSize: itemHeight,
                );
              } catch (e) {
                child = _buildMoreBtn();
              }
            }
            return AnimationConfiguration.staggeredList(
              duration: const Duration(milliseconds: 500),
              position: index + 2,
              child: SlideAnimation(
                horizontalOffset: -50 *
                    (LocalizationService.textDirection == TextDirection.ltr
                        ? -1
                        : 1),
                child: FadeInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: child,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMoreBtn() {
    return Center(
      child: SizedBox(
        width: itemHeight + 20,
        child: CupertinoButton(
          onPressed: onMoreBtnPressed,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RotatedBox(
                quarterTurns:
                    LocalizationService.textDirection == TextDirection.ltr
                        ? 2
                        : 0,
                child: Assets.icons.arrowCircleLeftTwoTone.svg(
                  color: Get.theme.colorScheme.onBackground,
                ),
              ),
              Text(
                Strs.moreStr.tr,
                style: Get.textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleWidget() {
    return SizedBox(
      width: itemHeight + 20,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 15),
          Text(
            Strs.specialOffersStr.tr,
            style: Get.textTheme.headline5?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          FittedBox(
            child: Assets.icons.discountShapeTwoTone.svg(
              height: itemHeight * 0.5,
              width: itemHeight * 0.5,
              color: CupertinoColors.destructiveRed,
            ),
          ),
          _buildMoreBtn(),
        ],
      ),
    );
  }

  Size _textSize(
    String text,
    TextStyle? style,
    double maxWidth, {
    int maxLines = 2,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: LocalizationService.textDirection,
    )..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter.size;
  }

  void onMoreBtnPressed() {}
}

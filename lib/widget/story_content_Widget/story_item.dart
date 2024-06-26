import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({
    super.key,
    required this.delegate,
    required this.storkWidth,
    required this.imgSize,
  });
  final StoryItemContentDelegate delegate;
  final double imgSize;
  final double storkWidth;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: delegate.onStoryItemPressed,
      minSize: 0,
      padding: EdgeInsets.zero,
      child: Container(
        height: imgSize + storkWidth * 4,
        width: imgSize + storkWidth * 4,
        padding: EdgeInsets.all(storkWidth),
        decoration: ShapeDecoration(
          gradient: delegate.isViewed
              ? null
              : const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  tileMode: TileMode.clamp,
                  colors: [
                    Color(0xFFFF0000),
                    Color(0xFFFD5C00),
                    Color(0xFFFC8B00),
                    Color(0xFFFAFF00),
                  ],
                ),
          color: delegate.isViewed ? Colors.transparent : null,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 20,
              cornerSmoothing: 1,
            ),
          ),
        ),
        child: Container(
          height: imgSize + storkWidth * 2,
          width: imgSize + storkWidth * 2,
          padding: EdgeInsets.all(storkWidth),
          decoration: ShapeDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 20,
                cornerSmoothing: 1,
              ),
            ),
          ),
          child: Card(
            margin: EdgeInsets.zero,
            child: CachedNetworkImage(
              imageUrl: delegate.profImgUrl,
              fit: BoxFit.cover,
              height: imgSize,
              width: imgSize,
              errorWidget: (context, url, error) => SizedBox(
                height: imgSize,
                width: imgSize,
                child: FittedBox(
                  child: Center(
                    child: Icon(
                      CupertinoIcons.person_solid,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

typedef OnStoryItemPressed = void Function();

class StoryItemContentDelegate {
  final String profImgUrl;
  final bool isViewed;
  final OnStoryItemPressed onStoryItemPressed;

  StoryItemContentDelegate(
    this.profImgUrl,
    this.isViewed,
    this.onStoryItemPressed,
  );
}

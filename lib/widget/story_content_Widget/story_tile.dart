import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryTile extends StatelessWidget {
  const StoryTile({
    super.key,
    required this.content,
    required this.storkWidth,
    required this.imgSize,
  });
  final StoryTileContent content;
  final double imgSize;
  final double storkWidth;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: content.onStoryTilePressed,
      minSize: 0,
      padding: EdgeInsets.zero,
      child: Container(
        height: imgSize + storkWidth * 4,
        width: imgSize + storkWidth * 4,
        padding: EdgeInsets.all(storkWidth),
        decoration: ShapeDecoration(
          gradient: content.isViewed
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
          color: content.isViewed ? Colors.transparent : null,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 20,
              cornerSmoothing: 0.6,
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
                cornerSmoothing: 0.6,
              ),
            ),
          ),
          child: Card(
            margin: EdgeInsets.zero,
            child: CachedNetworkImage(
              imageUrl: content.profImgUrl,
              fit: BoxFit.cover,
              height: imgSize,
              width: imgSize,
            ),
          ),
        ),
      ),
    );
  }
}

typedef OnStoryTilePressed = void Function();

class StoryTileContent {
  final String profImgUrl;
  final bool isViewed;
  final OnStoryTilePressed onStoryTilePressed;

  StoryTileContent(
    this.profImgUrl,
    this.isViewed,
    this.onStoryTilePressed,
  );
}

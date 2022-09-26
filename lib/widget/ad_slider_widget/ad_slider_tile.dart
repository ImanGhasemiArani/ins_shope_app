import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdSliderTile extends StatelessWidget {
  const AdSliderTile({
    super.key,
    required this.content,
    required this.imgSize,
  });

  final AdSliderTileContent content;
  final Size imgSize;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: content.onAdTilePressed,
      minSize: 0,
      padding: EdgeInsets.zero,
      child: Card(
        margin: EdgeInsets.zero,
        child: CachedNetworkImage(
          imageUrl: content.adImgUrl,
          fit: BoxFit.cover,
          height: imgSize.height,
          width: imgSize.width,
        ),
      ),
    );
  }
}

typedef OnAdTilePressed = void Function();

class AdSliderTileContent {
  final String adImgUrl;
  final OnAdTilePressed onAdTilePressed;

  AdSliderTileContent(this.adImgUrl, this.onAdTilePressed);
}

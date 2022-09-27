import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdSliderTile extends StatelessWidget {
  const AdSliderTile({
    super.key,
    required this.delegate,
    required this.imgSize,
  });

  final AdSliderTileContentDelegate delegate;
  final Size imgSize;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: delegate.onAdTilePressed,
      minSize: 0,
      padding: EdgeInsets.zero,
      child: Card(
        margin: EdgeInsets.zero,
        child: CachedNetworkImage(
          imageUrl: delegate.adImgUrl,
          fit: BoxFit.cover,
          height: imgSize.height,
          width: imgSize.width,
        ),
      ),
    );
  }
}

typedef OnAdTilePressed = void Function();

class AdSliderTileContentDelegate {
  final String adImgUrl;
  final OnAdTilePressed onAdTilePressed;

  AdSliderTileContentDelegate(this.adImgUrl, this.onAdTilePressed);
}

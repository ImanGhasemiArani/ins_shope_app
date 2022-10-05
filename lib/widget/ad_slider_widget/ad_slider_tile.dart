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
          progressIndicatorBuilder: (context, url, progress) => FittedBox(
            fit: BoxFit.scaleDown,
            child: Center(
              child: CupertinoActivityIndicator.partiallyRevealed(
                progress: progress.progress ?? 1,
                radius: 15,
              ),
            ),
          ),
          errorWidget: (context, url, error) => FittedBox(
            fit: BoxFit.scaleDown,
            child: Center(
              child: CupertinoButton(
                onPressed: null,
                child: Icon(
                  CupertinoIcons.refresh_thin,
                  size: 50,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
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

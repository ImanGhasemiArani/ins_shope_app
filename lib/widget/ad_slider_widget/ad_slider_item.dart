import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdSliderItem extends StatelessWidget {
  const AdSliderItem({
    super.key,
    required this.delegate,
    required this.imgSize,
  });

  final AdSliderItemContentDelegate delegate;
  final Size imgSize;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: delegate.onAdItemPressed,
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

typedef OnAdItemPressed = void Function();

class AdSliderItemContentDelegate {
  final String adImgUrl;
  final OnAdItemPressed onAdItemPressed;

  AdSliderItemContentDelegate(this.adImgUrl, this.onAdItemPressed);
}

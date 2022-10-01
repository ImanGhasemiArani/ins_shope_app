import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../price_view/price_view.dart';

class SpecOffersTile extends StatelessWidget {
  const SpecOffersTile({
    super.key,
    required this.delegate,
    required this.imgSize,
  });
  final SpecOffersTileContentDelegate delegate;
  final double imgSize;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: delegate.onStoryTilePressed,
      minSize: 0,
      padding: EdgeInsets.zero,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: imgSize,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: ClipSmoothRect(
                    radius: SmoothBorderRadius(
                      cornerRadius: 20,
                      cornerSmoothing: 1,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: delegate.productImgUrl,
                      fit: BoxFit.cover,
                      height: imgSize,
                      width: imgSize,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  '${delegate.productName}\n',
                  style: Get.textTheme.bodyText1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OfferPriceView(
                    contentDelegate: delegate.priceContentDelegate
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef OnSpecOffersTilePressed = void Function();

class SpecOffersTileContentDelegate {
  final String productName;
  final String productImgUrl;
  final PriceContentDelegate priceContentDelegate;
  final OnSpecOffersTilePressed onStoryTilePressed;

  SpecOffersTileContentDelegate(
    this.productName,
    this.productImgUrl,
    this.priceContentDelegate,
    this.onStoryTilePressed,
  );
}

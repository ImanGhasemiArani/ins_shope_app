import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../price_view/price_view.dart';

class SpecOffersItem extends StatelessWidget {
  const SpecOffersItem({
    super.key,
    required this.delegate,
    required this.imgSize,
  });
  final SpecOffersItemContentDelegate delegate;
  final double imgSize;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: delegate.onStoryItemPressed,
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
                      progressIndicatorBuilder: (context, url, progress) =>
                          FittedBox(
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
                    contentDelegate: delegate.priceContentDelegate,
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

typedef OnSpecOffersItemPressed = void Function();

class SpecOffersItemContentDelegate {
  final String productName;
  final String productImgUrl;
  final PriceContentDelegate priceContentDelegate;
  final OnSpecOffersItemPressed onStoryItemPressed;

  SpecOffersItemContentDelegate(
    this.productName,
    this.productImgUrl,
    this.priceContentDelegate,
    this.onStoryItemPressed,
  );
}

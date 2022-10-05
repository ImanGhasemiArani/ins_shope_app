import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../lang/strs.dart';
import '../../services/localization_service.dart';
import '../../utils/extension.dart';

abstract class PriceView extends StatelessWidget {
  const PriceView({
    super.key,
    required this.contentDelegate,
  });

  final PriceContentDelegate contentDelegate;

  @override
  Widget build(BuildContext context);
}

class OfferPriceView extends PriceView {
  const OfferPriceView({
    super.key,
    required super.contentDelegate,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strs.currencyStr.tr,
            style: Get.theme.textTheme.subtitle2,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${contentDelegate.price * (100 - contentDelegate.discountPercent!) ~/ 100}'
                      .trNums(),
                  style: Get.textTheme.bodyText1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 10),
                Text(
                  '${contentDelegate.price}'.trNums(),
                  style: Get.textTheme.bodyText2!.copyWith(
                    decoration: TextDecoration.lineThrough,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            height: _textSize(
                        '1234567890۱۲۳۴۵۶۷۸۹۰%٪',
                        Get.textTheme.overline!.copyWith(
                          color: Colors.white,
                        ),
                        double.infinity,
                        maxLines: 1)
                    .height +
                10,
            width: _textSize(
                        '100%',
                        Get.textTheme.overline!.copyWith(
                          color: Colors.white,
                        ),
                        double.infinity,
                        maxLines: 1)
                    .width +
                10,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(5),
            child: Text(
              '${contentDelegate.discountPercent!}%'.trNums(),
              style: Get.textTheme.overline!.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
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
}

class PriceContentDelegate {
  final int price;
  final bool haveDiscount;
  final int? priceWithDiscount;
  final int? discountPercent;

  PriceContentDelegate(
    this.price, {
    this.haveDiscount = false,
    this.priceWithDiscount,
    this.discountPercent,
  });
}

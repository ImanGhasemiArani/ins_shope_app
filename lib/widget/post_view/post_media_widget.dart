import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../assets/assets.gen.dart';
import '../../services/localization_service.dart';
import 'post_view.dart';

class PostMediaWidget extends StatelessWidget {
  const PostMediaWidget({
    super.key,
    this.size = const Size(double.infinity, double.infinity),
    required this.delegate,
  });

  final PostContentDelegate delegate;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: ClipSmoothRect(
        radius: SmoothBorderRadius(
          cornerRadius: 20,
          cornerSmoothing: 1,
        ),
        child: Stack(
          children: [
            _buildMediaContent(),
            _buildProductLinkerContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaContent() {
    return ClipSmoothRect(
      radius: SmoothBorderRadius(
        cornerRadius: 20,
        cornerSmoothing: 1,
      ),
      child: CachedNetworkImage(
        imageUrl: delegate.mediaUrl,
        height: size.height,
        width: size.width,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildProductLinkerContent() {
    return Align(
      alignment: LocalizationService.textDirection == TextDirection.ltr
          ? Alignment.bottomLeft
          : Alignment.bottomRight,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onProductBtnPressed,
        child: Container(
          height: 50,
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 20,
                cornerSmoothing: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(6),
                child: Assets.icons.bag2TwoTone.svg(
                  color: Colors.white,
                  width: 20,
                  height: 20,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 6 + 16, vertical: 6),
                child: Text(
                  delegate.productName,
                  style: Get.textTheme.caption?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onProductBtnPressed() {}
}

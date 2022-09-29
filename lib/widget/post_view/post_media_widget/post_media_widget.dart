import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;

import '../../../assets/assets.gen.dart';
import '../../../services/localization_service.dart';
import '../post_view.dart';
import 'post_photo_widget.dart';
import 'post_video_widget.dart';

class PostMediaWidgetDelegate extends StatelessWidget {
  const PostMediaWidgetDelegate({
    super.key,
    this.size = const Size(double.infinity, double.infinity),
    required this.delegate,
  });

  final PostContentDelegate delegate;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final mediaType =
        PostMediaType.fromExtension(p.extension(delegate.mediaUrl));
    switch (mediaType) {
      case PostMediaType.picture:
        return PostPictureWidget(delegate: delegate, size: size);
      case PostMediaType.video:
        return PostVideoWidget(delegate: delegate, size: size);
      default:
        return PostPictureWidget(delegate: delegate, size: size);
    }
  }
}

abstract class PostMediaWidget extends StatelessWidget {
  const PostMediaWidget({
    super.key,
    required this.size,
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
            buildMediaContent(),
            buildProductLinkerContent(),
          ],
        ),
      ),
    );
  }

  @protected
  Widget buildMediaContent();

  @protected
  Widget buildProductLinkerContent() {
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

enum PostMediaType {
  picture(['jpg', 'jpeg', 'png']),
  video(['mp4']);

  const PostMediaType(this.supportedExtensions);
  final List<String> supportedExtensions;

  static PostMediaType? fromExtension(String extension) {
    extension = extension.toLowerCase().replaceAll('.', '');
    for (final type in values) {
      if (type.supportedExtensions.contains(extension)) {
        return type;
      }
    }
    return null;
  }
}

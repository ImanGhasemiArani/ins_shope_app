import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../assets/assets.gen.dart';
import '../../../services/localization_service.dart';
import '../post_view.dart';
import 'post_group_widget.dart';
import 'post_image_widget.dart';
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
    switch (delegate.mediaType) {
      case PostMediaType.image:
        return PostImageWidget(delegate: delegate, size: size);
      case PostMediaType.video:
        return PostVideoWidget(delegate: delegate, size: size);
      case PostMediaType.group:
        return PostGroupWidget(delegate: delegate, size: size);
      case PostMediaType.none:
        return PostEmptyWidget(size: size, delegate: delegate);
    }
  }
}

abstract class PostMediaWidget extends StatelessWidget {
  const PostMediaWidget({
    super.key,
    required this.size,
    required this.delegate,
    required this.type,
  });

  final PostContentDelegate delegate;
  final Size size;
  final PostMediaType type;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: type.ratio,
      child: Stack(
        children: [
          buildMediaContent(),
          buildProductLinkerContent(),
        ],
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

class PostEmptyWidget extends PostMediaWidget {
  const PostEmptyWidget({
    super.key,
    required super.size,
    required super.delegate,
  }) : super(type: PostMediaType.none);

  @override
  Widget buildMediaContent() {
    return const SizedBox();
  }

  @override
  Widget buildProductLinkerContent() {
    return const SizedBox();
  }
}

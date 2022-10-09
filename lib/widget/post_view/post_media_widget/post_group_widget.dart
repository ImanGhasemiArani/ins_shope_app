import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/extension.dart';
import '../../../services/localization_service.dart';
import '../../scroll_behavior/scroll_behavior.dart';
import '../post_view.dart';
import 'post_image_widget.dart';
import 'post_media_widget.dart';
import 'post_video_widget.dart';

class PostGroupWidget extends PostMediaWidget {
  const PostGroupWidget({
    super.key,
    required super.size,
    required super.delegate,
  }) : super(type: PostMediaType.group);

  @override
  Widget buildMediaContent() {
    final currentPage = 0.obs;
    return Stack(
      children: [
        PageView.builder(
          scrollBehavior: NoIndicatorScrollBehavior(),
          itemCount: delegate.mediaUrls.length,
          itemBuilder: (context, index) => _buildDynamicPostWidget(index),
          onPageChanged: (value) {
            currentPage.value = value;
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: LocalizationService.textDirection == TextDirection.ltr
                ? Alignment.topLeft
                : Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100),
              ),
              width: 45,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Obx(
                () {
                  return Text(
                    '${currentPage.value + 1}/${delegate.mediaUrls.length}'
                        .trNums(),
                    textAlign: TextAlign.center,
                    style: Get.textTheme.caption?.copyWith(color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicPostWidget(index) {
    if (PostMediaType.fromExtension(delegate.mediaUrls[index]) ==
        PostMediaType.video) {
      return PostVideoWidget(
        size: size,
        delegate: delegate.copyWith(
          mediaUrls: [delegate.mediaUrls[index]],
        ),
        isShowLinker: false,
        visibleFraction: 1,
      );
    } else {
      return PostImageWidget(
        size: size,
        delegate: delegate.copyWith(
          mediaUrls: [delegate.mediaUrls[index]],
        ),
        isShowLinker: false,
      );
    }
  }
}

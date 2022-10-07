import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

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
    return ClipSmoothRect(
      child: PageView.builder(
        scrollBehavior: MyScrollBehavior(),
        itemCount: delegate.mediaUrls.length,
        itemBuilder: (context, index) => _buildDynamicPostWidget(index),
      ),
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
        productLinkerContent: const SizedBox(),
      );
    } else {
      return PostImageWidget(
        size: size,
        delegate: delegate.copyWith(
          mediaUrls: [delegate.mediaUrls[index]],
        ),
        productLinkerContent: const SizedBox(),
      );
    }
  }
}

class MyScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

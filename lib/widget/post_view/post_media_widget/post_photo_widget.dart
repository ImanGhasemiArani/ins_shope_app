import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'post_media_widget.dart';

class PostPhotoWidget extends PostMediaWidget {
  const PostPhotoWidget({
    super.key,
    required super.size,
    required super.delegate,
  });

  @override
  Widget buildMediaContent() {
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
}
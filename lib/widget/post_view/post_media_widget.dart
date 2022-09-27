import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

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
        child: CachedNetworkImage(
          imageUrl: delegate.mediaUrl,
          height: size.height,
          width: size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

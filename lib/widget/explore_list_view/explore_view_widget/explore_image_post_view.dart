import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../assets/assets.gen.dart';
import 'explore_post_view.dart';

class ExploreImagePostView extends ExplorePostView {
  const ExploreImagePostView({
    super.key,
    required super.delegate,
  });

  @override
  Widget buildMediaContent() {
    return CachedNetworkImage(
      imageUrl: delegate.mediaUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, progress) => FittedBox(
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
    );
  }

  @override
  Widget buildOverlayContent() {
    return const SizedBox();
    // return Align(
    //   alignment: Alignment.topRight,
    //   child: Padding(
    //     padding: const EdgeInsets.all(8),
    //     child: Assets.icons.galleryBulk.svg(color: Colors.white),
    //   ),
    // );
  }
}

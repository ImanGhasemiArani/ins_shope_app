import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../post_view/post_view.dart';
import 'explore_image_post_view.dart';

class ExplorePostViewDelegate extends StatelessWidget {
  const ExplorePostViewDelegate({
    super.key,
    required this.delegate,
  });

  final ExplorePostContentDelegate delegate;

  @override
  Widget build(BuildContext context) {
    switch (delegate.mediaType) {
      case PostMediaType.image:
        return ExploreImagePostView(delegate: delegate);
      case PostMediaType.video:
        // return ExploreVideoPostView(delegate: delegate);
        return ExploreImagePostView(delegate: delegate);
      case PostMediaType.none:
        //this because for invalid api image link it will return null for main link should remove
        return ExploreImagePostView(delegate: delegate);
      // return ExploreEmptyPostView(delegate: delegate);
    }
  }
}

abstract class ExplorePostView extends StatelessWidget {
  const ExplorePostView({
    super.key,
    required this.delegate,
  });

  final ExplorePostContentDelegate delegate;

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
            buildOverlayContent(),
          ],
        ),
      ),
    );
  }

  @protected
  Widget buildMediaContent();

  @protected
  Widget buildOverlayContent();
}

class ExploreEmptyPostView extends ExplorePostView {
  const ExploreEmptyPostView({
    super.key,
    required super.delegate,
  });

  @override
  Widget buildMediaContent() {
    return const SizedBox();
  }

  @override
  Widget buildOverlayContent() {
    return const SizedBox();
  }
}

typedef OnExplorePostPressed = void Function();

class ExplorePostContentDelegate {
  final String mediaUrl;
  final PostMediaType mediaType;
  final OnExplorePostPressed onExplorePostPressed;

  ExplorePostContentDelegate(
    this.mediaUrl,
    this.mediaType,
    this.onExplorePostPressed,
  );
}

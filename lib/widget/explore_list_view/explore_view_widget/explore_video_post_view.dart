import 'dart:async';
import 'dart:typed_data';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../assets/assets.gen.dart';
import 'explore_post_view.dart';

class ExploreVideoPostView extends ExplorePostView {
  const ExploreVideoPostView({
    super.key,
    required super.delegate,
  });

  @override
  Widget buildMediaContent() {
    return ClipSmoothRect(
      radius: SmoothBorderRadius(
        cornerRadius: 20,
        cornerSmoothing: 1,
      ),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: VideoThumbnailWidget(delegate: delegate),
      ),
    );
  }

  @override
  Widget buildOverlayContent() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Assets.icons.playBulk.svg(color: Colors.white),
      ),
    );
  }
}

class VideoThumbnailWidget extends StatelessWidget {
  const VideoThumbnailWidget({
    super.key,
    required this.delegate,
  });

  final ExplorePostContentDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.sync(() async => await VideoThumbnail.thumbnailData(
            video: delegate.mediaUrl,
          )),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Image.memory(
            snapshot.data as Uint8List,
            fit: BoxFit.cover,
          );
        } else {
          return const Center(
            child: CupertinoActivityIndicator(radius: 15),
          );
        }
      },
    );
  }
}
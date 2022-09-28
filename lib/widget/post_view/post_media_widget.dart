import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;

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

abstract class _PostMediaWidget extends StatelessWidget {
  const _PostMediaWidget({
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

class PostPictureWidget extends _PostMediaWidget {
  const PostPictureWidget({
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

class PostVideoWidget extends _PostMediaWidget {
  const PostVideoWidget({
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
      child: VideoPlayerWidget(delegate: delegate),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.delegate,
  }) : super(key: key);

  final PostContentDelegate delegate;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final BetterPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = BetterPlayerController(
      BetterPlayerConfiguration(
        aspectRatio: 1 / 1,
        fit: BoxFit.cover,
        autoDispose: true,
        looping: true,
        allowedScreenSleep: false,
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          showControls: false,
        ),
        playerVisibilityChangedBehavior: (visibleFraction) {
          if (visibleFraction < 1 && _controller.isPlaying()!) {
            _controller.pause();
          } else if (visibleFraction >= 1 && !_controller.isPlaying()!) {
            _controller.play();
          }
        },
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.delegate.mediaUrl,
        cacheConfiguration: const BetterPlayerCacheConfiguration(
          useCache: true,
        ),
      ),
    );
    bool isInit = false;
    _controller.videoPlayerController?.addListener(() {
      try {
        if (_controller.isVideoInitialized()! != isInit) {
          setState(() {
            isInit = _controller.isVideoInitialized()!;
          });
        }
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_controller.isVideoInitialized()!)
          GestureDetector(
            onTap: () {
              _controller.isPlaying()!
                  ? _controller.pause()
                  : _controller.play();
            },
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: BetterPlayer(controller: _controller),
            ),
          )
        else
          const CircularProgressIndicator(strokeWidth: 1),
      ],
    );
  }
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

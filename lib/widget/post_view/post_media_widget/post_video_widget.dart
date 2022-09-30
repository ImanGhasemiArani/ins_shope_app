import 'package:better_player/better_player.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import '../post_view.dart';
import 'post_media_widget.dart';

class PostVideoWidget extends PostMediaWidget {
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

    final dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.delegate.mediaUrl,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        key: widget.delegate.mediaUrl,
        preCacheSize: 3 * 1024 * 1024,
        maxCacheSize: 512 * 1024 * 1024,
        maxCacheFileSize: 50 * 1024 * 1024,
      ),
    );
    final config = BetterPlayerConfiguration(
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
    );
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        _controller = BetterPlayerController(
          config,
          betterPlayerDataSource: dataSource,
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
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Future.sync(() => Future.delayed(const Duration(milliseconds: 1000))),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _controller.isVideoInitialized()!
              ? GestureDetector(
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
              : const Center(child: CircularProgressIndicator(strokeWidth: 2));
        } else {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        }
      },
    );
  }
}

import 'dart:async';
import 'dart:typed_data';

import 'package:better_player/better_player.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../assets/assets.gen.dart';
import '../../../services/player_controller_services.dart';
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
        child: delegate.enableAutoPlay
            ? VideoPlayerWidget(delegate: delegate)
            : VideoThumbnailWidget(delegate: delegate),
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
    Uint8List? thumbnail;
    return FutureBuilder(
      future: Future.sync(() async => await VideoThumbnail.thumbnailData(
            video: delegate.mediaUrl,
            quality: 1,
          )),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          thumbnail = snapshot.data as Uint8List;
          return Image.memory(
            thumbnail!,
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

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.delegate,
  }) : super(key: key);

  final ExplorePostContentDelegate delegate;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  Uint8List? thumbnail;
  BetterPlayerController? _controller;
  late final BetterPlayerDataSource dataSource;
  final config = const BetterPlayerConfiguration(
    autoDispose: false,
    aspectRatio: 1 / 1,
    fit: BoxFit.cover,
    looping: true,
    allowedScreenSleep: false,
    controlsConfiguration: BetterPlayerControlsConfiguration(
      showControls: false,
    ),
  );
  final StreamController<BetterPlayerController?>
      playerControllerStreamController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    dataSource = BetterPlayerDataSource(
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
  }

  @override
  void dispose() {
    playerControllerStreamController.close();
    super.dispose();
  }

  void _setupController() {
    if (_controller == null) {
      _controller = PlayerControllerServices().getInstanceController(config);
      if (_controller != null) {
        _controller?.setupDataSource(dataSource);
        _controller?.addEventsListener(_onPlayerEvent);
        if (!playerControllerStreamController.isClosed) {
          playerControllerStreamController.add(_controller);
        }
      }
    }
  }

  void _freeController() {
    if (_controller != null && (_controller?.isVideoInitialized() ?? false)) {
      _controller?.removeEventsListener(_onPlayerEvent);
      PlayerControllerServices().freeController(_controller);
      _controller?.pause();
      _controller = null;
      if (!playerControllerStreamController.isClosed) {
        playerControllerStreamController.add(null);
      }
    }
  }

  void _onPlayerEvent(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
      if (!(_controller?.isPlaying() ?? false)) {
        _playVideo();
      }
    }
  }

  void _playVideo() {
    PlayerControllerServices().currentPlayingController = _controller;
    _controller?.setVolume(0);
    _controller?.play();
  }

  void _pauseVideo() {
    _controller?.pause();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(hashCode.toString() + DateTime.now().toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 1) {
          _setupController();
        } else {
          _freeController();
        }
      },
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: thumbnail == null
                  ? FutureBuilder(
                      future: Future.sync(
                          () async => await VideoThumbnail.thumbnailData(
                                video: widget.delegate.mediaUrl,
                              )),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          thumbnail = snapshot.data as Uint8List;
                          return Image.memory(
                            thumbnail!,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return const Center(
                            child: CupertinoActivityIndicator(radius: 15),
                          );
                        }
                      },
                    )
                  : Image.memory(
                      thumbnail!,
                      fit: BoxFit.cover,
                    ),
            ),
            StreamBuilder<BetterPlayerController?>(
              stream: playerControllerStreamController.stream,
              builder: (context, snapshot) {
                return _controller != null
                    ? AspectRatio(
                        aspectRatio: 1 / 1,
                        child: BetterPlayer(controller: _controller!),
                      )
                    : const Center(
                        child: CupertinoActivityIndicator(radius: 15),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

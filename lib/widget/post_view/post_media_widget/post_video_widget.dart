import 'dart:async';
import 'dart:typed_data';

import 'package:better_player/better_player.dart';
import 'package:cached_video_preview/cached_video_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../services/player_controller_services.dart';
import '../post_view.dart';
import 'post_media_widget.dart';

class PostVideoWidget extends PostMediaWidget {
  const PostVideoWidget({
    super.key,
    required super.size,
    required super.delegate,
    this.isShowLinker = true,
    this.visibleFraction = 0.8,
  }) : super(type: PostMediaType.video);

  final bool isShowLinker;
  final double visibleFraction;

  @override
  Widget buildMediaContent() {
    return VideoPlayerWidget(
        delegate: delegate, visibleFraction: visibleFraction);
  }

  @override
  Widget buildProductLinkerContent() {
    return isShowLinker ? super.buildProductLinkerContent() : const SizedBox();
  }
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.delegate,
    this.visibleFraction = 0.6,
  }) : super(key: key);

  final PostContentDelegate delegate;
  final double visibleFraction;

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
      widget.delegate.mediaUrls.first,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        key: widget.delegate.mediaUrls.first,
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
    _controller?.setVolume(1);
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
        if (info.visibleFraction >= widget.visibleFraction) {
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
            CachedVideoPreviewWidget(
              path: widget.delegate.mediaUrls.first,
              type: SourceType.remote,
              fileImageBuilder: (context, snapshot) {
                return AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.memory(
                    snapshot,
                    fit: BoxFit.cover,
                  ),
                );
              },
              placeHolder: const Center(
                child: CupertinoActivityIndicator(radius: 15),
              ),
            ),
            StreamBuilder<BetterPlayerController?>(
              stream: playerControllerStreamController.stream,
              builder: (context, snapshot) {
                return _controller != null
                    ? GestureDetector(
                        onTap: () {
                          _controller?.isPlaying() ?? false
                              ? _pauseVideo()
                              : _playVideo();
                        },
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: BetterPlayer(controller: _controller!),
                        ),
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

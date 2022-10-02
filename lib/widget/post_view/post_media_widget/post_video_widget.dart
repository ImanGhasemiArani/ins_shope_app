import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../services/player_controller_services.dart';
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
        PlayerControllerServices().currentPlayingController = _controller;
        _controller?.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(hashCode.toString() + DateTime.now().toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction >= 0.6) {
          _setupController();
        } else {
          _freeController();
        }
      },
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: StreamBuilder<BetterPlayerController?>(
          stream: playerControllerStreamController.stream,
          builder: (context, snapshot) {
            return _controller != null
                ? GestureDetector(
                    onTap: () {
                      _controller?.isPlaying() ?? false
                          ? _controller?.pause()
                          : _controller?.play();
                    },
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: BetterPlayer(controller: _controller!),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(strokeWidth: 2));
          },
        ),
      ),
    );
  }
}

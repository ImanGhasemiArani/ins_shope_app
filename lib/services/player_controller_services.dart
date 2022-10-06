import 'package:better_player/better_player.dart';
import 'package:get/get_utils/get_utils.dart';

class PlayerControllerServices {
  static final PlayerControllerServices _instance =
      PlayerControllerServices._internal();

  factory PlayerControllerServices() => _instance;

  PlayerControllerServices._internal();

  final List<BetterPlayerController> _controllerRegistry = [];
  final List<BetterPlayerController> _usedControllerRegistry = [];
  BetterPlayerController? _currentPlayingController;

  BetterPlayerController? getInstanceController(
      BetterPlayerConfiguration configuration) {
    if (_controllerRegistry.length < 3) {
      _controllerRegistry.add(BetterPlayerController(configuration));
    }

    final freeController = _controllerRegistry.firstWhereOrNull(
      (controller) => !_usedControllerRegistry.contains(controller),
    );

    if (freeController != null) {
      _usedControllerRegistry.add(freeController);
    }

    return freeController;
  }

  void freeController(BetterPlayerController? controller) {
    _usedControllerRegistry.remove(controller);
    if (_currentPlayingController == controller) {
      _currentPlayingController = null;
    }
  }

  set currentPlayingController(BetterPlayerController? controller) {
    _currentPlayingController?.pause();
    _currentPlayingController = controller;
  }

  void dispose() {
    _controllerRegistry.forEach((controller) => controller.dispose());
    _currentPlayingController = null;
  }
}

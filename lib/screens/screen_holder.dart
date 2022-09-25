import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'screen_home.dart';

// ignore: must_be_immutable
class ScreenHolder extends HookWidget {
  ScreenHolder({Key? key}) : super(key: key);

  late PageController _pageController;

  @override
  Widget build(BuildContext context) {
    _pageController = usePageController(initialPage: 0);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBody: true,
      body: PageView(
        controller: _pageController,
        children: const [
          ScreenHome(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../widget/loading_widget/loading_widget.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: LoadingWidget(),
    );
  }
}

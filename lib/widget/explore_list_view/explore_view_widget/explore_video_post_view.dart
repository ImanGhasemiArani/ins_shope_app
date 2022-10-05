import 'package:flutter/material.dart';

import 'explore_post_view.dart';

class ExploreVideoPostView extends ExplorePostView {
  const ExploreVideoPostView({
    super.key,
    required super.delegate,
  });

  @override
  Widget buildMediaContent() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.teal,
    );
  }

  @override
  Widget buildOverlayContent() {
    return const SizedBox();
  }
}

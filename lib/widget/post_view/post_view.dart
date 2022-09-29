import 'package:flutter/material.dart';

import 'post_footer_widget.dart';
import 'post_header_widget.dart';
import 'post_media_widget/post_media_widget.dart';

class PostView extends StatelessWidget {
  const PostView({super.key, required this.delegate});

  final PostContentDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PostHeaderWidget(delegate: delegate),
            PostMediaWidgetDelegate(delegate: delegate),
            PostFooterWidget(delegate: delegate),
          ],
        ),
      ),
    );
  }
}

class PostContentDelegate {
  final String username;
  final String location;
  final String profImgUrl;
  final String mediaUrl;
  final String caption;
  final int likesCount;
  bool isFollowing;
  bool isLiked;
  bool isBookmarked;

  final String productName;

  PostContentDelegate(
    this.username,
    this.location,
    this.profImgUrl,
    this.mediaUrl,
    this.caption,
    this.likesCount,
    this.productName, {
    this.isFollowing = false,
    this.isLiked = false,
    this.isBookmarked = false,
  });
}

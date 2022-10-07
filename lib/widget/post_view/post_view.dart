import 'package:figma_squircle/figma_squircle.dart';
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
            ClipSmoothRect(
              radius: SmoothBorderRadius(
                cornerRadius: 20,
                cornerSmoothing: 1,
              ),
              child: PostMediaWidgetDelegate(delegate: delegate),
            ),
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
  final PostMediaType mediaType;
  final List<String> mediaUrls;
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
    this.mediaUrls,
    this.caption,
    this.likesCount,
    this.productName,
    this.mediaType, {
    this.isFollowing = false,
    this.isLiked = false,
    this.isBookmarked = false,
  });

  // create copyWith method
  PostContentDelegate copyWith({
    String? username,
    String? location,
    String? profImgUrl,
    PostMediaType? mediaType,
    List<String>? mediaUrls,
    String? caption,
    int? likesCount,
    bool? isFollowing,
    bool? isLiked,
    bool? isBookmarked,
    String? productName,
  }) {
    return PostContentDelegate(
      username ?? this.username,
      location ?? this.location,
      profImgUrl ?? this.profImgUrl,
      mediaUrls ?? this.mediaUrls,
      caption ?? this.caption,
      likesCount ?? this.likesCount,
      productName ?? this.productName,
      mediaType ?? this.mediaType,
      isFollowing: isFollowing ?? this.isFollowing,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}

enum PostMediaType {
  image(['jpg', 'jpeg', 'png'], 1),
  video(['mp4'], 1),
  group(['jpg', 'jpeg', 'png', 'mp4'], 1),
  none([], 1);

  const PostMediaType(this.supportedExtensions, this.ratio);
  final List<String> supportedExtensions;
  final double ratio;

  static PostMediaType fromExtension(String extension) {
    extension = extension.toLowerCase().replaceAll('.', '');
    for (final type in values) {
      if (type.supportedExtensions.contains(extension)) {
        return type;
      }
    }
    return none;
  }
}

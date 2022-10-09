import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../post_view.dart';
import 'post_media_widget.dart';

class PostImageWidget extends PostMediaWidget {
  const PostImageWidget({
    super.key,
    required super.size,
    required super.delegate,
    this.isShowLinker = true,
  }) : super(type: PostMediaType.image);

  final bool isShowLinker;

  @override
  Widget buildMediaContent() {
    return CachedNetworkImage(
      imageUrl: delegate.mediaUrls.first,
      height: size.height,
      width: size.width,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, progress) => FittedBox(
        fit: BoxFit.scaleDown,
        child: Center(
          child: CupertinoActivityIndicator.partiallyRevealed(
            progress: progress.progress ?? 1,
            radius: 15,
          ),
        ),
      ),
      errorWidget: (context, url, error) => FittedBox(
        fit: BoxFit.scaleDown,
        child: Center(
          child: CupertinoButton(
            onPressed: null,
            child: Icon(
              CupertinoIcons.refresh_thin,
              size: 50,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildProductLinkerContent() {
    return isShowLinker ? super.buildProductLinkerContent() : const SizedBox();
  }
}

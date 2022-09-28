import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../lang/strs.dart';
import 'post_view.dart';

class PostHeaderWidget extends StatelessWidget {
  const PostHeaderWidget({
    super.key,
    required this.delegate,
  });

  final PostContentDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipSmoothRect(
          radius: SmoothBorderRadius(
            cornerRadius: 10,
            cornerSmoothing: 1,
          ),
          child: CachedNetworkImage(
            imageUrl: delegate.profImgUrl,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(delegate.username),
            Text(delegate.location),
          ],
        ),
        const SizedBox(width: 10),
        Text(
          '●',
          style: Get.textTheme.caption
              ?.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
        StatefulBuilder(builder: (context, setState) {
          return CupertinoButton(
            minSize: 0,
            padding: const EdgeInsets.all(10),
            onPressed: () {
              setState(() => delegate.isFollowing = !delegate.isFollowing);
              onFollowBtnPressed();
            },
            child: Text(
              delegate.isFollowing ? Strs.followingStr.tr : Strs.followStr.tr,
              style: Get.theme.textTheme.caption
                  ?.copyWith(color: Get.theme.colorScheme.onSurface),
            ),
          );
        }),
        const Spacer(),
        CupertinoButton(
          onPressed: onMoreBtnPressed,
          child: Icon(
            Icons.more_horiz_rounded,
            color: Get.theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  void onMoreBtnPressed() {}

  void onFollowBtnPressed() {}
}

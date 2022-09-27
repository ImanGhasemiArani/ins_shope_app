import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../assets/assets.gen.dart';
import '../../lang/strs.dart';
import 'post_view.dart';

class PostFooterWidget extends StatelessWidget {
  const PostFooterWidget({
    super.key,
    required this.delegate,
  });

  final PostContentDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            StatefulBuilder(
              builder: (context, setState) {
                return CupertinoButton(
                  minSize: 0,
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                    setState(() => delegate.isLiked = !delegate.isLiked);
                    onLikeBtnPressed();
                  },
                  child: delegate.isLiked
                      ? Assets.icons.heartBulk.svg(color: Colors.red)
                      : Assets.icons.heartTwoTone
                          .svg(color: Get.theme.colorScheme.onSurface),
                );
              },
            ),
            CupertinoButton(
              minSize: 0,
              padding: const EdgeInsets.all(10),
              onPressed: onCommentsBtnPressed,
              child: Assets.icons.messageTwoTone
                  .svg(color: Get.theme.colorScheme.onSurface),
            ),
            CupertinoButton(
              minSize: 0,
              padding: const EdgeInsets.all(10),
              onPressed: onShareBtnPressed,
              child: Assets.icons.send2TwoTone
                  .svg(color: Get.theme.colorScheme.onSurface),
            ),
            const Spacer(),
            StatefulBuilder(builder: (context, setState) {
              return CupertinoButton(
                minSize: 0,
                padding: const EdgeInsets.all(10),
                onPressed: () {
                  setState(
                      () => delegate.isBookmarked = !delegate.isBookmarked);
                  onBookmarkBtnPressed();
                },
                child: delegate.isBookmarked
                    ? Assets.icons.bookmarkBulk
                        .svg(color: Get.theme.colorScheme.onSurface)
                    : Assets.icons.bookmarkTwoTone
                        .svg(color: Get.theme.colorScheme.onSurface),
              );
            }),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                '${delegate.likesCount} ${Strs.likeStr.tr}',
                style: Get.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        // create expandable text for show caption
      ],
    );
  }

  void onLikeBtnPressed() {}

  void onCommentsBtnPressed() {}

  void onShareBtnPressed() {}

  void onBookmarkBtnPressed() {}
}

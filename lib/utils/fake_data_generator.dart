import 'dart:math';

import '../widget/ad_slider_widget/ad_slider_item.dart';
import '../widget/explore_list_view/explore_view_widget/explore_post_view.dart';
import '../widget/post_view/post_view.dart';
import '../widget/price_view/price_view.dart';
import '../widget/special_offers_content.dart/special_offers_item.dart';
import '../widget/story_content_Widget/story_item.dart';

const videoLink = [
  'https://s-v52.tamasha.com/statics/videos_file/f1/d3/k5j2M_f1d3ee539ded921a4113ab14073b54adea6f0a2c_n_360.mp4',
  'https://s-v52.tamasha.com/statics/videos_file/dd/60/EBamR_dd60ca4399bbdaf927c4d0cedd1b698bd59e4d73_n_360.mp4',
  'https://as-v2.tamasha.com/statics/videos_file/5d/48/5K7zG_5d48910e6fe4b194ae61f16e8126b58ba700023d_n_240.mp4',
  'https://s-v4.tamasha.com/statics/videos_file/23/0e/PJJZk_230e776a9f45738ea4ae2fa48de4f13543015dd9_n_240.mp4',
  'https://s-v4.tamasha.com/statics/videos_file/c2/04/x99KD_c204ecbac852bd02f177e720ac4fc9e8b55645cd_n_240.mp4',
  'https://as-v1.tamasha.com/statics/videos_file/52/af/ky16M_52af0b0322aeca5bdb5310c0d893e5ffffea5d48_n_360.mp4',
];

class FkDataGenerator {
  FkDataGenerator._();

  static List<StoryItemContentDelegate> generateStoryContentsDelegate() {
    final num = Random().nextInt(20) + 1;
    final num2 = Random().nextInt(num + 1);
    return List.generate(
      num,
      (index) => StoryItemContentDelegate(
        'https://picsum.photos/${index + 50}',
        index > num2,
        () {},
      ),
    );
  }

  static List<AdSliderItemContentDelegate> generateAdContentsDelegate() {
    return List.generate(
      Random().nextInt(10) + 1,
      (index) => AdSliderItemContentDelegate(
        'https://picsum.photos/${index + 500}/150',
        () {},
      ),
    );
  }

  static List<SpecOffersItemContentDelegate> generateSpecContentsDelegate() {
    return List.generate(
      Random().nextInt(20),
      (index) => SpecOffersItemContentDelegate(
        "کفش ورزشی آدیداس مدل تام کروز",
        'https://picsum.photos/${index + 100}',
        PriceContentDelegate(
          Random().nextInt(10000) * 1000,
          haveDiscount: true,
          discountPercent: Random().nextInt(100),
        ),
        () {},
      ),
    );
  }

  static List<PostContentDelegate> generatePostContentsDelegate() {
    return List.generate(
      10,
      (index) {
        final List<String> mediaLink;
        final r = Random().nextInt(3) % 3;
        final PostMediaType type;
        if (r == 0) {
          mediaLink = [videoLink[Random().nextInt(videoLink.length)]];
          type = PostMediaType.video;
        } else if (r == 1) {
          mediaLink = ['https://picsum.photos/${index + 500}'];
          type = PostMediaType.image;
        } else {
          mediaLink = List.generate(
            Random().nextInt(9) + 2,
            (index) {
              return Random().nextBool()
                  ? 'https://picsum.photos/${index + 600}'
                  : videoLink[Random().nextInt(videoLink.length)];
            },
          );
          type = PostMediaType.group;
        }
        return PostContentDelegate(
          'Iman.Casper',
          "Tehran, Iran",
          'https://picsum.photos/${Random().nextInt(50) + 50}',
          mediaLink..shuffle(),
          "میلیاردها انسان در جهان متولد شده اند؛ اما هیچ یک اثر انگشت مشابه نداشته‌اند. اثر انگشت تو، امضای خداوند است که اتفاقی به دنیا نیامده‌ای و دعوت شده‌ای تو منحصر به فردی مشابه یا بدل نداری تو اصل اصل هستی و تکرار نشدنی وقتی انتخاب شده بودن و منحصر به فرد بودنت را یادآوری کنی؛ دیگر خودت را با هیچکس مقایسه نمی‌کنی و احساس حقارت یا برتری که حاصل مقایسه کردن است از وجودت محو می‌شود.\n\nحسین الهی قمشه‌ای\n\n\n\n#Iman\n@Casper\n\n",
          Random().nextInt(10000),
          "کفش ورزشی",
          type,
          isFollowing: Random().nextBool(),
          isLiked: Random().nextBool(),
          isBookmarked: Random().nextBool(),
        );
      },
    );
  }

  /// generate formula for 2*2 video block: <p>
  ///  <h3> T(1) = 0 <p>
  ///       T(n) = T(n-1) + 9 + (-1)^n <p>
  /// <h4> Each Time in loadMore func, The length of the generated list must be 18n.
  static List<ExplorePostContentDelegate> generateExplorePostContentDelegate() {
    int o = -1;
    int currentIndex = 0;
    return List.generate(
      18 * 1,
      (index) {
        var enableAutoPlay = false;
        final List<String> mediaLink;
        final PostMediaType type;
        if (index == currentIndex) {
          mediaLink = [videoLink[Random().nextInt(videoLink.length)]];
          type = PostMediaType.video;
          o *= -1;
          currentIndex += 9 + o;
          enableAutoPlay = true;
        } else {
          final r = Random().nextInt(5) % 5;
          if (r == 0) {
            mediaLink = [videoLink[Random().nextInt(videoLink.length)]];
            type = PostMediaType.video;
          } else if (r == 1 || r == 2) {
            mediaLink = ['https://picsum.photos/${index + 500}'];
            type = PostMediaType.image;
          } else {
            mediaLink = List.generate(
              Random().nextInt(9) + 2,
              (index) => 'https://picsum.photos/${index + 600}',
            );
            type = PostMediaType.group;
          }
        }

        return ExplorePostContentDelegate(
          mediaLink..shuffle(),
          type,
          enableAutoPlay,
          () {},
        );
      },
    );
  }
}

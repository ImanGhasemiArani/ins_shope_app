import 'dart:math';

import 'package:path/path.dart' as p;

import '../widget/ad_slider_widget/ad_slider_tile.dart';
import '../widget/post_view/post_view.dart';
import '../widget/price_view/price_view.dart';
import '../widget/special_offers_content.dart/special_offers_tile.dart';
import '../widget/story_content_Widget/story_tile.dart';

class FkDataGenerator {
  FkDataGenerator._();

  static List<StoryTileContentDelegate> generateStoryContentsDelegate() {
    final num = Random().nextInt(20) + 1;
    final num2 = Random().nextInt(num + 1);
    return List.generate(
      num,
      (index) => StoryTileContentDelegate(
        'https://picsum.photos/${index + 50}',
        index > num2,
        () {},
      ),
    );
  }

  static List<AdSliderTileContentDelegate> generateAdContentsDelegate() {
    return List.generate(
      5,
      (index) => AdSliderTileContentDelegate(
        'https://picsum.photos/${index + 500}/150',
        () {},
      ),
    );
  }

  static List<SpecOffersTileContentDelegate> generateSpecContentsDelegate() {
    return List.generate(
      10,
      (index) => SpecOffersTileContentDelegate(
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
      7 + 3,
      (index) {
        final String mediaLink;
        if (index == 0) {
          mediaLink =
              'https://s-v4.tamasha.com/statics/videos_file/9f/04/GKPn7_9f04a2fdcd701870780773e474f10dbf21144c30_n_360.mp4';
        } else if (index == 1) {
          mediaLink =
              'https://s-v52.tamasha.com/statics/videos_file/f1/d3/k5j2M_f1d3ee539ded921a4113ab14073b54adea6f0a2c_n_360.mp4';
        } else if (index == 2) {
          mediaLink =
              'https://s-v52.tamasha.com/statics/videos_file/dd/60/EBamR_dd60ca4399bbdaf927c4d0cedd1b698bd59e4d73_n_360.mp4';
        } else {
          mediaLink = 'https://picsum.photos/${index + 500}';
        }
        return PostContentDelegate(
          'Iman.Casper',
          "Tehran, Iran",
          'https://picsum.photos/${Random().nextInt(50) + 50}',
          mediaLink,
          "میلیاردها انسان در جهان متولد شده اند؛ اما هیچ یک اثر انگشت مشابه نداشته‌اند. اثر انگشت تو، امضای خداوند است که اتفاقی به دنیا نیامده‌ای و دعوت شده‌ای تو منحصر به فردی مشابه یا بدل نداری تو اصل اصل هستی و تکرار نشدنی وقتی انتخاب شده بودن و منحصر به فرد بودنت را یادآوری کنی؛ دیگر خودت را با هیچکس مقایسه نمی‌کنی و احساس حقارت یا برتری که حاصل مقایسه کردن است از وجودت محو می‌شود.\n\nحسین الهی قمشه‌ای\n\n\n\n#Iman\n@Casper\n\n",
          Random().nextInt(10000),
          "کفش ورزشی",
          PostMediaType.fromExtension(p.extension(mediaLink)),
          isFollowing: Random().nextBool(),
          isLiked: Random().nextBool(),
          isBookmarked: Random().nextBool(),
        );
      },
    );
  }
}

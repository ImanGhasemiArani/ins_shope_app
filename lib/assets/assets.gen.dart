/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/arrow-circle-left-twoTone.svg
  SvgGenImage get arrowCircleLeftTwoTone =>
      const SvgGenImage('assets/icons/arrow-circle-left-twoTone.svg');

  /// File path: assets/icons/bag-2-bulk.svg
  SvgGenImage get bag2Bulk => const SvgGenImage('assets/icons/bag-2-bulk.svg');

  /// File path: assets/icons/bag-2-twoTone.svg
  SvgGenImage get bag2TwoTone =>
      const SvgGenImage('assets/icons/bag-2-twoTone.svg');

  /// File path: assets/icons/bookmark-bulk.svg
  SvgGenImage get bookmarkBulk =>
      const SvgGenImage('assets/icons/bookmark-bulk.svg');

  /// File path: assets/icons/bookmark-twoTone.svg
  SvgGenImage get bookmarkTwoTone =>
      const SvgGenImage('assets/icons/bookmark-twoTone.svg');

  /// File path: assets/icons/category-2-bulk.svg
  SvgGenImage get category2Bulk =>
      const SvgGenImage('assets/icons/category-2-bulk.svg');

  /// File path: assets/icons/category-2-twoTone.svg
  SvgGenImage get category2TwoTone =>
      const SvgGenImage('assets/icons/category-2-twoTone.svg');

  /// File path: assets/icons/direct-normal-twoTone.svg
  SvgGenImage get directNormalTwoTone =>
      const SvgGenImage('assets/icons/direct-normal-twoTone.svg');

  /// File path: assets/icons/direct-notification-twoTone.svg
  SvgGenImage get directNotificationTwoTone =>
      const SvgGenImage('assets/icons/direct-notification-twoTone.svg');

  /// File path: assets/icons/heart-bulk.svg
  SvgGenImage get heartBulk => const SvgGenImage('assets/icons/heart-bulk.svg');

  /// File path: assets/icons/heart-twoTone.svg
  SvgGenImage get heartTwoTone =>
      const SvgGenImage('assets/icons/heart-twoTone.svg');

  /// File path: assets/icons/home-1-bulk.svg
  SvgGenImage get home1Bulk =>
      const SvgGenImage('assets/icons/home-1-bulk.svg');

  /// File path: assets/icons/home-1-twoTone.svg
  SvgGenImage get home1TwoTone =>
      const SvgGenImage('assets/icons/home-1-twoTone.svg');

  /// File path: assets/icons/message-twoTone.svg
  SvgGenImage get messageTwoTone =>
      const SvgGenImage('assets/icons/message-twoTone.svg');

  /// File path: assets/icons/more-2-twoTone.svg
  SvgGenImage get more2TwoTone =>
      const SvgGenImage('assets/icons/more-2-twoTone.svg');

  /// File path: assets/icons/profile-bulk.svg
  SvgGenImage get profileBulk =>
      const SvgGenImage('assets/icons/profile-bulk.svg');

  /// File path: assets/icons/profile-twoTone.svg
  SvgGenImage get profileTwoTone =>
      const SvgGenImage('assets/icons/profile-twoTone.svg');

  /// File path: assets/icons/search-normal-1-bulk.svg
  SvgGenImage get searchNormal1Bulk =>
      const SvgGenImage('assets/icons/search-normal-1-bulk.svg');

  /// File path: assets/icons/search-normal-1-twoTone.svg
  SvgGenImage get searchNormal1TwoTone =>
      const SvgGenImage('assets/icons/search-normal-1-twoTone.svg');

  /// File path: assets/icons/send-2-twoTone.svg
  SvgGenImage get send2TwoTone =>
      const SvgGenImage('assets/icons/send-2-twoTone.svg');
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double width = 24,
    double height = 24,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;
}

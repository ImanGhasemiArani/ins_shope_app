import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextStyles {
  TextStyles._();

  static final headline6Bold = TextStyle(
    fontFamily: Get.theme.textTheme.headline6?.fontFamily,
    fontStyle: Get.theme.textTheme.headline6?.fontStyle,
    fontSize: Get.theme.textTheme.headline6?.fontSize,
    fontWeight: FontWeight.bold,
    // fontWeight: Get.theme.textTheme.headline5?.fontWeight,
    letterSpacing: Get.theme.textTheme.headline6?.letterSpacing,
  );
}

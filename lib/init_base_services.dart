import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'services/localization_service.dart';
import 'services/service_locator.dart';

Future<void> initBaseServices() async {
  sharedPreferences = await SharedPreferences.getInstance();
  Get.put(LocalizationService('فارسی'));
  Get.put(ThemeController(ThemeMode.values
      .byName(sharedPreferences.getString("themeMode") ?? "system")));
}

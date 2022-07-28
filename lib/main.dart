import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'init_app_start.dart';
import 'lang/strs.dart';
import 'screens/screen_holder.dart';
import 'services/localization_service.dart';
import 'services/service_locator.dart';
import 'utils/log.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  await initAppStart();
  runApp(const MainMaterial());
}

class MainMaterial extends StatelessWidget {
  const MainMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logging("Start App", isShowTime: true);
    LocalizationService localizationService = Get.find();
    return Builder(builder: (context) {
      final ThemeController themeController = Get.find();
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: localizationService.locale,
        fallbackLocale: LocalizationService.fallBackLocale,
        translations: localizationService,
        textDirection: TextDirection.ltr,
        themeMode: themeController.mode,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: LocalizationService.fontFamily,
          textTheme: const TextTheme().copyWith(
            button: const TextStyle().copyWith(
              fontFamily: LocalizationService.fontFamily,
            ),
          ),
          brightness: Brightness.light,
          colorScheme: const ColorScheme.light().copyWith(
              // background: const Color(0xff001021),
              // onBackground: const Color(0xffefedff),
              // surface: const Color(0xff0a174e),
              // onSurface: const Color(0xffefedff),
              // primary: const Color(0xfff5d042),
              // onPrimary: const Color(0xff0a174e),
              ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          fontFamily: LocalizationService.fontFamily,
          textTheme: const TextTheme().copyWith(
            button: const TextStyle().copyWith(
              fontFamily: LocalizationService.fontFamily,
            ),
          ),
          brightness: Brightness.dark,
          colorScheme: const ColorScheme.dark().copyWith(
            background: const Color(0xff001021),
            onBackground: const Color(0xffefedff),
            surface: const Color(0xff0a174e),
            onSurface: const Color(0xffefedff),
            primary: const Color(0xfff5d042),
            onPrimary: const Color(0xff0a174e),
          ),
        ),
        title: Strs.appNameStr.tr,
        home: const ScreenApp(),
      );
    });
  }
}

class ScreenApp extends StatelessWidget {
  const ScreenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: FutureBuilder(
        future: setupServices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ScreenHolder();
          } else {
            return const ScreenSplash();
          }
        },
      ),
    );
  }
}

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: LoadingAnimationWidget.dotsTriangle(
          color: const Color(0xfff5d042),
          size: 40,
        ),
      ),
    );
  }
}

class ThemeController {
  late ThemeMode _mode;

  ThemeController(this._mode);

  ThemeMode get mode => _mode;

  set mode(ThemeMode themeMode) {
    _mode = themeMode;
    sharedPreferences.setString("themeMode", _mode.name);
  }
}

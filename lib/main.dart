import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'init_base_services.dart';
import 'lang/strs.dart';
import 'screens/screen_holder.dart';
import 'screens/screen_splash.dart';
import 'services/localization_service.dart';
import 'services/service_locator.dart';
import 'utils/log.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  await initBaseServices();
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
        textDirection: LocalizationService.textDirection,
        themeMode: themeController.mode,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
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
    Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: FutureBuilder(
        future: setupServices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // FlutterNativeSplash.remove();
            return const ScreenHolder();
          } else {
            return const ScreenSplash();
          }
        },
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

class Themes {
  Themes._();

  static final lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: LocalizationService.fontFamily,
    textTheme: const TextTheme().copyWith(
      button: const TextStyle().copyWith(
        fontFamily: LocalizationService.fontFamily,
      ),
    ),
    appBarTheme: const AppBarTheme().copyWith(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      color: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    cardTheme: CardTheme(
      clipBehavior: Clip.antiAlias,
      elevation: 8,
      color: const Color(0xffFFFFFF),
      surfaceTintColor: const Color(0xffFFFFFF),
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 20,
          cornerSmoothing: 1,
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xff00AFCE),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xffF4FAFA),
    colorScheme: const ColorScheme.light().copyWith(
      background: const Color(0xffF4FAFA),
      onBackground: const Color(0xff353334),
      surface: const Color(0xffFFFFFF),
      onSurface: const Color(0xff353334),
      primary: const Color(0xffF38138),
      secondary: const Color(0xff00AFCE),
      tertiary: const Color(0xff008001),
      errorContainer: const Color(0xFFF44336).withOpacity(0.5),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: LocalizationService.fontFamily,
    textTheme: const TextTheme().copyWith(
      button: const TextStyle().copyWith(
        fontFamily: LocalizationService.fontFamily,
      ),
    ),
    appBarTheme: const AppBarTheme().copyWith(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      color: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    cardTheme: CardTheme(
      clipBehavior: Clip.antiAlias,
      elevation: 8,
      color: const Color(0xff16202A),
      surfaceTintColor: const Color(0xff16202A),
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 20,
          cornerSmoothing: 1,
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xff00AFCE),
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff192734),
    colorScheme: const ColorScheme.dark().copyWith(
      background: const Color(0xff192734),
      onBackground: const Color(0xffFAFAFA),
      surface: const Color(0xff16202A),
      onSurface: const Color(0xffFAFAFA),
      primary: const Color(0xffF38138),
      secondary: const Color(0xff00AFCE),
      tertiary: const Color(0xff008001),
      errorContainer: const Color(0xFFF44336).withOpacity(0.5),
    ),
  );
}

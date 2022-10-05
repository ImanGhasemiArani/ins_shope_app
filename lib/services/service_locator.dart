import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

Future<void> setupServices() async {
  await Future.delayed(const Duration(seconds: 5));
  await _setupServiceLocator();
}

Future<void> _setupServiceLocator() async {}

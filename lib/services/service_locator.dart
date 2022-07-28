import 'package:shared_preferences/shared_preferences.dart';


late SharedPreferences sharedPreferences;
bool isShowDialog = false;

Future<void> setupServices() async {
  await _setupServiceLocator();
}

Future<void> _setupServiceLocator() async {

}
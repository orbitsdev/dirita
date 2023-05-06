




import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager  {
  

  static final String _showOnBoardingKey = 'showOnBoarding';

  static Future<bool> getShowOnBoarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_showOnBoardingKey) ?? false;
  }

  static Future<bool> setShowOnBoarding(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_showOnBoardingKey, value);
  }

    static final String _enableWelcomeMessage = 'enableWelcomeMessage';

    static Future<bool> getenableWelcomeMessage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_enableWelcomeMessage) ?? false;
  }

  static Future<bool> setenableWelcomeMessage(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_enableWelcomeMessage, value);
  }
  

 static final String _currentLanguage = 'currentLanguage';

    static Future<String> getcurrentLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentLanguage) ?? 'en';
  }

  static Future<bool> setcurrentLanguage(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_currentLanguage, value);
  }
}
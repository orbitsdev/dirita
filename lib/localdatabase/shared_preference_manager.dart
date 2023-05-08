




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


  // for  setrings

  static final String _enableWelcomeVoice = 'enableWelcomeVoice';

  static Future<bool> getEnableWelcomeVoice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_enableWelcomeVoice) ?? true;
  }

  static Future<bool> setEnableWelcomeVoice(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_enableWelcomeVoice, value);
  }


  static final String _enableTranslationVoice = '_enableTranslationVoice';

  static Future<bool> getEnableTranslationVoice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_enableTranslationVoice) ?? true;
  }

  static Future<bool> setEnableTranslationVoice(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_enableTranslationVoice, value);
  }

  static final String _enableRouteVoice = 'enableRouteVoice';

  static Future<bool> getEnableRouteVoice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_enableRouteVoice) ?? true;
  }

  static Future<bool> setEnableRouteVoice(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_enableRouteVoice, value);
  }
  static final String _enableSharedExperienceVoice = 'enableSharedExperienceVoice';

  static Future<bool> getEnableSharedExperienceVoice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_enableSharedExperienceVoice) ?? true;
  }

  static Future<bool> setEnableSharedExperienceVoice(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_enableSharedExperienceVoice, value);
  }
  
}
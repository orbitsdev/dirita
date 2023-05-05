






import 'package:dirita_tourist_spot_app/ai/voice_data.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class TextToSpeechController {
   static FlutterTts flutterTts = FlutterTts();


  //  var selectedLanguageCode = 'en_US'.obs;

  //  void setLanguage(String language){
  //     selectedLanguageCode(language);
  //  }

  static Future<void> speak(String message) async {
 
  //  List<dynamic> languages = await flutterTts.getLanguages;

  // for (String language in languages) {
  //   print(language);
  // }
    await flutterTts.speak(message);
  }
}
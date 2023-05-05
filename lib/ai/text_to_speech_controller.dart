import 'package:dirita_tourist_spot_app/ai/voice_data.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class TextToSpeechController {
  static FlutterTts flutterTts = FlutterTts();
  static GoogleTranslator translator = GoogleTranslator();

  static Future<void> speak(String message) async {
    // await flutterTts.setLanguage("tl");
    // await flutterTts.speak(message);

    await flutterTts.setSpeechRate(0.4); // Adjust speech rate to 0.5
    await flutterTts.setPitch(1.0);


    await flutterTts.getDefaultVoice; // Adjust pitch
    await flutterTts.speak(message);
  }

  static Future<String> convertMessageToSelectedLanguage(
      {required String message, String? code = 'en'}) async {
    String result = await translator
        .translate(message, to: code!.toLowerCase())
        .then((output) {
      return output.text;
    });
    print(result);
    return result;
  }
}

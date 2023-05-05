import 'package:dirita_tourist_spot_app/ai/text_to_speech_controller.dart';
import 'package:dirita_tourist_spot_app/config/google_translator_config.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:translator/translator.dart';

class TlTest extends StatefulWidget {
  const TlTest({ Key? key }) : super(key: key);

  @override
  State<TlTest> createState() => _TlTestState();
}

class _TlTestState extends State<TlTest> {


final input = "hEllpwHw";
  final message = TextEditingController(text: 'I country codes:');

final translator = GoogleTranslator();





void speak(BuildContext context) async {
  
  try{

    await  translator.translate(message.text, to: 'zh-tw').then((output){
  print(output);
  // TextToSpeechController.speak(output.text);
  });
  }catch(e){
    Modal.showErrorDialog(context: context, message: e.toString());
  }
  

}
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('DEMO'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          TextField(
            controller: message,
          ),
          Container(),
          // Text('Demo'),
          // CountryCodePicker(
          //   onChanged: (country){
          //     print("New Country selected: " + country.toString() +country.code.toString());
          //   },
          //   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
          //   initialSelection: 'PH',

          //   // optional. Shows only country name and flag
          //   showCountryOnly: false,
          //   // optional. Shows only country name and flag when popup is closed.
          //   showOnlyCountryWhenClosed: false,
          //   // optional. aligns the flag and the Text left
          //   alignLeft: false,
          // ),
          // ElevatedButton(onPressed: () {
          //   speak();
          // }, child: Text('Translate')),
          Builder(
            builder: (context) {
              return ElevatedButton(onPressed: ()=> speak(context), child: Text('Speak'));
            }
          ),
          
        ],
      ),
    );
  }
}

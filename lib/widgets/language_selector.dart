import 'dart:convert';
import 'package:dirita_tourist_spot_app/tydef.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class LanguageSelector extends StatefulWidget {
  final String? initialValue;
  final LanguageSelectionCallback? onLanguageChanged;

  LanguageSelector({this.initialValue, this.onLanguageChanged});

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  List<dynamic> _languages = [];
  String? _selectedLanguageCode;

  @override
  void initState() {
    super.initState();
    _loadLanguages();
    _selectedLanguageCode = widget.initialValue;
  }

  Future<void> _loadLanguages() async {
    String jsonString = await rootBundle.loadString('assets/supported_languages.json');
    final data = await json.decode(jsonString);
    setState(() {
      _languages = data['text'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedLanguageCode,
      onChanged: (String? newValue) {
        setState(() {
          _selectedLanguageCode = newValue;
        });
        if (widget.onLanguageChanged != null) {
          widget.onLanguageChanged!(_selectedLanguageCode!);
        }
      },
      items: _languages.map<DropdownMenuItem<String>>((dynamic language) {
        return DropdownMenuItem<String>(
          value: language['code'],
          child: Text(language['language']),
        );
      }).toList(),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LanguageDropdown extends StatefulWidget {
  final ValueChanged<Map<String, String>> onChanged;

  LanguageDropdown({required this.onChanged});

  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String _selectedLanguageCode = "";
  List<dynamic> _languageData = [];

  @override
  void initState() {
    super.initState();
    _loadLanguageData();
  }

  Future<void> _loadLanguageData() async {
    String data = await rootBundle.loadString('assets/supported_languages.json');
    setState(() {
      _languageData = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedLanguageCode,
      onChanged: (String? value) {
        setState(() {
          _selectedLanguageCode = value!;
        });
        Map<String, String> selectedLanguage = _getSelectedLanguage();
        widget.onChanged(selectedLanguage);
      },
      items: _languageData.map<DropdownMenuItem<String>>((dynamic language) {
        return DropdownMenuItem<String>(
          value: language['code'],
          child: Text(language['name']),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Select Language',
        border: OutlineInputBorder(),
      ),
    );
  }

  Map<String, String> _getSelectedLanguage() {
    Map<String, String> selectedLanguage = {"name": "", "code": ""};
    for (int i = 0; i < _languageData.length; i++) {
      if (_languageData[i]['code'] == _selectedLanguageCode) {
        selectedLanguage['name'] = _languageData[i]['name'];
        selectedLanguage['code'] = _languageData[i]['code'];
        break;
      }
    }
    return selectedLanguage;
  }
}

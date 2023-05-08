import 'package:dirita_tourist_spot_app/localdatabase/shared_preference_manager.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isWelcomeVoiceEnabled = false;
  bool _isTranslationAssistanceEnabled = false;
  bool _isRouteEnabled = false;
  bool _isSharedExperienceEnabled = false;

  @override
  void initState() {
    super.initState();
    setInitialValue();
  }

  void setInitialValue() async {
    final isWelcomVoiceEnabled = await SharedPreferencesManager.getEnableWelcomeVoice();
    final isTranslationEnabled = await SharedPreferencesManager.getEnableTranslationVoice();
    final isRoutingEnabled =  await SharedPreferencesManager.getEnableRouteVoice();
    final isSharedExperienceEnabled =  await SharedPreferencesManager.getEnableSharedExperienceVoice();

    setState(() {
      _isWelcomeVoiceEnabled = isWelcomVoiceEnabled;
      _isTranslationAssistanceEnabled = isTranslationEnabled;
      _isRouteEnabled = isRoutingEnabled;
      _isSharedExperienceEnabled = isSharedExperienceEnabled;
    });
  }

  void setWelcomVoice(bool value) async {
    setState(() {
      _isWelcomeVoiceEnabled = value;
    });
    await SharedPreferencesManager.setEnableWelcomeVoice(_isWelcomeVoiceEnabled);
  }

  void setTranslationVoice(bool value) async {
    setState(() {
      _isTranslationAssistanceEnabled = value;
    });
    await SharedPreferencesManager.setEnableTranslationVoice(
        _isTranslationAssistanceEnabled);
  }

  void setRoutingVoice(bool value) async {
    setState(() {
      _isRouteEnabled = value;
    });
    await SharedPreferencesManager.setEnableRouteVoice(_isRouteEnabled);
  }
  void setSharedExperienceVoice(bool value) async {
    setState(() {
      _isSharedExperienceEnabled = value;
    });
    await SharedPreferencesManager.setEnableSharedExperienceVoice(_isSharedExperienceEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(children: [
        SwitchListTile.adaptive(
          title: Text('Enable Welcoming Voice'),
          value: _isWelcomeVoiceEnabled,
          onChanged: (value) => setWelcomVoice(value),
          inactiveTrackColor: Colors.grey.shade50,
          activeColor: Colors.orange,
          inactiveThumbColor: Colors.grey.shade500,
          tileColor: null,
          shape: RoundedRectangleBorder(),
        ),
        SwitchListTile.adaptive(
          title: Text('Enable Language Voice On Open '),
          value: _isTranslationAssistanceEnabled,
          onChanged: (value) => setTranslationVoice(value),
          inactiveTrackColor: Colors.grey.shade50,
          activeColor: Colors.orange,
          inactiveThumbColor: Colors.grey.shade500,
          tileColor: null,
          shape: RoundedRectangleBorder(),
        ),
        SwitchListTile.adaptive(
          title: Text('Enable Voice  After generating routes '),
          value: _isRouteEnabled,
          onChanged: (value) => setRoutingVoice(value),
          inactiveTrackColor: Colors.grey.shade50,
          activeColor: Colors.orange,
          inactiveThumbColor: Colors.grey.shade500,
          tileColor: null,
          shape: RoundedRectangleBorder(),
        ),
        SwitchListTile.adaptive(
          title: Text('Enable Voice On Opening All Post '),
          value: _isSharedExperienceEnabled,
          onChanged: (value) => setSharedExperienceVoice(value),
          inactiveTrackColor: Colors.grey.shade50,
          activeColor: Colors.orange,
          inactiveThumbColor: Colors.grey.shade500,
          tileColor: null,
          shape: RoundedRectangleBorder(),
        ),
      ]),
    );
  }
}

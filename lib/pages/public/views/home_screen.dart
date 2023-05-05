import 'package:country_code_picker/country_code_picker.dart';
import 'package:dirita_tourist_spot_app/ai/text_to_speech_controller.dart';
import 'package:dirita_tourist_spot_app/ai/voice_data.dart';
import 'package:dirita_tourist_spot_app/constants/firebase_constant.dart';
import 'package:dirita_tourist_spot_app/pages/auth/controller/auth_controller.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/current_location_screen.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_screen.dart';
import 'package:dirita_tourist_spot_app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../delegates/tourist_spot_search_delegate.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/modal.dart';
import '../../../widgets/h_space.dart';

import '../../../widgets/spot_card_widget.dart';
import 'tourist_spot_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authcontroller = Get.find<AuthController>();

  FlutterTts flutterTts = FlutterTts();


  int _currentIndex = 0;

  List<Widget> _pages = [
    TouristScreen(),
    Container(
        child: Center(
      child: Text(
        'page2',
        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
      ),
    )),
    CurrentLocationScreen(),
    Container(
        child: Center(
      child: Text(
        'page4',
        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
      ),
    )),
    
  ];

  void openDrawer(context) {
    Scaffold.of(context).openDrawer();
  }

  void _speakWelcomeMessage() async{
      TextToSpeechController.speak(VoiceAiSpeech.welcomeMessage);

}
  @override
  void initState() {
    super.initState();
    _speakWelcomeMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.BACKGROUND,
      drawer: Drawer(
        child: GetBuilder<AuthController>(
          builder: (controller) => SafeArea(
            child: ListView(children: [
              Container(
                  height: 150,
                  color: AppTheme.ORANGE,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'YOW'.toUpperCase(),
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  )),
              HSpace(40),
              if (auth.currentUser != null)
                ListTile(
                    onTap: () => controller.logout(context),
                    leading: Icon(
                      Icons.logout,
                      color: AppTheme.FONT,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(fontSize: 18, color: AppTheme.FONT),
                    )),

                    CountryCodePicker(
         onChanged: (contry){
          print("New Country selected: " + contry.toString() +contry.code.toString());
         },
         // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
         initialSelection: 'PH',
         
         // optional. Shows only country name and flag
         showCountryOnly: false,
         // optional. Shows only country name and flag when popup is closed.
         showOnlyCountryWhenClosed: false,
         // optional. aligns the flag and the Text left
         alignLeft: false,
       ),
            ]),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () => openDrawer(context),
              icon: const Icon(
                Icons.menu,
                color: AppTheme.ORANGE,
              ));
        }),
        title: Text(
          'Home ',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: AppTheme.FONT,
              ),
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: TouristSpotSearchDelegate()),
                icon: const Icon(Icons.search));
          }),
          if (auth.currentUser == null)
            GetBuilder<AuthController>(
              builder: (controller) => TextButton(
                onPressed: () => Modal.showBottomSheet(context),
                child: Text(
                  'Signin',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppTheme.ORANGE,
                      ),
                ),
              ),
            ),
          if (auth.currentUser != null)
            GetBuilder<AuthController>(
                builder: (controller) => IconButton(
                      onPressed: () => {},
                      icon: ProfileWidget(
                        url: controller.user.value.profile_image,
                      ),
                    )),
          const HSpace(20),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            unselectedColor: Colors.grey.shade600,
            icon: Icon(Icons.home_outlined),
            title: Text("Public"),
            selectedColor: AppTheme.ORANGE,
          ),
          /// Likes
          SalomonBottomBarItem(
            unselectedColor: Colors.grey.shade600,
            icon: Icon(Icons.favorite_border),
            title: Text("Favorites"),
            selectedColor: AppTheme.ORANGE,
          ),
          /// Search
          /// Profile
          SalomonBottomBarItem(
            unselectedColor: Colors.grey.shade600,
            icon: Icon(Icons.pin_drop_outlined),
            title: Text("Location"),
            selectedColor: AppTheme.ORANGE,
          ),
          SalomonBottomBarItem(
            unselectedColor: Colors.grey.shade600,
            icon: Icon(Icons.settings_outlined),
            title: Text("Location"),
            selectedColor: AppTheme.ORANGE,
          ),
         
        ],
      ),
    );
  }
}

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dirita_tourist_spot_app/ai/text_to_speech_controller.dart';
import 'package:dirita_tourist_spot_app/ai/voice_data.dart';
import 'package:dirita_tourist_spot_app/constants/firebase_constant.dart';
import 'package:dirita_tourist_spot_app/delegates/tourist_spot_search_delegate.dart';
import 'package:dirita_tourist_spot_app/pages/auth/controller/auth_controller.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/current_location_screen.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/profile_screen.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_screen.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/utils/asset.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
        'This feature is not availble',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    )),
    CurrentLocationScreen(),
     Container(
        child: Center(
      child: Text(
        'This feature is not availble',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    )),
  ];

  void openDrawer(context) {
    Scaffold.of(context).openDrawer();
  }

  void openEndDrawer(context) {
    Scaffold.of(context).openEndDrawer();
  }

  void _speakWelcomeMessage() async {
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
      drawer: Drawer(),
      endDrawer: Drawer(
        child: GetBuilder<AuthController>(
          builder: (controller) => SafeArea(
            child: ListView(children: [
              Container(
                  height: 100,
                  color: AppTheme.ORANGE,
                  padding: EdgeInsets.all(10),
                  child: Image.asset(Asset.imagePath('dirita_logo.png')),),
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
              if (auth.currentUser != null)
                ListTile(
                    onTap: (){
                     
                      Get.to(()=> ProfileScreen());
                    },
                    leading: Icon(
                      Icons.person_2_outlined,
                      color: AppTheme.FONT,
                    ),
                    title: Text(
                      'Profile',
                      style: TextStyle(fontSize: 18, color: AppTheme.FONT),
                    )),
            ]),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) {
            return IconButton(onPressed: ()=>openDrawer(context), icon: Icon(Icons.menu , color: AppTheme.ORANGE,));
          }
        ),
        title: Text(
          'Home ',
          
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
                onPressed: () => Modal.showLoginBottomSheet(context),
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
            Builder(
                builder: (context) => IconButton(
                      onPressed: () => openEndDrawer(context),
                      icon: ProfileWidget(),
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

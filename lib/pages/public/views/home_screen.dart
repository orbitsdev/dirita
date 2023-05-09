import 'package:alan_voice/alan_voice.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dirita_tourist_spot_app/ai/text_to_speech_controller.dart';
import 'package:dirita_tourist_spot_app/ai/voice_data.dart';
import 'package:dirita_tourist_spot_app/constants/firebase_constant.dart';
import 'package:dirita_tourist_spot_app/delegates/tourist_spot_search_delegate.dart';
import 'package:dirita_tourist_spot_app/localdatabase/shared_preference_manager.dart';
import 'package:dirita_tourist_spot_app/pages/admin/views/settings_screen.dart';
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
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

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
    CurrentLocationScreen(),
    SettingsScreen(),
  ];

  void openDrawer(context) {
    Scaffold.of(context).openDrawer();
  }

  void openEndDrawer(context) {
    Scaffold.of(context).openEndDrawer();
  }

  void _speakWelcomeMessage() async {
     final enabled = await SharedPreferencesManager.getEnableWelcomeVoice();

     if(enabled){
       TextToSpeechController.speak(VoiceAiSpeech.welcomeMessage);
     }
   
  }

  @override
  void initState() {
    super.initState();
    _speakWelcomeMessage();
      // _initSpeech();
  }

// _HomeScreenState() {
//   /// Init Alan Button with project key from Alan AI Studio      
//   AlanVoice.addButton("105ab5588b84cc059beb71910ead599e2e956eca572e1d8b807a3e2338fdd0dc/stage", buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT,     );

//   /// Handle commands from Alan AI Studio
//   AlanVoice.onCommand.add((command) {
//     handleCommand(command.data);
//   });
// }

  void handleCommand(Map<String,dynamic> command){

    //  print(command['command']);

        switch(command['command']){
          case 'open-search-bar':
          openSearchBar();
          break;

          case 'about-tourist':
          openSearchBar();
          break;

          case 'more-information-about-tourist':
          openSearchBar();
          break;

          case 'generate-route':
          openSearchBar();
          break;

          case 'close-search-bar':
             Get.back();
          break;

          case 'back':
          openSearchBar();
          break;

          case 'open-tourist-list':
          Get.to(()=> HomeScreen());
          break;
          case 'open-settings':
          print('HEllowdasdasdasdasd');
          print('__________________________________');
          setState(() {
            _currentIndex = 2;
          });
          break;
        }
   }

   void openSearchBar(){
    showSearch(context: context, delegate: TouristSpotSearchDelegate());
   }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.BACKGROUND,
     
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
        // leading: Builder(
        //   builder: (context) {
        //     return IconButton(onPressed: ()=>openDrawer(context), icon: Icon(Icons.menu , color: AppTheme.ORANGE,));
        //   }
        // ),
        title: Text(
          'Home'.toUpperCase(),

          
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () => showSearch(context: context, delegate: TouristSpotSearchDelegate()),
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
            title: Text("Settings"),
            selectedColor: AppTheme.ORANGE,
          ),
        ],
      ),

      
    );
  }
}

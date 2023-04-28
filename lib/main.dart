import 'package:dirita_tourist_spot_app/pages/auth/views/login_screen.dart';
import 'package:dirita_tourist_spot_app/pages/auth/views/signup_screen.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/home_screen.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_details_screen.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/auth/views/account_selection_screen.dart';
import 'pages/onboarding/views/boarding_screen.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showOnBoarding = prefs.getBool('showOnBoarding') ?? false;
  runApp( DiritaApp(showOnBoarding:showOnBoarding ,));
}

class DiritaApp extends StatefulWidget {
  final bool showOnBoarding;
  const DiritaApp({super.key, required this.showOnBoarding});


  @override
  _DiritaAppState createState() => _DiritaAppState();
}

class _DiritaAppState extends State<DiritaApp> {


  Widget authscreenlogic(){

    return HomeScreen();
    return AccountSelectionScreen();
      // if(widget.showOnBoarding  ==  false){
      //     return  const BoardingScreen();
      // }else{
      //  return   HomeScreen();
      // }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorSchemeSeed: AppTheme.ORANGE,
        useMaterial3: true,
        textTheme: AppTheme.CUSTOM_TEXT_THEME,
      ),
      debugShowCheckedModeBanner: false,
      home: authscreenlogic(),
      getPages: [
        GetPage(name: '/boarding', page: () => const BoardingScreen()),
        GetPage(name: '/home', page: () => HomeScreen(), transition: Transition.cupertino),
        GetPage(name: '/select-account-type', page: () => AccountSelectionScreen()),
        GetPage(name: '/spot-details', page: () => TouristSpotDetails()),
        GetPage(name: '/login', page: () => LoginScreen(), transition: Transition.cupertino),
        GetPage(name: '/register', page: () => SignupScreen(), transition: Transition.cupertino),
        GetPage(name: '/account-selection', page: () => AccountSelectionScreen(), transition: Transition.cupertino),
      ],
    );
  }
}

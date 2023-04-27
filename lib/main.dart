import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/auth/views/account_selection_screen.dart';
import 'pages/onboarding/views/boarding_screen.dart';
import 'pages/public/home_screen.dart';

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
        textTheme: TextTheme(
          displayLarge: GoogleFonts.openSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: GoogleFonts.openSans(
            fontSize: 16,

          ),
          bodyLarge: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          bodyMedium: GoogleFonts.openSans(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: authscreenlogic(),
      getPages: [
        GetPage(name: '/boarding', page: () => const BoardingScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/select-account-type', page: () => AccountSelectionScreen()),
      ],
    );
  }
}

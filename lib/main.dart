import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dirita_tourist_spot_app/binding/app_binding.dart';
import 'package:dirita_tourist_spot_app/localdatabase/shared_preference_manager.dart';
import 'package:dirita_tourist_spot_app/pages/admin/views/admin_screen.dart';
import 'package:dirita_tourist_spot_app/pages/admin/views/privacy_and_policy.dart';
import 'package:dirita_tourist_spot_app/pages/admin/views/select_tourist_location_map_screen.dart';
import 'package:dirita_tourist_spot_app/pages/admin/views/settings_screen.dart';
import 'package:dirita_tourist_spot_app/pages/admin/views/terms_and_condtion.dart';
import 'package:dirita_tourist_spot_app/pages/admin/views/update_tourist_spot_screen.dart';
import 'package:dirita_tourist_spot_app/pages/auth/controller/auth_controller.dart';
import 'package:dirita_tourist_spot_app/pages/auth/views/login_screen.dart';
import 'package:dirita_tourist_spot_app/pages/auth/views/signup_screen.dart';
import 'package:dirita_tourist_spot_app/pages/full_screen_image.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/current_location_screen.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/home_screen.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/list_spots.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/profile_screen.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/report_screen.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_details_screen.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_location.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/update_profile_screen.dart';
import 'package:dirita_tourist_spot_app/tl.test.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/loader_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/admin/views/create_tourist_spot_screen.dart';
import 'pages/auth/views/account_selection_screen.dart';
import 'pages/onboarding/views/boarding_screen.dart';
import 'pages/public/views/list_of_visitors.dart';
import 'pages/public/views/tourist_all_shared_post.screen.dart';
import 'pages/public/views/visitors_profile_screen.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AppBindings().dependencies();


  final showOnBoarding = await SharedPreferencesManager.getShowOnBoarding();
  runApp( DiritaApp(showOnBoarding:showOnBoarding ,));
}

class DiritaApp extends StatefulWidget {
  final bool showOnBoarding;
  const DiritaApp({super.key, required this.showOnBoarding});


  @override
  _DiritaAppState createState() => _DiritaAppState();
}

class _DiritaAppState extends State<DiritaApp> {

final authcontroller = Get.find<AuthController>();


Widget authscreenlogic() {



  if(widget.showOnBoarding == false) {
    return const BoardingScreen();
  } else {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return a loading indicator if the stream is still waiting for data
            return  Center(child: LoaderWidget());
          } else {
            if (snapshot.hasData) {
              // User is signed in
              final user = snapshot.data;
              final uid = user?.uid;
              if (uid == null) {
                return LoginScreen();
              } else {
                final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
                return FutureBuilder<DocumentSnapshot>(
                  future: userRef.get(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Return a loading indicator if the future is still waiting for data
                      return Center(child: LoaderWidget());
                    } else {
                      final userData = snapshot.data?.data() as Map<String, dynamic>?;
                       authcontroller.getUserDetails(uid);
                      final role = userData?['role'] as String?;
                      if (role == 'tourist-spot-manager') {
                        return AdminScreen();
                      } else {
                        return HomeScreen();
                      }
                    }
                  },
                );
              }
            } else {

              // User is signed out
              return HomeScreen();
            //  return CurrentLocationScreen();
            }
          }
        },
      ),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      smartManagement: SmartManagement.full,
      initialBinding: AppBindings() ,
      theme: ThemeData(
        
        colorSchemeSeed: AppTheme.ORANGE,
        useMaterial3: true,
        textTheme:AppTheme.CUSTOM_TEXT_THEME,
      ),
      debugShowCheckedModeBanner: false,
      home: authscreenlogic(),
      getPages: [
        GetPage(name: '/boarding', page: () => const BoardingScreen()),
        GetPage(name: '/home', page: () => HomeScreen(), transition: Transition.cupertino),
        GetPage(name: '/select-account-type', page: () => AccountSelectionScreen()),
        GetPage(name: '/touristspot-details', page: () => TouristSpotDetails()),
        GetPage(name: '/touristspot-location', page: () => TouristSpotLocation()),
        GetPage(name: '/login', page: () => LoginScreen(), transition: Transition.cupertino),
        GetPage(name: '/register', page: () => SignupScreen(), transition: Transition.cupertino),
        GetPage(name: '/account-selection', page: () => AccountSelectionScreen(), transition: Transition.cupertino),
        GetPage(name: '/view-image', page: () => FullScreenImage(), transition: Transition.zoom),
        GetPage(name: '/current-location/', page: () => CurrentLocationScreen (), transition: Transition.cupertino),
        GetPage(name: '/admin', page: () => AdminScreen(), transition: Transition.cupertino),
        GetPage(name: '/admin/create-tourist-spot', page: () => CreateTouristSpotScreen(), transition: Transition.cupertino),
        GetPage(name: '/admin/select-tourist-spot-location', page: () => SelectTouristLocationSpotScreen(), transition: Transition.cupertino),
        GetPage(name: '/admin/update-tourist-spot', page: () => UpdateTouristSpotScreen(), transition: Transition.cupertino),
        GetPage(name: '/shared-post', page: () => TouristAllSharedPostScreen(), transition: Transition.cupertino),
        GetPage(name: '/profile', page: () => ProfileScreen(), transition: Transition.cupertino),
        GetPage(name: '/profile/update', page: () => UpdateProfileScreen(), transition: Transition.cupertino),
        GetPage(name: '/settings', page: () => SettingsScreen(), transition: Transition.cupertino),
        GetPage(name: '/privacy-and-policy', page: () => PrivacyAndPolicy(), transition: Transition.cupertino),
        GetPage(name: '/terms-and-condition', page: () => TermsAndCondition(), transition: Transition.cupertino),
        GetPage(name: '/reports', page: () => ReportScreen(), transition: Transition.cupertino),
        GetPage(name: '/list-of-tourist', page: () => ListSpot(), transition: Transition.cupertino),
        GetPage(name: '/list-of-visitors', page: () => ListOfVisitors(), transition: Transition.cupertino),
        GetPage(name: '/visitor-profile', page: () => VisitorsProfileScreen(), transition: Transition.cupertino),
      ],
    );
  }
}

import 'package:dirita_tourist_spot_app/pages/auth/controller/auth_controller.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_screen.dart';
import 'package:dirita_tourist_spot_app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
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

  int _currentIndex = 0;

  List<Widget> _pages = [
      TouristScreen(),
      Container(child: Center(child: Text( 'page2', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),),)),
      Container(child: Center(child: Text( 'page3', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),),)),
      Container(child: Center(child: Text( 'page4', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),),)),
 
  ];


void openDrawer(context){
  Scaffold.of(context).openDrawer();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.BACKGROUND,
        drawer: Drawer(

          child: GetBuilder<AuthController>(
            builder:(controller)=> SafeArea(
              child: ListView(
                children: [
          
                    Container(
                      height: 150,
                      color: AppTheme.ORANGE,
                      padding: EdgeInsets.all(10),
                      child: Text('YOW'.toUpperCase(),style: TextStyle(fontSize: 40, color: Colors.white),)
                      ),

                      Container(child: Text(controller.user.value.toString())),
                    HSpace(40),
                    if(controller.user.value.uid != null)ListTile( onTap: ()=>controller.logout(context), leading: Icon(Icons.logout, color: AppTheme.FONT,), title: Text( 'Logout', style: TextStyle(fontSize: 18, color: AppTheme.FONT),)),
                    ListTile(onTap: (){}, leading: Icon(Icons.add, color: AppTheme.FONT,), title: Text( 'Some Features', style: TextStyle(fontSize: 18, color: AppTheme.FONT),)),
                    ListTile(onTap: (){}, leading: Icon(Icons.add, color: AppTheme.FONT,), title: Text( 'Some Features', style: TextStyle(fontSize: 18, color: AppTheme.FONT),)),
                ]
              ),
            ),
          ),
          
        ),
      appBar: AppBar(

        
      
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () => openDrawer(context),
                icon: const Icon(
                  Icons.menu,
                  color: AppTheme.ORANGE,
                ));
          }
        ),
        title: Text(
          'Home ',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: AppTheme.FONT,
              ),
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(onPressed: () => showSearch(context: context, delegate: TouristSpotSearchDelegate()), icon: const Icon(Icons.search));
            }
          ),

         GetBuilder<AuthController>(builder: (controller)=> controller.user.value.uid == null ? TextButton(
            onPressed: () => Modal.showBottomSheet(context),
            child: Text(
              'Signin',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.ORANGE,
                  ),
            ),
          ): IconButton(onPressed: ()=> Modal.showBottomSheet(context), icon: ProfileWidget(url: controller.user.value.profile_image,),)),
          
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
              icon: Icon(Icons.home),
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
              icon: Icon(Icons.note),
              title: Text("Schedules"),
              selectedColor: AppTheme.ORANGE,
            ),
            SalomonBottomBarItem(
              unselectedColor: Colors.grey.shade600,
              icon: Icon(Icons.person),
              title: Text("Reports"),
              selectedColor: AppTheme.ORANGE,
            ),
          ],
        ),
    );
  }
}

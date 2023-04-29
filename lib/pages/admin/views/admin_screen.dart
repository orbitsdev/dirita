


import 'package:dirita_tourist_spot_app/pages/auth/controller/auth_controller.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({ Key? key }) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
    final authcontroller = Get.find<AuthController>();
   final _firstNameController = TextEditingController();
   final _key = GlobalKey<FormState>();

    
    void _openDrawer(BuildContext context){
        Scaffold.of(context).openEndDrawer();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Builder(
              builder: (context) {
                return IconButton(onPressed: ()=>_openDrawer(context),  icon: ProfileWidget(url: authcontroller.user.value.profile_image,),);
              }
            ),
            const HSpace(10),
          ],
        ),
      endDrawer: Drawer(

        child: SafeArea(
          child: ListView(
            children: [

                Container(
                  height: 60,
                  color: AppTheme.ORANGE,
                  padding: EdgeInsets.all(10),
                  child: Text('YOW'.toUpperCase(),style: TextStyle(fontSize: 40, color: Colors.white),)
                  
                  ),
                HSpace(40),
                ListTile( onTap: ()=>authcontroller.logout(context), leading: Icon(Icons.logout, color: AppTheme.FONT,), title: Text( 'Logout', style: TextStyle(fontSize: 18, color: AppTheme.FONT),)),
              
            ]
          ),
        ),
        
      ),
      body: Center(child: Text('admin')),
    );
  }
}
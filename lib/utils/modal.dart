





import 'package:dirita_tourist_spot_app/pages/auth/views/login_screen.dart';
import 'package:flutter/material.dart';

class Modal {

  static void showBottomSheet(BuildContext context){
      showModalBottomSheet(
        
         isScrollControlled: true,
        context: context, builder: (context)=>Padding(
         padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom,
    ),
          child: Container(
         constraints: BoxConstraints(
          minHeight:   MediaQuery.of(context).size.height * 0.55,
         ),
           child: LoginScreen(),
              ),
        ));
  }
}
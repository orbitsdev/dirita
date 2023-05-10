




import 'package:dirita_tourist_spot_app/pages/auth/views/signup_screen.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/home_screen.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_theme.dart';
import '../../../widgets/account_card_widget.dart';


enum AccountType{
  visitor,
  admin,
  superadmin
} 


class AccountSelectionScreen extends StatelessWidget {
const AccountSelectionScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
    
      appBar: AppBar(
        actions: [

          IconButton(onPressed: (){
            Get.to(()=> HomeScreen());
          }, icon: Icon(Icons.home_outlined, color: AppTheme.ORANGE, size:26)),

          HSpace(8),
        ],
      ),
     
      body:
      ListView(
        
        padding: const EdgeInsets.symmetric(horizontal: 16,),
        physics: const BouncingScrollPhysics(),
        children: [   
             Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('What are you? ', style: Theme.of(context).textTheme.headline1,),
            ),
                    const VSpace(5),
            GestureDetector(
               onTap: (){
                Get.to(()=> SignupScreen(name: 'tourist',));
              },
              child: AccountCardWidget(
                color: Color.fromARGB(255, 71, 91, 184),
                name: 'A Tourist',
                image: 'drone-pilot-lottie.json',
                description: 'Someone who goes on trips to discover new places and have fun.',
              ),
            ),

            const VSpace(24),
           
            GestureDetector(
              onTap: (){
                Get.to(()=> SignupScreen(name: 'tourist-spot-manager',));
              },
              child: AccountCardWidget(
                color: Color.fromARGB(255, 132, 156, 46),
                name: 'A Tourist Spot Manager',
                image: 'admin.json',
                description: 'The person who takes care of all the details related to a tourist attraction, such as making sure it is clean, safe, and advertised so that visitors will come and enjoy it.',
              ),
            ),
            
          
        
        ],
      ),
    );
  }
}
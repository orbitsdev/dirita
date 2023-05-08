

import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/title_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyAndPolicy extends StatelessWidget {
const PrivacyAndPolicy({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed:()=> Get.back(result: false), icon: Icon(Icons.arrow_back_ios)),
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              child: Text('Thank you for using the Dirikita app. This Privacy Policy explains how we collect, use, and disclose your personal information when you use our app.'),
            ),
            VSpace(16),

            Titlewidget(text:'1. Information We Collect'),
            VSpace(10),
            Text(
              'Information We Collect We collect the following information when you use our app: First name and last name: We collect this information to personalize your user experience. Email address: We collect your email address to communicate with you and provide account-related notifications'
              
            ),
   VSpace(16),
            Titlewidget(text:'2. Use of Information'),
            VSpace(10),
            Text('We use the collected information for the following purposes: Personalization: We use your first name, last name, and profile picture to personalize your user experience within the app. Communication: We use your email address to send you notifications, updates, and important information regarding your account. Sharing tourist spot photos: If you choose to share photos of tourist spots, we may display those photos to other users.'),

   VSpace(16),
            Titlewidget(text:'3. Data Secuirty'),
            VSpace(10),
            Text('We prioritize the security of your personal information and take appropriate measures to protect it. However, please note that no method of transmission over the internet or electronic storage is 100% secure.'),
            
   VSpace(16),
            Titlewidget(text:'4. Data Retention'),
            VSpace(10),
            Text('We retain your personal information for as long as necessary to fulfill the purposes outlined in this Privacy Policy unless a longer retention period is required or permitted by law.'),
            
   VSpace(16),
            Titlewidget(text:'5. Third-Party Services'),
            VSpace(10),
            Text('We may use third-party services and APIs to provide certain features within the app. These third-party services may have their own privacy policies, and your use of those services is subject to their respective terms and policies.'),
            
            
   VSpace(16),
            Titlewidget(text:'6. Changes to this Privacy Policy'),
            VSpace(10),
            Text(' We reserve the right to modify this Privacy Policy at any time. Any changes will be effective immediately upon posting the updated Privacy Policy within the app.'),
            
          ],
        ),
      ),

      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.10,
        padding: EdgeInsets.all(16),
        color:Colors.white,
        child: Center(child: SizedBox(
          width:double.infinity,
          child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.ORANGE,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () => Get.back(result: true),
                          child: const Center(
                            child: Text(
                              'I Agree ',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        )) ,
      ),
    ),
    );
  }
}
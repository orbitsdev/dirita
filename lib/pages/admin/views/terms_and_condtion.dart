

import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/title_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:flutter/material.dart';

class TermsAndCondition extends StatelessWidget {
const TermsAndCondition({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Service'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              child: Text('Please read these Terms of Service carefully before using the Dirikita app.'),
            ),
            VSpace(16),

            Titlewidget(text:'1. Acceptance of Terms'),
            VSpace(10),
            Text(
              'By using the Dirikita app, you agree to comply with and be bound by these Terms of Service. If you do not agree with any part of these terms, please do not use the app.'
            ),
   VSpace(16),
            Titlewidget(text:'2. User Responsibilities'),
            VSpace(10),
            Text('You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account. You agree not to use the app for any illegal or unauthorized purpose or violate any applicable laws. You are solely responsible for any content you upload, share, or post within the app.'),

   VSpace(16),
            Titlewidget(text:'3. Intellectual Property'),
            VSpace(10),
            Text('The Dirikita app and its content are protected by copyright, trademark, and other intellectual property laws. You may not modify, copy, distribute, transmit, display, perform, reproduce, publish, license, create derivative works from, transfer, or sell any information, software, products, or services obtained from the app'),
            
   VSpace(16),
            Titlewidget(text:'4.  Limitation of Liability'),
            VSpace(10),
            Text('We strive to provide accurate and reliable information within the app, but we do not guarantee its completeness, accuracy, or reliability. We shall not be liable for any direct, indirect, incidental, special, consequential, or exemplary damages resulting from your use of the app'),
            
   VSpace(16),
            Titlewidget(text:'5. Modification and Termination'),
            VSpace(10),
            Text('We reserve the right to modify, suspend, or terminate the app or your access to it at any time without prior notice.'),
            
            
   VSpace(16),
            Titlewidget(text:'6. Governing Law'),
            VSpace(10),
            Text(' These Terms of Service shall be governed by and construed in accordance with the laws of Philippines.'),
            


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
                          onPressed: () {},
                          child: const Center(
                            child: Text(
                              'I Agress ',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        )) ,
      ),
    ),
    )
    ;
  }
}
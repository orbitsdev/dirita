

import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/content_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/title_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            Text('Please read these terms and conditions  carefully before using the Dirita mobile application . These Terms govern your use of the App and its services.'),
              VSpace(16),
                ContentWidget(
                subheader: '1. Acceptance of Terms',
                description:
                    'By accessing or using the Dirita App, you agree to be bound by these Terms. If you do not agree with any part of the Terms, you may not use the App.',
               ),
                ContentWidget(
                subheader: '2.  Use of the App',
                letters: [
                  'a. The Dirita App provides information about tourist spots in Sultan Kudarat. You may use the App to browse and discover tourist spots, view their details, and access their locations.',
                  'b. The information provided in the App, including but not limited to tourist spot details, images, and locations, is for informational purposes only. We strive to provide accurate and up-to-date information, but we do not guarantee its completeness or accuracy.',
                  'c. You are responsible for your own safety and well-being when visiting tourist spots listed in the App. We recommend exercising caution and following any local regulations or guidelines.'
                ],
               ),
                ContentWidget(
                subheader: '3. User Account',
                letters: [
                  'a. To access certain features of the App, you may be required to create a user account. You must provide accurate and complete information during the registration process.',
                  'b. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.',
                  'c. You must be at least 18 years old to create an account or have the consent of a parent or legal guardian.'
                ],
               ),
                ContentWidget(
                subheader: '4. Intellectual Property',
                letters: [
                  'a. All intellectual property rights in the Dirita App and its content, including but not limited to logos, trademarks, text, images, graphics, and software, are owned by us or our licensors.',
                  'b. You may not modify, copy, distribute, transmit, display, perform, reproduce, publish, license, create derivative works from, transfer, or sell any information, software, products, or services obtained from the Dirita App without our prior written consent.',
                ],
               ),
                ContentWidget(
                subheader: '5. User-Generated Content',
                letters: [
                  'a. The Dirita App may allow users to post or submit content, such as reviews or comments, regarding tourist spots.',
                  'b. By posting or submitting any content to the App, you grant us a non-exclusive, worldwide, royalty-free, perpetual, irrevocable, and sublicensable right to use, reproduce, modify, adapt, publish, translate, create derivative works from, distribute, and display such content.',
                  'c. You represent and warrant that you own or have the necessary rights and permissions to grant us the above license to the content you post or submit.'
                ],
               ),
                ContentWidget(
                subheader: '6. Limitation of Liability',
                letters: [
                  'a. We strive to provide a reliable and user-friendly App, but we do not guarantee its uninterrupted or error-free operation.',
                  'b. We shall not be liable for any direct, indirect, incidental, consequential, or exemplary damages arising out of your use of the Dirita App.',
                ],
               ),
                ContentWidget(
                subheader: '7. Modifications to the Terms',
                letters: [
                  'We reserve the right to modify or update these Terms at any time without prior notice. It is your responsibility to review the Terms periodically for any changes.',
                  'By continuing to use the Dirita App after any modifications to the Terms, you agree to be bound by the revised Terms.',
                  'Please contact us if you have any questions or concerns regarding these Terms.',
                ],
               ),
                VSpace(MediaQuery.of(context).size.height * 0.10)
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
                          onPressed: () {
                            Get.back();
                          },
                          child: const Center(
                            child: Text(
                              'I Understand  ',
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
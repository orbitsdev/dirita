import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/content_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/title_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(result: false),
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContentWidget(
                header: '1. Information We Collect',
                subheader: '1.1 Authentication:',
                description:
                    'To ensure secure access to the App, we may collect the following personal information from Users:',
                target: [
                  'First name',
                  'Last name',
                  'Email address',
                  'Profile image',
                ]),
            ContentWidget(
              
                subheader: '1.2 Tourist Spot Information:',
                description:
                    'When Users interact with the App to find tourist spots in Sultan Kudarat, we may collect the following information:',
                target: [
                  'Tourist spot name',
                  'Tourist spot image',
                  'Featured tourist spot image',
                ]),

            ContentWidget(
              
                subheader: '1.3 User-Generated Content',
                description:
                    'When Users post images related to the tourist spots, we may collect the following information:',
                target: [
                  'User shared image',
                  
                ]),
            ContentWidget(
              
                subheader: '1.4 Location Information:',
                description:
                    'To enable location-based services, we may collect the following location information:',
                target: [
                  'Tourist spot location',
                  
                ]),
            ContentWidget(
              header: '2. Purpose of Data Collection',
                
                description:
                    'We collect the above-mentioned information for the following purposes',
                target: [
                  'User authentication: To authenticate Users and ensure secure access to the App.',
                  'Role assignment: To assign appropriate roles (tourist user or tourist manager user) within the App based on the collected information.',
                  'User-generated content: To enable Users to post and share images related to the tourist spots.',
                  'Location-based services: To provide location-based services and features within the App.',
                  
                ]),
            ContentWidget(
              header: '3. Data Storage and Security',
                subheader: '3.1 Data Storage:',
                description:
                    'The personal and location information provided by Users is securely stored on Firebase, a trusted third-party platform. Firebase adheres to industry standards and provides robust security measures to protect User data.',
                ),
            ContentWidget(
                subheader: '3.2 Data Security:',
                description:
                    'We implement reasonable security measures to safeguard User data from unauthorized access, alteration, disclosure, or destruction. These measures include encryption, access controls, and regular security assessments.',
                ),
            ContentWidget(
              header: '4. Third-Party Sharing',
               
                description:
                    'We do not share User data with any third parties. Your personal information remains confidential and is used solely for the purposes outlined in this Privacy Policy.',
                ),
            ContentWidget(
              header: '5. User Rights',
               
                description:
                    'Users have the right to review, update, or delete their personal information and user-generated content stored within the App. To exercise these rights, Users can access the relevant sections in the App\'s settings or contact us directly using the contact information provided below.',
                ),
            ContentWidget(
              header: '6. Cookies and Tracking',
               
                description:
                    'The Dirita App does not use cookies or similar tracking technologies to collect User data.',
                ),
            ContentWidget(
              header: '7. Policy Updates',
               
                description:
                    'We reserve the right to update or modify this Privacy Policy at any time. Users will be notified of any changes via a prominent notice within the App. It is recommended that Users review this Privacy Policy periodically for any updates.',
                ),
            ContentWidget(
              header: '8. Contact Us',
               
                description:
                    'If you have any questions or concerns regarding this Privacy Policy or the App, please contact us at programmingacount@gmail.com.',
                ),

                VSpace(MediaQuery.of(context).size.height * 0.10)
          ],
        ),
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.10,
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Center(
          child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.ORANGE,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Get.back(result: true),
                child: const Center(
                  child: Text(
                    'I Understand  ',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

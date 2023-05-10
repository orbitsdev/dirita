


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dirita_tourist_spot_app/constants/helper_constant.dart';
import 'package:dirita_tourist_spot_app/models/user_account.dart';
import 'package:dirita_tourist_spot_app/pages/full_screen_image.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/visitors_profile_screen.dart';
import 'package:dirita_tourist_spot_app/widgets/rectangle_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ListOfVisitors extends StatelessWidget {
const ListOfVisitors({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      
        centerTitle: true,
        title: Text(
          'List of visitors',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: StreamBuilder<QuerySnapshot>(
          stream:FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 'tourist').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            List<UserAccount> users = snapshot.data!.docs
                .map((e) =>
                    UserAccount.fromMap(e.data() as Map<String, dynamic>))
                .toList();
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  onTap: () => Get.to(()=> VisitorsProfileScreen(user: user)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  minVerticalPadding: 0.0,
                  leading: GestureDetector(
                    onTap: ()=> FullScreenImage(imageUrl: user.profile_image ,),
                    child: RectangleImageWidget(
                      url: user.profile_image ,
                      width: 50,
                      height: 200,
                      viewable: true,
                    ),
                  ),
                  title: Text(capitalize('${user.first_name} ${user.last_name}')),

                  // Container(
                );
              },
            );
          },
        ),
      ),
    );
  }
}
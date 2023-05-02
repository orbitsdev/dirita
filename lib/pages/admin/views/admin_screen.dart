import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dirita_tourist_spot_app/constants/firebase_constant.dart';
import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:dirita_tourist_spot_app/pages/admin/controllers/tourist_spot_controller.dart';
import 'package:dirita_tourist_spot_app/pages/admin/views/create_tourist_spot_screen.dart';
import 'package:dirita_tourist_spot_app/pages/auth/controller/auth_controller.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_details_screen.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/loader_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/profile_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/rectangle_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final authcontroller = Get.find<AuthController>();
  late TouristSpotController touristcontroller;
  final _key = GlobalKey<FormState>();

  void _openDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  void initState() {
    // TODO: implement initState
    touristcontroller = Get.find<TouristSpotController>();
    super.initState();
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.to(() => CreateTouristSpotScreen()),
            icon: Icon(
              Icons.add,
            )),
        title: Text('Manage Tourist Spot'),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () => _openDrawer(context),
              icon: ProfileWidget(
                url: authcontroller.user.value.profile_image,
              ),
            );
          }),
          const HSpace(10),
        ],
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(children: [
            ListTile(
                onTap: () => authcontroller.logout(context),
                leading: Icon(
                  Icons.logout,
                  color: AppTheme.FONT,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, color: AppTheme.FONT),
                )),
          ]),
        ),
      ),

    
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('touristspot').where('user_uid', isEqualTo: auth.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LoaderWidget(),
            );
          } else {
            final data = snapshot.data!;
            final touristspots = data.docs
                .map((doc) =>
                    TouristSpot.fromMap(doc.data() as Map<String, dynamic>))
                .toList();
            return ListView.builder(
              itemCount: touristspots.length,
              itemBuilder: (context, index) {
                final spot = touristspots[index];
                return ListTile(
                  onTap: () => Get.to(() => TouristSpotDetails(
                        touristspot: spot,
                      )),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  minVerticalPadding: 0.0,
                  leading: RectangleImageWidget(
                    url: spot.cover_image,
                    width: 50,
                    height: 200,
                    viewable: true,
                  ),
                  title: Text(spot.name ?? ''),
                  subtitle: Text(spot.formatted_address ?? ''),
                  trailing: PopupMenuButton(
                    surfaceTintColor: Colors.white,
                    onSelected: (value) {
                      switch (value) {
                        case 'update':
                          print('delete');

                          return;
                        case 'delete':
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Delete'),
                                content: Text(
                                    'Are you sure you want to delete this item?'),
                                actions: [
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  GetBuilder<TouristSpotController>(
                                      builder: (controller) {
                                    return ElevatedButton(
                                      child: controller.isDeleting.value
                                          ? LoaderWidget(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                      style: ElevatedButton.styleFrom(
                                        primary: AppTheme
                                            .ORANGE, // set the background color of the button
                                      ),
                                      onPressed: () {
                                        touristcontroller.deleteTouristSpot(
                                            context: context,
                                            id: spot.id as String);
                                      },
                                    );
                                  }),
                                ],
                              );
                            },
                          );
                          return;
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        value: 'update',
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 8),
                            Text('Update'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                    icon: Icon(Icons.more_vert),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

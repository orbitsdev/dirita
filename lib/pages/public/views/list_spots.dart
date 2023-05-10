import 'package:dirita_tourist_spot_app/constants/helper_constant.dart';
import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_details_screen.dart';
import 'package:dirita_tourist_spot_app/widgets/rectangle_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListSpot extends StatefulWidget {
  const ListSpot({Key? key}) : super(key: key);

  @override
  _ListSpotState createState() => _ListSpotState();
}

class _ListSpotState extends State<ListSpot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'List of tourist',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('touristspot').snapshots(),
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

            List<TouristSpot> toursitspot = snapshot.data!.docs
                .map((e) =>
                    TouristSpot.fromMap(e.data() as Map<String, dynamic>))
                .toList();
            return ListView.builder(
              itemCount: toursitspot.length,
              itemBuilder: (context, index) {
                final spot = toursitspot[index];
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
                  title: Text(capitalize('${spot.name}')),

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

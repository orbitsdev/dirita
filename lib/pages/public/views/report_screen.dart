import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/total_tourist_spot_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/total_users_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          VSpace(MediaQuery.of(context).size.height * 0.03),
      
          Text('Reports', style:TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
          VSpace(MediaQuery.of(context).size.height * 0.03),
      
         Expanded(  
           child: GridView.count(
            
            crossAxisCount: 2,
            children: [
              GestureDetector(
                child: TotalTouristSpotWidget().animate().scale()),
              TotalUsersWidget().animate().scale(),
            ],
            ),
         ),
          
        ],
      ),);
      
    

  
    // return Scaffold(
    //   backgroundColor: AppTheme.BACKGROUND,
     
    //   body: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 16, ),
    //     child: StreamBuilder<QuerySnapshot>(
    //       stream: FirebaseFirestore.instance.collection('touristspot').snapshots(),
    //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         }
    //         if (snapshot.hasError) {
    //           return Center(
    //             child: Text('Error: ${snapshot.error}'),
    //           );
    //         }
    //         final int totalCount = snapshot.data!.docs.length;
    //         return Column(
    //           children: [

    //                               VSpace(MediaQuery.of(context).size.height * 0.20),
    //             Container(
    //               padding: EdgeInsets.all(16),
    //               decoration: BoxDecoration(
    //               color: Colors.white,
    //                 boxShadow: [
    //     //                BoxShadow(
    //     //   color: Colors.grey.withOpacity(0.3),
    //     //   spreadRadius: 2,
    //     //   blurRadius: 6,
    //     //   offset: Offset(0, 3), // horizontal, vertical offset
    //     // ),
    //                 ],
    //                 borderRadius: BorderRadius.circular(8)
    //               ),
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [



    //                   Row(
    //                     children: [
    //                       ClipOval(
    //                         child: Container(

    //                           color: Colors.amber[200], 
    //                           width: 40,
    //                           height: 40,
    //                           child: Center(child: Icon(Icons.bar_chart_outlined))
                              
    //                         ),
    //                       ),
    //                       HSpace(15),
    //                       Text(
    //                         'Total Tourist Spots',
    //                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //                       ),
    //                     ],
    //                   ),
    //                   SizedBox(height: 16),
    //                   Container(
                    
                    
    //                     child: Center(
    //                       child: Text(
    //                         totalCount.toString(),
    //                         style: TextStyle(fontSize: 64, color: Colors.black,  fontWeight: FontWeight.bold),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}

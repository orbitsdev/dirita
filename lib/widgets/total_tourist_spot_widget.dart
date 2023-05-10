
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TotalTouristSpotWidget extends StatefulWidget {
  const TotalTouristSpotWidget({ Key? key }) : super(key: key);

  @override
  _TotalTouristSpotWidgetState createState() => _TotalTouristSpotWidgetState();
}

class _TotalTouristSpotWidgetState extends State<TotalTouristSpotWidget> {
  @override
  Widget build(BuildContext context) {
   return Container(
    
      margin: EdgeInsets.symmetric(horizontal: 4 ),
      padding: EdgeInsets.symmetric(horizontal: 8 ),
                decoration: BoxDecoration(
              color: Colors.white,
        borderRadius: BorderRadius.circular(12),
                ),
     child: Center(
       child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('touristspot').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                final int totalCount = snapshot.data!.docs.length;
                return  Container(
                  
                margin: EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
     
        
                          Row(
                            children: [
                              ClipOval(
                                child: Container(
                           
                                  color: Colors.pink[300], 
                                  width: 36,
                                  height: 36,
                                  child: Center(child: Icon(Icons.bar_chart_outlined ,color:Colors.white))
                                  
                                ),
                              ),
                              HSpace(15),
                              Flexible(
                                child: Text(
                                  'Total Tourist Spots',
                                  style: TextStyle(
                                    height: 0,
                                    fontSize: 14, fontWeight: FontWeight.bold,),
                                ),
                              ),
                            ],
                          ),
                          Container(                      
                            child: Center(
                              child: Text(
                                totalCount.toString(),
                                style: TextStyle(fontSize: 44, color: Colors.black,  fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
              }
                
            //     Column(
            //       children: [
        
            //                           VSpace(MediaQuery.of(context).size.height * 0.20),
            //         Container(
            //           padding: EdgeInsets.all(16),
            //           decoration: BoxDecoration(
            //           color: Colors.white,
            //             boxShadow: [
            
            //             ],
            //             borderRadius: BorderRadius.circular(8)
            //           ),
            //           child: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
        
        
        
            //               Row(
            //                 children: [
            //                   ClipOval(
            //                     child: Container(
        
            //                       color: Colors.amber[200], 
            //                       width: 40,
            //                       height: 40,
            //                       child: Center(child: Icon(Icons.bar_chart_outlined))
                                  
            //                     ),
            //                   ),
            //                   HSpace(15),
            //                   Text(
            //                     'Total Tourist Spots',
            //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(height: 16),
            //               Container(
                        
                        
            //                 child: Center(
            //                   child: Text(
            //                     totalCount.toString(),
            //                     style: TextStyle(fontSize: 64, color: Colors.black,  fontWeight: FontWeight.bold),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     );
            //   },
            // );
       ),
     ),
   );
}


}
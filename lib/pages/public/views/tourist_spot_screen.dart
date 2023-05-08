import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dirita_tourist_spot_app/ai/text_to_speech_controller.dart';
import 'package:dirita_tourist_spot_app/ai/voice_data.dart';
import 'package:dirita_tourist_spot_app/delegates/sticky_header_delegate.dart';
import 'package:dirita_tourist_spot_app/localdatabase/shared_preference_manager.dart';
import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_details_screen.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/loader_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/sv_space.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import 'package:get/get.dart';

import '../../../widgets/spot_card_widget.dart';

class TouristScreen extends StatefulWidget {
  const TouristScreen({Key? key}) : super(key: key);

  @override
  _TouristScreenState createState() => _TouristScreenState();
}

class _TouristScreenState extends State<TouristScreen> {


    
  @override
  void initState() {
    super.initState();



  }




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CustomScrollView(
        slivers: [
          
         
        SliverPersistentHeader(
      pinned: true,
      delegate: CustomSliverHeader(
        minHeight: 60,
        maxHeight: 70,
        child: Container(
        color: AppTheme.BACKGROUND,
        padding: const EdgeInsets.all(16),
          child: const Text(
            'Tourist Spots',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('touristspot').snapshots(),
      builder: (context, snapshot) {

        if(snapshot.hasError){
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverFillRemaining(
            child: Center(
              child: LoaderWidget(color: AppTheme.ORANGE,),
            ),
          );
        }
                  final touristspots = snapshot.data!.docs.map((doc) =>  TouristSpot.fromMap(doc.data())).toList();


        return SliverGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: touristspots.map((spot) {
            

            return GestureDetector(
              onTap: () async {
                Get.to(() => TouristSpotDetails(touristspot:spot), transition: Transition.cupertino);
                 final enabled = await SharedPreferencesManager.getEnableTranslationVoice();
                if(enabled){
                    TextToSpeechController.speak(VoiceAiSpeech.selectLanguage);
                }
                
              },
              child: SizedBox(
                height: 300,
                child: SpotCardWidget(touristspot:spot),
              ),
            );
          }).toList(),
        );
      },
    ),

          // SliverGrid.count(
          //   crossAxisCount: 2,
          //   mainAxisSpacing: 12,
          //   crossAxisSpacing: 12,
          //   children: List.generate(
          //     30,
          //     (index) => GestureDetector(
          //       onTap: () => Get.to(() => TouristSpotDetails(),
          //           transition: Transition.cupertino),
          //       child: const SizedBox(
          //         height: 300,
          //         child: SpotCardWidget(),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );

    

    // return  Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    //   child: Column(
    //     mainAxisSize: MainAxisSize.max,
    //     children: [
    //       Container(height: 300 ,color: Colors.red,),
    //       Expanded(
    //         child: MasonryGridView.count(
    //           physics: const ClampingScrollPhysics(),
    //             crossAxisCount: 2,
    //             mainAxisSpacing: 12,
    //             crossAxisSpacing: 12,
    //             itemCount: 30,
    //             itemBuilder: (context, index) {
    //               return GestureDetector(
    //                 onTap: ()=> Get.to(()=> TouristDetailsScreen(), transition: Transition.cupertino),
    //                 child: const SpotCardWidget());
    //             },
    //           ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dirita_tourist_spot_app/ai/text_to_speech_controller.dart';
import 'package:dirita_tourist_spot_app/ai/voice_data.dart';
import 'package:dirita_tourist_spot_app/delegates/sticky_header_delegate.dart';
import 'package:dirita_tourist_spot_app/localdatabase/shared_preference_manager.dart';
import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_details_screen.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/loader_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/spot_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


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
          child:  Text(
            'Tourist Spots'.toUpperCase(),
            style: Theme.of(context).textTheme.headline3!.copyWith(
              fontSize:24,
            ),
          ),
        ),
      ),
    ),
StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('touristspot').snapshots(),
      builder: (context, snapshot) {

        if(snapshot.hasError){
          return const Center(child: Text('Something went wrong'));
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

       
        ],
      ),
    );

    

  }
}

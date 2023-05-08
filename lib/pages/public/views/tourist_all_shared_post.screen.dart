import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dirita_tourist_spot_app/ai/text_to_speech_controller.dart';
import 'package:dirita_tourist_spot_app/ai/voice_data.dart';
import 'package:dirita_tourist_spot_app/constants/firebase_constant.dart';
import 'package:dirita_tourist_spot_app/localdatabase/shared_preference_manager.dart';
import 'package:dirita_tourist_spot_app/models/post.dart';
import 'package:dirita_tourist_spot_app/models/user_account.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:dirita_tourist_spot_app/widgets/post_card_shimmer.dart';
import 'package:dirita_tourist_spot_app/widgets/post_card_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/utils/asset.dart';

class TouristAllSharedPostScreen extends StatefulWidget {
  TouristSpot? spot;
  TouristAllSharedPostScreen({
    Key? key,
    this.spot,
  }) : super(key: key);
  @override
  _TouristAllSharedPostScreenState createState() =>
      _TouristAllSharedPostScreenState();
}

class _TouristAllSharedPostScreenState extends State<TouristAllSharedPostScreen> {


    @override
  void initState() {
    super.initState();
        _speakWelcomeMessage();

  }
  
 void _speakWelcomeMessage() async {

         final enabled = await SharedPreferencesManager.getEnableSharedExperienceVoice();

        if(enabled){
          TextToSpeechController.speak(VoiceAiSpeech.experience);
        }

    
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
           
            SliverAppBar(
              leading:SizedBox(
    width: 24,
    height: 24,
    child: IconButton(
      iconSize: 24,
      icon: Icon(
        Icons.arrow_back,
        color: Colors.orange,
      ),
      onPressed: () {
        Get.back();
      },
    ),
  ),
              backgroundColor: Colors.white,
              
              floating: true,
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.45,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children:[
                    
                     CachedNetworkImage(
                    imageUrl: widget.spot?.cover_image ??
                        sampleimage, // Replace with your image URL
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    placeholderFadeInDuration: Duration(
                        milliseconds: 500), // Adjust the duration as needed
                  ),
              

                    Positioned(
                      bottom: 0, right: 0,
                      left: 0,
            child: Container(
            height: MediaQuery.of(context).size.height * 0.60,
            decoration: BoxDecoration(
                            

             gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          )),
             Positioned(
  bottom: 30,
  right: 40,
  child:Container(
    
  width: MediaQuery.of(context).size.width * 0.70,
  alignment: Alignment.bottomRight,
  child: Text(
    widget.spot?.name ?? 'Name',
    style: TextStyle(
      fontSize: 28,
      height: 1,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
),
  
),
                  ]
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () => auth.currentUser != null
                    ? Modal.showCreatePost(
                        context: context, spot: widget.spot as TouristSpot)
                    : Modal.showLoginBottomSheet(context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    children: [
                      ProfileWidget(),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Share your experience',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .where('tourist_spot_id', isEqualTo: widget.spot!.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: PostCardShimmer(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Container(),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final doc = snapshot.data!.docs[index];
                      final postData = doc.data() as Map<String, dynamic>;
                      final post = Post.fromMap(postData);
                      final userId = post.uid;

                      return FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .get(),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return PostCardShimmer();
                          }

                          if (userSnapshot.hasError) {
                            return Text('Error: ${userSnapshot.error}');
                          }

                          if (!userSnapshot.hasData ||
                              !userSnapshot.data!.exists) {
                            return Container();
                          }

                          final userData =
                              userSnapshot.data!.data() as Map<String, dynamic>;
                          final user = UserAccount.fromMap(userData);

                          return PostCardWidget(
                            post: post,
                            user: user,
                            spot: widget.spot as TouristSpot,
                            bottom: 10,
                          );
                        },
                      );
                    },
                    childCount: snapshot.data!.docs.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

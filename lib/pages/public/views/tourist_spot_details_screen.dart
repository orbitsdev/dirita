import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dirita_tourist_spot_app/ai/text_to_speech_controller.dart';
import 'package:dirita_tourist_spot_app/ai/voice_data.dart';
import 'package:dirita_tourist_spot_app/constants/firebase_constant.dart';
import 'package:dirita_tourist_spot_app/delegates/voice_flow_delegate.dart';
import 'package:dirita_tourist_spot_app/models/post.dart';
import 'package:dirita_tourist_spot_app/models/user_account.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_all_shared_post.screen.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:dirita_tourist_spot_app/widgets/language_selector.dart';
import 'package:dirita_tourist_spot_app/widgets/loader_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/post_card_shimmer.dart';
import 'package:dirita_tourist_spot_app/widgets/post_card_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:dirita_tourist_spot_app/pages/full_screen_image.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_location.dart';
import 'package:dirita_tourist_spot_app/utils/asset.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/sv_space.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';

import '../../../localdatabase/shared_preference_manager.dart';
import '../../../utils/app_theme.dart';

class TouristSpotDetails extends StatefulWidget {
  TouristSpot? touristspot;
  TouristSpotDetails({
    Key? key,
    this.touristspot,
  }) : super(key: key);
  @override
  State<TouristSpotDetails> createState() => _TouristSpotDetailsState();
}

class _TouristSpotDetailsState extends State<TouristSpotDetails> {
  String language_code = 'en';

  bool isTranslating = false;

  void setLanguageCode(code) async {
    setState(() {
      language_code = code;
    });

    await SharedPreferencesManager.setcurrentLanguage(code);
    changeDetailsInformation();
  }

  void speakAllInformation(BuildContext context) async {
    String message =
        '${widget.touristspot!.about_information}${widget.touristspot!.more_information}';
    TextToSpeechController.speak(message);
    Get.back();
  }

  void speakbasicInformation(BuildContext context) async {
    String message = '${widget.touristspot!.about_information}';
    TextToSpeechController.speak(message);
    Get.back();
  }

  void selectInformation(BuildContext context) async {
    await TextToSpeechController.speak(VoiceAiSpeech.selectinformation);
    if (widget.touristspot != null) {
      Modal.showInformationOptions(
        context: context,
        speakAllInformation: speakAllInformation,
        speakBasicInformation: speakbasicInformation,
      );
    }
  }

  void setIsTranslating(bool value) {
    setState(() {
      isTranslating = value;
    });
  }

  void changeDetailsInformation() async {
    setIsTranslating(true);

    // TextToSpeechController.speak(VoiceAiSpeech.translating);
    String transalated_about =
        await TextToSpeechController.convertMessageToSelectedLanguage(
            code: language_code,
            message: '${widget.touristspot!.about_information}');
    String translated_more =
        await TextToSpeechController.convertMessageToSelectedLanguage(
            code: language_code,
            message: '${widget.touristspot!.more_information}');
    setState(() {
      widget.touristspot = widget.touristspot!.copyWith(
        about_information: transalated_about,
        more_information: translated_more,
      );
    });

    setIsTranslating(false);
  }

  setInitialLangauge() async {
    String code = await SharedPreferencesManager.getcurrentLanguage();
    setLanguageCode(code);
  }

  @override
  void initState() {
    setInitialLangauge();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              if (isTranslating) LoaderWidget(),
              if (isTranslating) HSpace(20),
              LanguageSelector(
                initialValue: language_code,
                onLanguageChanged: (code) => setLanguageCode(code),
              ),
              HSpace(20)
            ],
          ),

          // SliverToBoxAdapter(
          //   child: Container(
          //     padding: EdgeInsets.all(16),
          //     child: Text(
          //       // If listening is active show the recognized words
          //       _speechToText.isListening
          //           ? '$_lastWords'
          // If listening isn't active but could be tell the user
          // how to start it, otherwise indicate that speech
          // recognition is not yet ready or not supported on
          // the target device
          //           : _speechEnabled
          //               ? 'Tap the microphone to start listening...'
          //               : 'Speech not available',
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.touristspot?.name ?? 'Tourist spot name',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          height: 0,
                          fontSize: 38,
                          color: AppTheme.FONT,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const HSpace(6),
                        Text(
                          '49.5',
                          style: TextStyle(
                            color: AppTheme.FONT,
                            fontSize: 16,
                          ),
                        ),
                        const HSpace(6),
                        Text('120 reviews',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[400]))
                      ]),
                  const VSpace(10),
                  SizedBox(
                    height: 300,
                    child: Stack(children: [
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            widget.touristspot?.featured_image?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => FullScreenImage());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: CachedNetworkImage(
                                imageUrl: widget
                                        .touristspot?.featured_image?[index] ??
                                    sampleimage,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                      decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  )),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width / 1.2,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      if (widget.touristspot?.featured_image != null)
                        Positioned(
                            bottom: 10,
                            left: 10,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black.withOpacity(0.8),
                              ),
                              child: Center(
                                  child: Text(
                                '${widget.touristspot?.featured_image?.length ?? 0}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                            )),
                    ]),
                  ),
                  const VSpace(20),
                  Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.to(
                                  () => TouristSpotLocation(
                                        touristspot: widget.touristspot,
                                      ),
                                  transition: Transition.cupertino);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.pin_drop_outlined,
                                  size: 28,
                                  color: AppTheme.ORANGE,
                                ),
                                HSpace(6),
                                Flexible(
                                    child: Text(
                                        '${widget.touristspot?.formatted_address}'))
                              ],
                            )),
                      ]),
                  const VSpace(20),
                  Text(
                    'About ${widget.touristspot!.famouse_name!.toUpperCase()}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  VSpace(16),
                  Text(
                    '${widget.touristspot!.about_information}',
                   
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
                child: Text(
              'More Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
          const SVSpace(10),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Text('${widget.touristspot!.more_information}'),
            ),
          ),

          const SVSpace(10),

          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () => auth.currentUser != null
                  ? Modal.showCreatePost(
                      context: context, spot: widget.touristspot as TouristSpot)
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
                margin: EdgeInsets.symmetric(horizontal: 16),
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

   SVSpace(20),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('posts')
      .where('tourist_spot_id', isEqualTo: widget.touristspot!.id)
      .limit(10)
      .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
         return PostCardShimmer();

    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Container();
    }

    // Data is available, so we can build the list of posts
    return Column(
      children: [
        Wrap(
          children: snapshot.data!.docs.map((doc) {
            final postData = doc.data() as Map<String, dynamic>;

            // Extract the post data
            final post = Post.fromMap(postData);
            final userId = post.uid;

            // Return a FutureBuilder to fetch the user data
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return PostCardShimmer();
                }

                if (userSnapshot.hasError) {
                  return Text('Error: ${userSnapshot.error}');
                }

                if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                  return Container();
                }

                // User data is available, so we can build the PostCardWidget
                final userData = userSnapshot.data!.data() as Map<String, dynamic>;
                final user = UserAccount.fromMap(userData);

                return  PostCardWidget(post: post, user: user, spot: widget.touristspot as TouristSpot,  bottom: 10,);
              },
            );
          }).toList(),
        ),


if( snapshot.data!.docs.length >0)VSpace(20),
if( snapshot.data!.docs.length >0)SizedBox(
  width: double.infinity,
  child:   ElevatedButton(
  
    onPressed: () => Get.to(()=> TouristAllSharedPostScreen(spot:  widget.touristspot,)),
  
    style: ElevatedButton.styleFrom(
  
      shape: RoundedRectangleBorder(
  
        borderRadius: BorderRadius.circular(8),
  
        side: BorderSide(color: AppTheme.ORANGE),
  
      ),
  
    ),
  
    child: Text(
  
      'Show More',
  
      style: TextStyle(
  
        color: AppTheme.ORANGE,
  
        fontSize: 16,
  
      ),
  
    ),
  
  ),
)
      ],
    );
  },
),
    

            ),
          ),
          SVSpace(MediaQuery.of(context).size.height * 0.05),
        ],
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => selectInformation(context),
          child: Icon(Icons.android),
        );
      }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed:
      //       // If not yet listening for speech start, otherwise stop
      //       _speechToText.isNotListening ? _startListening : _stopListening,
      //   tooltip: 'Listen',
      //   child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      // ),
    );
  }

  
}

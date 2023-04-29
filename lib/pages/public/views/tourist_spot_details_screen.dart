import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirita_tourist_spot_app/pages/full_screen_image.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_location.dart';
import 'package:dirita_tourist_spot_app/utils/constant.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/sv_space.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../utils/app_theme.dart';

class TouristSpotDetails extends StatefulWidget {
  const TouristSpotDetails({Key? key}) : super(key: key);

  @override
  State<TouristSpotDetails> createState() => _TouristSpotDetailsState();
}

class _TouristSpotDetailsState extends State<TouristSpotDetails> {
  
  SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _lastWords = '';

  FlutterTts fluttertts  = FlutterTts();

  void textToSpeech() async {
    await fluttertts.setLanguage("en-US");
    await fluttertts.setVolume(0.5);
    await fluttertts.setSpeechRate(0.5);
    await fluttertts.setPitch(1);
    await fluttertts.speak("Expected Expense will be so many, Because they have differemt service. One Entrace , 1500 pesos , Food ,300 pesos , house rentent ,1000 pesos.");
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
    

  }

  void _initSpeech() async {
     await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
     _speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.tag)),
            ],
          ),
          // SliverAppBar(
          //   expandedHeight: 300,
          //   pinned: true,
          //   flexibleSpace: FlexibleSpaceBar(
          //     title: Text('TEscrot'),
          //     background: CachedNetworkImage(
          //       imageUrl: sampleimage,
          //       placeholder: (context, url) => Shimmer.fromColors(
          //         baseColor: Colors.grey[300]!,
          //         highlightColor: Colors.grey[100]!,
          //         child: Container(
          //           color: Colors.white,
          //         ),
          //       ),
          //       errorWidget: (context, url, error) => Icon(Icons.error),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),

          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                // If listening is active show the recognized words
                _speechToText.isListening
                    ? '$_lastWords'
                    // If listening isn't active but could be tell the user
                    // how to start it, otherwise indicate that speech
                    // recognition is not yet ready or not supported on
                    // the target device
                    : _speechEnabled
                        ? 'Tap the microphone to start listening...'
                        : 'Speech not available',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Balot Island White Sand Ressort',
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
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => FullScreenImage());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: CachedNetworkImage(
                                imageUrl: sampleimage,
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
                              '1 / 25',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
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
                              Get.to(() => TouristSpotLocation(),
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
                                Text('Sultan Kudarat 237 VHX 086232')
                              ],
                            )),
                      ]),
                  const VSpace(20),
                  Text(
                    'About Balot Island',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  VSpace(16),
                  Text(
                    'lorem asdasd ' * 20,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w100,
                          color: Colors.grey[700],
                        ),
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
              'Possible Expenses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 20,
                child: Text(
                    ' Keep in mind that below information might change in the future.  '),
              ),
            ),
          ),
          const SVSpace(16),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: 5, (context, index) => Text('Entrance 500'))),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  textToSpeech
      ),
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

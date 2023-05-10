import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirita_tourist_spot_app/constants/helper_constant.dart';
import 'package:dirita_tourist_spot_app/pages/full_screen_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';

import '../utils/app_theme.dart';
import '../utils/asset.dart';

class SpotCardWidget extends StatelessWidget {


     TouristSpot? touristspot;
   SpotCardWidget({
    Key? key,
    this.touristspot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: touristspot?.cover_image ?? "https://picsum.photos/200/300?random=${randomUber()}",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),

          Positioned(
            child: Container(
            height: 40,
            decoration: BoxDecoration(
                            
                  borderRadius: BorderRadius.circular(15),

             gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          )),
          Positioned(
            top:15,
            right: 10,
            left: 0,
            child: Container(
            padding: const EdgeInsets.all(10) ,
            child: Text( capitalize('${touristspot?.name}')  , style: TextStyle(height: 0, fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
          )),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 34,
              width: 34,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              
              ),
              child:  Icon(Icons.star, color: Colors.amber[300], size: 24,),)
          ),
        ],
      ),
    );
  }
}

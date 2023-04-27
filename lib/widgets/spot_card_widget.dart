import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../utils/app_theme.dart';
import '../utils/asset.dart';

import 'package:shimmer/shimmer.dart';

class SpotCardWidget extends StatelessWidget {
  const SpotCardWidget({Key? key}) : super(key: key);

  String randomUber() {
    int n = 1 + Random().nextInt(100);

    return n.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: "https://picsum.photos/200/300?random=${randomUber()}",
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

          Positioned(child: Container(
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
            top:8,
            right: 10,
            left: 0,
            child: Container(
            padding: const EdgeInsets.all(10) ,
            child: Text('Isla Delena Resort And Restaurant'  , style: TextStyle(height: 0, fontSize: 22, color: Colors.white),),
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
                color: AppTheme.ORANGE,
              ),
              child: Center(
                  child: Text('4.9',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12))),
            ),
          ),
        ],
      ),
    );
  }
}

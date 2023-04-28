import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_theme.dart';
import '../utils/asset.dart';

class AccountCardWidget extends StatelessWidget {
  final String name;
  final String image;
  final Color? color;
  const AccountCardWidget({
    Key? key,
    required this.name,
    required this.image,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      height: 140,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: Offset(5, 5),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1)),
          ]),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Lottie.asset(
              Asset.lottiePath(image),
              height: 140,
              width: 160,
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              width: 200, // set the maximum width of the container
              child: Text(
                name.toUpperCase(),
                style: TextStyle(
                  color: AppTheme.FONT,
                  height: 0,
                  fontSize: 24,
                  wordSpacing: 0,
                  letterSpacing: 1,
                  fontFamily: 'ArchivoBlack-Regular'),
                softWrap: true, // allow text to wrap
                overflow: TextOverflow.visible, // show overflow
              ),
            ),
          )
        ],
      ),
    ).animate().fadeIn().scale();

  }
}

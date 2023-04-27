import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/boarding.dart';
import '../utils/asset.dart';
import 'v_space.dart';

class BoardingScreenWidget extends StatelessWidget {
  final Boarding boarding;

  const BoardingScreenWidget({super.key, required this.boarding});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(Asset.boardingImagePath(boarding.image), fit: BoxFit.cover),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(),
                Text(
                  boarding.title.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      height:0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                VSpace(MediaQuery.of(context).size.height * 0.05),
                Text(
                  boarding.body,
                  style:  Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

                VSpace(MediaQuery.of(context).size.height * 0.15)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

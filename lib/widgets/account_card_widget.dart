


import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      constraints: BoxConstraints(
        minHeight: 200,
        
      ),
      decoration: BoxDecoration(
          color: color,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                 offset: Offset(5, 5),
                 
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            Asset.lottiePath(image),
             width: 200,

             fit: BoxFit.cover,
          ),
          const SizedBox(height: 5,),
          Text(
            name.toUpperCase(),
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: AppTheme.FONT,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
            
          )
        ],
      ),).animate().fadeIn().scale();
  }
}





import 'package:flutter/material.dart';

class RoundedCardWidget extends StatelessWidget {

 double? height;
 double? width;
 Color? color;
 double? padding;
 Widget? child;
   RoundedCardWidget({
    Key? key,
    this.height,
    this.width,
    this.color,
    this.padding,
    this.child,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(padding ?? 20),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: child,
    );
  }
}




import 'package:flutter/material.dart';

class VoiceFlowDelegate extends FlowDelegate{

   @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the total width of all the children, and the available width
    double totalWidth = 0;
    for (int i = 0; i < context.childCount; i++) {
      totalWidth += context.getChildSize(i)!.width;
    }
    double availableWidth = context.size.width - (context.childCount - 1) * 16;

    // Calculate the x-coordinate of the first child
    double x = (availableWidth - totalWidth) / 2;

    // Position each child widget horizontally
    for (int i = 0; i < context.childCount; i++) {
      context.paintChild(i,
          transform: Matrix4.translationValues(x, 0, 0));
      x += context.getChildSize(i)!.width + 16;
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;

}
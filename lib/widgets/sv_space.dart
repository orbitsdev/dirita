







import 'package:flutter/material.dart';

class SVSpace extends StatelessWidget 
{

  final double height;

  const SVSpace(this.height);

  @override
  Widget build(BuildContext context){
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
      ),
    );
  }
}
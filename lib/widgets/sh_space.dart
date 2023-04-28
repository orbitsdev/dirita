







import 'package:flutter/material.dart';

class SHSpace extends StatelessWidget 
{

  final double width;

  const SHSpace(this.width);

  @override
  Widget build(BuildContext context){
    return SliverToBoxAdapter(
      child: SizedBox(
        width: width,
      ),
    );
  }
}
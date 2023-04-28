







import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';

class TouristDetailsScreen extends StatelessWidget {
const TouristDetailsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
       backgroundColor: AppTheme.BACKGROUND,
     
      body: Container(child: Center(child: Text('Spot Details'),),),
    );
  }
}
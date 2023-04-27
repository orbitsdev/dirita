


import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../utils/app_theme.dart';
import '../../widgets/h_space.dart';
import '../../widgets/spot_card_widget.dart';

class HomeScreen extends StatelessWidget {
const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppTheme.BACKGROUND,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu,color: AppTheme.ORANGE,)),
        title: Text('Home ', style: Theme.of(context).textTheme.displaySmall!.copyWith(
          color: AppTheme.FONT,
        ),   ),
        actions: [

          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          TextButton(
            onPressed: (){},
            child: Text('Signin', style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppTheme.ORANGE,
            ),),
          ),
          const HSpace(20),
        ],
      ),
      body: MasonryGridView.count(
        padding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
  crossAxisCount: 2,
  mainAxisSpacing: 12,
  crossAxisSpacing: 12,
  itemCount: 10,
  itemBuilder: (context, index) {
    return SpotCardWidget();
  },
),
    );
  }
}
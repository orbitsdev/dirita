import 'package:dirita_tourist_spot_app/delegates/sticky_header_delegate.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_details_screen.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/sv_space.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import 'package:get/get.dart';

import '../../../widgets/spot_card_widget.dart';

class TouristScreen extends StatefulWidget {
  const TouristScreen({Key? key}) : super(key: key);

  @override
  _TouristScreenState createState() => _TouristScreenState();
}

class _TouristScreenState extends State<TouristScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CustomScrollView(
        slivers: [
          // SliverToBoxAdapter(
          //   child: Container(
          //     padding: EdgeInsets.all(16),
          //     height: 70,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(15),
          //       color: Colors.white,
              
          //     ),
          //     child: Row(
          //       children: [
          //           Container(
          //             height: 40,
          //             width: 40,
          //             child:Center(child: Text('20'),) ,
          //           ),
          //           Text('Total  Tourist Spots')
          //       ],
          //     ),
          //   ),
          // ),
         
        SliverPersistentHeader(
      pinned: true,
      delegate: CustomSliverHeader(
        minHeight: 60,
        maxHeight: 70,
        child: Container(
        color: AppTheme.BACKGROUND,
        padding: const EdgeInsets.all(16),
          child: const Text(
            'Tourist Spots',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
          SliverGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: List.generate(
              30,
              (index) => GestureDetector(
                onTap: () => Get.to(() => const TouristSpotDetails(),
                    transition: Transition.cupertino),
                child: const SizedBox(
                  height: 300,
                  child: SpotCardWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    

    // return  Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    //   child: Column(
    //     mainAxisSize: MainAxisSize.max,
    //     children: [
    //       Container(height: 300 ,color: Colors.red,),
    //       Expanded(
    //         child: MasonryGridView.count(
    //           physics: const ClampingScrollPhysics(),
    //             crossAxisCount: 2,
    //             mainAxisSpacing: 12,
    //             crossAxisSpacing: 12,
    //             itemCount: 30,
    //             itemBuilder: (context, index) {
    //               return GestureDetector(
    //                 onTap: ()=> Get.to(()=> TouristDetailsScreen(), transition: Transition.cupertino),
    //                 child: const SpotCardWidget());
    //             },
    //           ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

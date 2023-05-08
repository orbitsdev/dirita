import 'package:dirita_tourist_spot_app/pages/admin/controllers/tourist_spot_controller.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_details_screen.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/spot_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TouristSpotSearchDelegate extends SearchDelegate {
  final touristController = Get.find<TouristSpotController>();

  @override
  String get searchFieldLabel => 'Search Tourist Spot';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
        IconButton(
                onPressed: () {
                  if(query.isEmpty){
                    close(context, null);
                  }else{
                    query = '';
                  }
                },
                icon: const Icon(
                  Icons.close,

                ))

    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
  
      return  IconButton(
                onPressed: ()  => close(context, null),
                icon: const Icon(
                  Icons.arrow_back,

                ));

  }

  @override
  Widget buildResults(BuildContext context) {
   return Container();

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    
    if (query.isEmpty) {

      touristController.fetchInitialTouristSPot();
      
    }else{

     touristController.searchTouristSpots(query);
    }


     return Obx(
      () =>

      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: CustomScrollView(

          slivers: [

            SliverToBoxAdapter(
              child: Container(
        padding: const EdgeInsets.all(16),
          child: const Text(
            'Results',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: touristController.tsuggestions.map((spot) {
                
        
                return GestureDetector(
                  onTap: () => Get.to(() => TouristSpotDetails(touristspot:spot),
                      transition: Transition.cupertino),
                  child: SizedBox(
                    height: 300,
                    child: SpotCardWidget(touristspot:spot),
                  ),
                );
              }).toList(),
            ),
          ]
        ),
      ) 
    
    );
  }
}

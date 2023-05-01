


import 'package:dirita_tourist_spot_app/pages/admin/controllers/tourist_spot_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSearchDelegate  extends SearchDelegate{
 final  touristController = Get.find<TouristSpotController>();

  @override
  List<Widget>? buildActions(BuildContext context) {

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
  Widget? buildLeading(BuildContext context) {
    
      return  IconButton(
                onPressed: ()  => close(context, null),
                icon: const Icon(
                  Icons.arrow_back,

                ));

  }

  @override
  Widget buildResults(BuildContext context) {

        return Container(child: Center(child: Text(query),),);

  }

  @override
  Widget buildSuggestions(BuildContext context) {


       if (query.isEmpty) {
      return Container();
    }

    touristController.fetchSuggestions(query);

    return Obx(
      () => ListView.builder(
        itemCount: touristController.suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = touristController.suggestions[index];
          return ListTile(
            title: Text(suggestion['description']),
            subtitle: Text(suggestion['structured_formatting']['main_text']),
            onTap: () async{
                  LatLng location = await touristController.fetchDetails(suggestion['place_id']);
    
                
                  close(context, location);
                  
            },
          );
        },
      ),
    );

  }

}
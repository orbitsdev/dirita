


import 'package:flutter/material.dart';

class LocationSearchDelegate  extends SearchDelegate{


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

     return ListView.builder(
      itemCount: 3,
      itemBuilder: (context,index){
      return ListTile(leading: Icon(Icons.house ,), title: Text('Result 11'));
    });
  }

}



import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget {

  final String? header;
  final String? subheader;
  final String? description;
  List<String>? target;
  List<String>? letters;
   ContentWidget({
    Key? key,
     this.header,
     this.subheader,
     this.description,
    this.target,
    this.letters,

  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           if(header !=null)Text(
             header!,
             style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 20,
             ),
           ),
            Padding(
              padding: EdgeInsets.only( top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if(subheader !=null)  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
                    child: Text(
                      subheader!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  if(description !=null)  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    child: Text(description!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                if(target!=null)Padding(
  padding: EdgeInsets.only(left: 24.0, top: 8.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:target?.map((e)=> buildBulletPointText(e)).toList() ?? [] 
  ),
),
            if(letters!= null) Padding(
  padding: EdgeInsets.only(left: 24.0, top: 8.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:letters?.map((e)=> Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(e),
    )).toList() ?? [] 
  ),
),
                  
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget buildBulletPointText(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Icon(
            Icons.fiber_manual_record,
            size: 10.0,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    ),
  );
}
}

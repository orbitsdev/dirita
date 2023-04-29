import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirita_tourist_spot_app/utils/asset.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
   String? imageUrl;
   FullScreenImage({
    Key? key,
    this.imageUrl,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.black,
          child: Center(
            child: InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: imageUrl ?? sampleimage,
                fit: BoxFit.contain,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

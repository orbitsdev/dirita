

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/utils/constant.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {

  double? width;
  double? height;
  String? url;
  ProfileWidget({
    Key? key,
    this.width = 30,
    this.height =30 ,
    this.url = defaultsample,
  }) : super(key: key);
  @override
  Widget build(BuildContext context){


   return CachedNetworkImage(
              width: height,
              height: width,
  imageUrl:url!,
  imageBuilder: (context, imageProvider) => ClipOval(
    child: Container(
      
      decoration: BoxDecoration(
        image: DecorationImage(
          
            image: imageProvider,
            fit: BoxFit.cover,
            ),
      ),
    ),
  ),
  placeholder: (context, url) => const SizedBox(width: 40, height:40, child: CircularProgressIndicator(strokeWidth: 1.5, color: AppTheme.ORANGE,)),
  errorWidget: (context, url, error) => const Icon(Icons.error),
); 
  }
}

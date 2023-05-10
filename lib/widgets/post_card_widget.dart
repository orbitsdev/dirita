





import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirita_tourist_spot_app/constants/firebase_constant.dart';
import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:dirita_tourist_spot_app/pages/full_screen_image.dart';
import 'package:dirita_tourist_spot_app/pages/public/controller/post_controller.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/visitors_profile_screen.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:dirita_tourist_spot_app/models/post.dart';
import 'package:dirita_tourist_spot_app/models/user_account.dart';
import 'package:dirita_tourist_spot_app/utils/asset.dart';
import 'package:dirita_tourist_spot_app/widgets/h_space.dart';
import 'package:dirita_tourist_spot_app/widgets/profile_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';

class PostCardWidget extends StatelessWidget {

  final postcontroller = Get.find<PostController>();
  final Post post;
  final UserAccount user;
  final TouristSpot spot;
  double? bottom;

   PostCardWidget({super.key, required this.post, required this.user, required this.spot, this.bottom});

   


  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(bottom: bottom ??0),
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              children: [
                GestureDetector(
                  onTap: ()=>  (auth.currentUser!= null &&  auth.currentUser!.uid != post.uid) ?  Get.to(()=>  VisitorsProfileScreen(user:user)): null,
                  child: ProfileWidget()),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.first_name} ${user.last_name}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      timeago.format( DateFormat('yyyy-MM-dd HH:mm:ss').parse(post.created_at)),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
         if(auth.currentUser!= null &&  auth.currentUser!.uid == post.uid )PopupMenuButton<String>(
          surfaceTintColor: Colors.white,
            onSelected: (value) {
              if (value == 'update') {  
                  Modal.showUpdatePost(context: context, spot: spot, post: post);

              } else if (value == 'delete') {
                postcontroller.deletePost(context: context, postId: post.id, postImage: post.post_image);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'update',
                child: Text('Update'),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
      SizedBox(height: 10),
      Text(
        '${post.caption}',
        style: TextStyle(fontSize: 16),
      ),
      SizedBox(height: 10),
      if(post.post_image != null)GestureDetector(
        onTap: () => Get.to(()=> FullScreenImage(imageUrl: post.post_image ?? sampleimage ,) ) ,
        child: CachedNetworkImage(
          height: 240,
          imageUrl: post.post_image ?? sampleimage,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ],
  ),
);


  }
}

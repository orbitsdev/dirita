import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dirita_tourist_spot_app/constants/helper_constant.dart';
import 'package:dirita_tourist_spot_app/models/user_account.dart';
import 'package:dirita_tourist_spot_app/pages/full_screen_image.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/profile_card.widget.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/utils/asset.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';

class VisitorsProfileScreen extends StatelessWidget {

   UserAccount? user;
   VisitorsProfileScreen({
    Key? key,
     this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.white, 
        appBar: AppBar(),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          VSpace(MediaQuery.of(context).size.height * 0.01),
          Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.33,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(),
                GestureDetector(
                  onTap: ()=> Get.to(()=> FullScreenImage(imageUrl: user?.profile_image ?? Asset.avatarDefault)),
                  child: Container(
                    height: 190,
                    width: 190,
                    child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:user?.profile_image ?? Asset.avatarDefault,
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
                              placeholder: (context, url) => SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                  color: AppTheme.ORANGE,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(height: 16),


                 Text('${user?.first_name} ${user?.last_name}' , style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold )),
                 VSpace(10),
                 Text('${user?.email}' , style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ])));
  }
}

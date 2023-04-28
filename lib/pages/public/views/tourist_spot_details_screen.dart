







import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirita_tourist_spot_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/app_theme.dart';

class TouristSpotDetails extends StatelessWidget {
const TouristSpotDetails({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: AppTheme.BACKGROUND,
    
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('TEscrot'),
              background: CachedNetworkImage(
                imageUrl: sampleimage,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'lorem asdasd',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Featured Images',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: CachedNetworkImage(
                            imageUrl: sampleimage,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                            width: 200,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
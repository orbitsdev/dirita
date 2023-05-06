



import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirita_tourist_spot_app/models/post.dart';
import 'package:dirita_tourist_spot_app/utils/asset.dart';
import 'package:dirita_tourist_spot_app/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:dirita_tourist_spot_app/pages/public/controller/post_controller.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:shimmer/shimmer.dart';

class UpdateTouristPost extends StatefulWidget {


  final TouristSpot spot;
  final Post post;

  const UpdateTouristPost({super.key, required this.spot, required this.post});
 
  _UpdateTouristPostState createState() => _UpdateTouristPostState();
}

class _UpdateTouristPostState extends State<UpdateTouristPost> {

  final postController = Get.find<PostController>();
  late TextEditingController  _captionController;
late FocusScopeNode _focusScopeNode;

      final _key = GlobalKey<FormState>();

      File? _image;
      String? _currentPhoto;


@override
void initState() {


_captionController = TextEditingController(text: widget.post.caption);
_focusScopeNode = FocusScopeNode();


setState(() {
  if(widget.post.post_image != null ){
      _currentPhoto = widget.post.post_image;
  }
});

  super.initState();
  
}

@override
  void dispose() {  

    _captionController.dispose();
   _focusScopeNode.dispose();



    
    super.dispose();
  }



  Future<void> chooseImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void updatePost(BuildContext context){

     _focusScopeNode.unfocus(); 
    if(_key.currentState!.validate()){

      postController.updatePost(context: context, post: widget.post, newPhoto: _image,  caption: _captionController.text);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
  padding: EdgeInsets.all(20),
  child: Form(
    key: _key,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _captionController,
          onSaved:(value)=> updatePost(context),
          validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your caption  ';
                    }
                    return null;
                  },
                
          decoration: InputDecoration(
            labelText: 'Caption',
            
            border: UnderlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        Text('Upload Image (optional)', style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        GestureDetector(
          onTap: chooseImage,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: _image != null
                ? Image.file(
                    _image!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      // Handle image load errors here
                      return Center(child: Text('Error loading image'));
                    },
                  )
                :widget.post.post_image != null? CachedNetworkImage(
                                    imageUrl: widget.post.post_image ??
                                        Asset.avatarDefault,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (_, __) => Shimmer.fromColors(
                                      child: Container(
                                        color: Colors.grey[300],
                                      ),
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      period:
                                          const Duration(milliseconds: 1500),
                                    ),
                                  ) :  Center(child: Icon(Icons.image)),
          ),
        ),
        SizedBox(height: 20),
        GetBuilder<PostController>(
          builder: (controller) {
            return SizedBox(
              width: double.infinity,
              height: 50,
              child: controller.isUpdating.value ? Center(child: LoaderWidget() ,):  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                ),
                onPressed: ()=> updatePost(context),
                child: Text(
                  'Update',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          }
        ),
      ],
    ),
  ),
);

  }
}
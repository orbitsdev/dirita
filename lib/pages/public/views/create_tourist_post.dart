

import 'dart:io';

import 'package:dirita_tourist_spot_app/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:dirita_tourist_spot_app/pages/public/controller/post_controller.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';

class CreateTouristPost extends StatefulWidget {


  final TouristSpot spot;
  const CreateTouristPost({
    Key? key,
    required this.spot,
  }) : super(key: key);
  @override
  _CreateTouristPostState createState() => _CreateTouristPostState();
}

class _CreateTouristPostState extends State<CreateTouristPost> {

  final postController = Get.find<PostController>();
    final _captionController = TextEditingController();
      final _focusScopeNode = FocusScopeNode();

      final _key = GlobalKey<FormState>();

      File? _image;


@override
void initState() {
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

  void createPost(BuildContext context){

     _focusScopeNode.unfocus(); 
    if(_key.currentState!.validate()){

        postController.createPost(context: context, spot: widget.spot, caption: _captionController.text.trim(), photo: _image);

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
          onSaved:(value)=> createPost(context),
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
                : Center(child: Icon(Icons.image)),
          ),
        ),
        SizedBox(height: 20),
        GetBuilder<PostController>(
          builder: (controller) {
            return SizedBox(
              width: double.infinity,
              height: 50,
              child: controller.isCreating.value ? Center(child: LoaderWidget() ,):  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                ),
                onPressed: ()=> createPost(context),
                child: Text(
                  'Post',
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
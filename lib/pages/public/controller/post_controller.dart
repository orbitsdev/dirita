import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dirita_tourist_spot_app/api/file_api.dart';
import 'package:dirita_tourist_spot_app/constants/firebase_constant.dart';
import 'package:dirita_tourist_spot_app/models/post.dart';
import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:dirita_tourist_spot_app/utils/asset.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

class PostController extends GetxController {
  var isCreating = false.obs;
  var isUpdating = false.obs;

  void handleCreatePost(BuildContext context, dynamic error) {
    isCreating(false);
    update();
    Modal.showErrorDialog(context: context, message: error.toString());
  }


   void handleUpdatePost(BuildContext context, dynamic error) {
    isUpdating(false);
    update();
    Modal.showErrorDialog(context: context, message: error.toString());
  }
    

  void createPost({
    required BuildContext context,
    required TouristSpot spot,
    required String caption,
    File? photo,
  }) async {
    isCreating(true);
    update();

    try {
      final String uid = auth.currentUser!.uid;
      final String id = Uuid().v4();

      DateTime createdAt = DateTime.now(); 
      String timestampString = DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt);
      
      Post newRecord = Post(
        uid: uid,
        id: id,
        tourist_spot_id: spot.id as String,
        post_image: null,
        caption: caption,
        created_at: timestampString,
      );

      await posts.doc(id).set(newRecord.toMap());

      if (photo != null) {
        final String postPhoto = await FileApi.uploadFile(
          context: context,
          folder: 'sharedexperience/',
          file_id: id,
          filename: path.basename(photo.path),
          file: photo,
        );

        final updatePostPhoto = {
          'post_image': postPhoto,
        };

        await posts.doc(id).update(updatePostPhoto);
      
      }

      isCreating(false);
      update();
        Get.back();
        Modal.showSuccesToast(context: context, message: 'Post successfully created');
    } catch (e) {
      handleCreatePost(context, e);
    }
  }


   void deletePost({
    required BuildContext context,
    required String postId,
    required String? postImage,
  }) async {
    try {

      Modal.showProgressDialog(context: context);
      await posts.doc(postId).delete();

      if (postImage != null) {
        await FileApi.deleteFile(fileUrl: postImage);
      }
      Get.back();
      Modal.showSuccesToast(context: context, message: 'Post successfully deleted');
    } catch (e) {
      Get.back();
      Modal.showErrorDialog(context: context, message: e.toString());
    }
  }


void updatePost({
  required BuildContext context,
  required Post post,
  String? caption,
  File? newPhoto,
}) async {
  isUpdating(true);
  update();




  try {
    final updatePostData = {
      if (caption != null) 'caption': caption,
    };

    if (newPhoto != null) {
      final String postPhoto = await FileApi.uploadFile(
        context: context,
        folder: 'sharedexperience/',
        file_id: post.id,
        filename: path.basename(newPhoto.path),
        file: newPhoto,
      );

      updatePostData['post_image'] = postPhoto;
    }

    await posts.doc(post.id).update(updatePostData);

    // Delete the old file if a new photo was provided and the update operation was successful
    if (newPhoto != null && post.post_image != null) {
      
       await FileApi.deleteFile(fileUrl: post.post_image!);
    }

    isUpdating(false);
    update();
    Get.back();
    Modal.showSuccesToast(context: context, message: 'Post successfully updated');
  } catch (e) {
    handleUpdatePost(context, e);
  }

}
}



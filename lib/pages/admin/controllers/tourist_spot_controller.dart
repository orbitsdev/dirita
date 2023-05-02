import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dirita_tourist_spot_app/api/file_api.dart';
import 'package:dirita_tourist_spot_app/api/google_map_api.dart';
import 'package:dirita_tourist_spot_app/constants/firebase_constant.dart';
import 'package:dirita_tourist_spot_app/models/geo_model.dart';
import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:dirita_tourist_spot_app/pages/admin/views/admin_screen.dart';
import 'package:dirita_tourist_spot_app/pages/auth/controller/auth_controller.dart';
import 'package:dirita_tourist_spot_app/pages/public/views/tourist_spot_screen.dart';
import 'package:dirita_tourist_spot_app/utils/asset.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

class TouristSpotController extends GetxController {
  var authcontroller = Get.find<AuthController>();
  var isCreating = false.obs;
  var isDeleting = false.obs;
  var touristspot = TouristSpot().obs;
  var isRequesting = false.obs;
  var temporaryAddressInformation = GeoModel().obs;

  
  // use  to display all toruist 
  final touristspotsStream =  touristspots.where('user_uid', isEqualTo: auth.currentUser!.uid).snapshots();
  // late StreamSubscription touristspotsSubscription;
  // final touristspotsStream = touristspots .where('user_uid', isEqualTo: auth.currentUser!.uid)
  //     .snapshots();

  // @override
  // void onInit() {
  //   super.onInit();
  //   touristspotsSubscription = touristspotsStream.listen((QuerySnapshot snapshot) {
  //     // Handle the snapshot here
  //   });
  // }

  // @override
  // void dispose() {
  //   touristspotsSubscription.cancel();
  //   super.dispose();
  // }
  

  // @override
  // void onClose() {
  //   super.onClose();
  //   touristspotsSubscription.cancel();
  // }

  var suggestions = <dynamic>[].obs;

  void test({required BuildContext context}) {
    Modal.test(context: context);
  }

  void clearSelectedAddress() {
    temporaryAddressInformation(GeoModel());
    update();
  }

  void updateSelected(GeoModel geoModel) {
    temporaryAddressInformation(geoModel);
    update();
  }

  void handleError(BuildContext context, e) {
    isRequesting(false);
    update();
    Modal.showErrorDialog(context: context, message: e.toString());
  }

  void handleCreateTouristError(BuildContext context, e) {
    isCreating(true);
    update();
    Modal.showErrorDialog(context: context, message: e.toString());
  }

  void handleDeleteTourist(BuildContext context, e) {
    isDeleting(true);
    update();
    Modal.showErrorDialog(context: context, message: e.toString());
  }

  void getLocationInformation(
      {required BuildContext context, required LatLng latlng}) async {
    try {
      isRequesting(true);
      update();

      final response = await GoogleMapApi.geoRequest(latlng);
      final data = response.data['results'][0];
      final plus_code = response.data['plus_code'];

      GeoModel geodata = GeoModel(
        place_id: data['place_id'],
        formatted_address: data['formatted_address'],
        latitude: data['geometry']['location']['lat'],
        longitude: data['geometry']['location']['lng'],
        compound_code: plus_code['compound_code'],
        global_code: plus_code['global_code'],
      );

      temporaryAddressInformation(geodata);
      isRequesting(false);
      update();
    } on PlatformException catch (e) {
      handleError(context, e);
    } on SocketException catch (e) {
      handleError(context, e);
    } catch (e) {
      handleError(context, e);
    }
  }

  Future<void> fetchSuggestions(String query) async {
    final response = await GoogleMapApi.placeApiRequest(query);

    if (response.statusCode == 200) {
      final data = response.data;
      suggestions(data['predictions']);
    } else {
      suggestions([]);
    }
  }

  Future<LatLng> fetchDetails(String place_id) async {
    LatLng latlng;
    final response = await GoogleMapApi.placeDetailsRequest(place_id);
    final data = response.data['result']['geometry']['location'];
    latlng = LatLng(data['lat'], data['lng']);
    return latlng;
  }

  void createTouristSpot({
    required BuildContext context,
    required String name,
    required String famouse_name,
    required String about_information,
    required String more_information,
    required String formmated_address,
    required String place_id,
    required double latitude,
    required double longtitude,
    required File cover_image,
    required List<File> featured_image,
  }) async {
    try {
      isCreating(true);
      update();
      final String uid = auth.currentUser!.uid;
      final String id = Uuid().v4();

      TouristSpot new_touristspot = TouristSpot(
        user_uid: uid,
        id: id,
        name: name,
        famouse_name: famouse_name,
        about_information: about_information,
        more_information: more_information,
        formatted_address: formmated_address,
        place_id: place_id,
        latitude: latitude,
        longtitude: longtitude,
        cover_image: Asset.avatarDefault,
        featured_image: [],
      );

      await touristspots.doc(id).set(new_touristspot.toMap());
      final String cover_image_url = await FileApi.uploadFile(
          context: context,
          folder: 'touristspot/coverimage/',
          file_id: id,
          filename: path.basename(cover_image.path),
          file: cover_image);
      final updated_cover_image = {
        'cover_image': cover_image_url,
      };

      await touristspots.doc(id).update(updated_cover_image);

      final featured_image_url =
          await Future.wait(featured_image.map((file) async {
        final file_uid = Uuid().v4();
        final featued_image_url = await FileApi.uploadFile(
          context: context,
          folder: 'touristspot/featured_image/',
          file_id: file_uid,
          filename: path.basename(file.path),
          file: file,
        );
        return featued_image_url;
      }));
      final updated_featured_image = {'featured_image': featured_image_url};
      await touristspots.doc(id).update(updated_featured_image);

      isCreating(false);
      update();

      Get.off(() => const AdminScreen());
    } on FirebaseException catch (e) {
      handleCreateTouristError(context, e);
    } on PlatformException catch (e) {
      handleCreateTouristError(context, e);
    } catch (e) {
      handleCreateTouristError(context, e);
    }
  }




Future<void> deleteTouristSpot({ required BuildContext context, required String id}) async {
  try {
    isDeleting(true);
    update();
    final touristSpotDoc = touristspots.doc(id);
    final touristSpotData = await touristSpotDoc.get();
    final coverImageUrl = touristSpotData.get('cover_image');
    final featuredImageUrls = List<String>.from(touristSpotData.get('featured_image'));
    await Future.wait([
      FirebaseStorage.instance.refFromURL(coverImageUrl).delete(),
      ...featuredImageUrls.map((url) => FirebaseStorage.instance.refFromURL(url).delete()),
      touristSpotDoc.delete(),
    ]);
    isDeleting(false);
    update();
    Get.back();
  } on FirebaseException catch (e) {
    handleDeleteTourist(context, e);
  } catch (e) {
    handleDeleteTourist(context, e);
  }
}


//    Future<void> deleteTouristSpot({ required BuildContext context,required String id}) async {
//     try {
//     isDeleting(true);
//     update();
//     final touristSpotDoc = touristspots.doc(id);
//     final touristSpotData = await touristSpotDoc.get();
// final coverImageUrl = touristSpotData.get('cover_image');
// final featuredImageUrls = List<String>.from(touristSpotData.get('featured_image'));
// await FirebaseStorage.instance.refFromURL(coverImageUrl).delete();
// await Future.wait(featuredImageUrls.map((url) => FirebaseStorage.instance.refFromURL(url).delete()));
// await touristSpotDoc.delete();
//     isDeleting(false);
//     update();
    
//     Get.back();
//     } on FirebaseException catch (e) {
//      handleDeleteTourist(context, e);
//     } catch (e) {
//      handleDeleteTourist(context, e);
//     }
//   }
}

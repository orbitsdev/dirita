import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dirita_tourist_spot_app/api/file_api.dart';
import 'package:dirita_tourist_spot_app/api/google_map_api.dart';
import 'package:dirita_tourist_spot_app/constants/firebase_constant.dart';
import 'package:dirita_tourist_spot_app/models/geo_model.dart';
import 'package:dirita_tourist_spot_app/models/place_details.dart';
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
  var isUpdating = false.obs;
  var touristspot = TouristSpot().obs;
  var isRequesting = false.obs;
  var temporaryAddressInformation = GeoModel().obs;
  var tempPlaceDetails = PlaceDetails().obs;


  final CollectionReference _touristSpotCollection =  FirebaseFirestore.instance.collection('touristspots');
  var touristSpots = <TouristSpot>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTouristSpots();
  }

  void fetchTouristSpots() async {
    final snapshot = await _touristSpotCollection.get();
    final data = snapshot.docs
        .map((doc) => TouristSpot.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    touristSpots(data);
  }

  var suggestions = <dynamic>[].obs;
  var tsuggestions = <TouristSpot>[].obs;

  void test({required BuildContext context}) {
    Modal.test(context: context);
  }

  void clearSelectedAddress() {
    tempPlaceDetails(PlaceDetails());
    update();
  }

  void updateSelected(PlaceDetails newPlace) {
    tempPlaceDetails(newPlace);
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

  void handleUpdateTouristError(BuildContext context, e) {
    isUpdating(true);
    update();
    Modal.showErrorDialog(context: context, message: e.toString());
  }

  void getLocationInformation(
      {required BuildContext context, required LatLng latlng}) async {
    try {



      isRequesting(true);
      update();

      final response = await GoogleMapApi.geoRequest(latlng);
      final placeId = response.data['results'][0]['place_id'];
     
      final results =  await GoogleMapApi.placeDetailsRequest(placeId);
      final resuldata = results.data['result'];
        PlaceDetails new_place_details = PlaceDetails(
        
        formatted_address: resuldata['formatted_address'],
        place_name: resuldata['name'],
         place_id: resuldata['place_id'], 
         latitude: resuldata['geometry']['location']['lat'],
         longitude: resuldata['geometry']['location']['lng']
          );
      

          print(new_place_details.toString());
          tempPlaceDetails(new_place_details);
    
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

Future<void> searchTouristSpots(String query) async {
  final lowercaseQuery = query.toLowerCase();

  final snapshot = await FirebaseFirestore.instance
      .collection('touristspot')
      .where('name', isGreaterThanOrEqualTo: lowercaseQuery)
      .where('name', isLessThanOrEqualTo: lowercaseQuery + '\uf8ff')
      .limit(10)
      .get();

  final results =
      snapshot.docs.map((doc) => TouristSpot.fromMap(doc.data())).toList();
  tsuggestions(results);
}





  Future<void> fetchInitialTouristSPot() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('touristspot')
        .limit(10)
        .get();

    final results =
        snapshot.docs.map((doc) => TouristSpot.fromMap(doc.data())).toList();
    tsuggestions(results);
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
        name: name.toLowerCase(),
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

  Future<void> deleteTouristSpot(
      {required BuildContext context, required String id}) async {
    try {
      isDeleting(true);
      update();
      final touristSpotDoc = touristspots.doc(id);
      final touristSpotData = await touristSpotDoc.get();
      final coverImageUrl = touristSpotData.get('cover_image');
      final featuredImageUrls =
          List<String>.from(touristSpotData.get('featured_image'));
      await Future.wait([
        FirebaseStorage.instance.refFromURL(coverImageUrl).delete(),
        ...featuredImageUrls
            .map((url) => FirebaseStorage.instance.refFromURL(url).delete()),
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

  Future<void> updateTouristSpot(
      {required BuildContext context,
      required TouristSpot touristspot,
      File? cover_image,
      List<File>? featured_image,
      List<String>? remove_featured}) async {
    try {
      isUpdating(true);
      update();
      final String id = touristspot.id as String;

      // Update cover image if provided
      if (cover_image != null) {
        final String cover_image_url = await FileApi.uploadFile(
            context: context,
            folder: 'touristspot/coverimage/',
            file_id: id,
            filename: path.basename(cover_image.path),
            file: cover_image);
        final updated_cover_image = {'cover_image': cover_image_url};
        touristspot = touristspot.copyWith(cover_image: cover_image_url);
        await touristspots.doc(id).update(updated_cover_image);
      }

      // Update featured images
      if (featured_image != null) {
        // Upload new images
        final new_upload_file_url =
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

        // Combine new and old images
        final old_upload_file_url =
            List<String>.from(touristspot.featured_image ?? []);
        final updated_upload_file_url =
            old_upload_file_url + new_upload_file_url;

        // Remove images if provided
        if (remove_featured != null) {
          await Future.wait([
            ...remove_featured.map((url) async {
              await FirebaseStorage.instance.refFromURL(url).delete();
            }),
          ]);
          // Remove removed images from updated list
          updated_upload_file_url
              .removeWhere((url) => remove_featured.contains(url));
        }

        final updated_featured_image = {
          'featured_image': updated_upload_file_url
        };
        touristspot =
            touristspot.copyWith(featured_image: updated_upload_file_url);
        await touristspots.doc(id).update(updated_featured_image);
      }

      final updated_touristspot = touristspot.toMap();
      await touristspots.doc(id).update(updated_touristspot);
      isUpdating(false);
      update();

      Get.off(() => const AdminScreen());
    } on FirebaseException catch (e) {
      handleUpdateTouristError(context, e);
    } on PlatformException catch (e) {
      handleUpdateTouristError(context, e);
    } catch (e) {
      handleUpdateTouristError(context, e);
    }
  }

  // Future<void> updateTouristSpot({
  //   required BuildContext context,
  //   required TouristSpot touristspot,
  //   File? cover_image,
  //   List<File>? featured_image,
  //   List<String>? remove_featured,
  // }) async {
  //   try {

  //     isUpdating(true);
  //     update();
  //     final String id = touristspot.id as String;

  //     if (cover_image != null) {
  //       final String cover_image_url = await FileApi.uploadFile(
  //           context: context,
  //           folder: 'touristspot/coverimage/',
  //           file_id: id,
  //           filename: path.basename(cover_image.path),
  //           file: cover_image);
  //       final updated_cover_image = {
  //         'cover_image': cover_image_url,
  //       };
  //       touristspot = touristspot.copyWith(cover_image: cover_image_url);
  //       await touristspots.doc(id).update(updated_cover_image);
  //     }

  //     List<String> new_upload_file_url = [];
  //     if (featured_image != null) {
  //       new_upload_file_url =  await Future.wait(featured_image.map((file) async {
  //         final file_uid = Uuid().v4();
  //         final featued_image_url = await FileApi.uploadFile(
  //           context: context,
  //           folder: 'touristspot/featured_image/',
  //           file_id: file_uid,
  //           filename: path.basename(file.path),
  //           file: file,
  //         );
  //         return featued_image_url;
  //       }));

  //       if (remove_featured != null) {

  //             await Future.wait([    ...remove_featured.map( (url)  async{

  //               await FirebaseStorage.instance.refFromURL(url).delete();

  //               // remove_feature contain url in fhe fires store, what iw want is  to delete also the url in the firsretore after deletinf in the  sotrage
  //             }),

  //         ]);
  //       }

  //       final updated_featured_image = {'featured_image': new_upload_file_url};
  //       touristspot = touristspot.copyWith(
  //           featured_image: List<String>.from(new_upload_file_url));
  //            await touristspots.doc(id).update(updated_featured_image);
  //     }

  //     final updated_touristspot = touristspot.toMap();
  //     await touristspots.doc(id).update(updated_touristspot);
  //     isUpdating(false);
  //     update();

  //     Get.off(() => const AdminScreen());
  //   } on FirebaseException catch (e) {
  //     handleUpdateTouristError(context, e);
  //   } on PlatformException catch (e) {
  //     handleUpdateTouristError(context, e);
  //   } catch (e) {
  //     handleUpdateTouristError(context, e);
  //   }
  // }
}

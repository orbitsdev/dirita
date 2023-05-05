import 'package:dirita_tourist_spot_app/api/google_map_api.dart';
import 'package:dirita_tourist_spot_app/models/geo_model.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  var isLoading = false.obs;
  var currentLocationDetails = GeoModel().obs;
  Future<GeoModel> getCurrentLocationDetails(LatLng latlng) async {
    try {
      isLoading(true);
      update();
      final response = await GoogleMapApi.geoRequest(latlng);
      final data = response.data['results'][0];
      final plus_code = response.data['plus_code'];

      GeoModel geodata = GeoModel(
        place_id: data['place_id'],
        formatted_address: data['formatted_address'],
        latitude: data['geometry']['location']['lat'],
        longitude: data['geometry']['location']['lng'],
      );

      currentLocationDetails(geodata);
      isLoading(false);
      update();

      return GeoModel();
    } catch (e) {
      Modal.toast(message: e.toString());
      isLoading(false);
      update();
      throw e;
    }
  }
}

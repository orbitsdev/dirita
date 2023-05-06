import 'package:dirita_tourist_spot_app/ai/text_to_speech_controller.dart';
import 'package:dirita_tourist_spot_app/pages/admin/controllers/location_controller.dart';
import 'package:dirita_tourist_spot_app/pages/admin/controllers/tourist_spot_controller.dart';
import 'package:dirita_tourist_spot_app/pages/auth/controller/auth_controller.dart';
import 'package:dirita_tourist_spot_app/pages/public/controller/post_controller.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(TouristSpotController(), permanent: true);
    Get.put(LocationController(), permanent: true);
    Get.put(PostController(), permanent: true);
  }  
}
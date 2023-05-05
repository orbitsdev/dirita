import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirita_tourist_spot_app/utils/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:dirita_tourist_spot_app/models/geo_model.dart';
import 'package:dirita_tourist_spot_app/models/tourist_spot.dart';
import 'package:dirita_tourist_spot_app/pages/admin/controllers/tourist_spot_controller.dart';
import 'package:dirita_tourist_spot_app/pages/admin/views/select_tourist_location_map_screen.dart';
import 'package:dirita_tourist_spot_app/pages/auth/controller/auth_controller.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:dirita_tourist_spot_app/widgets/loader_widget.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:shimmer/shimmer.dart';

class UpdateTouristSpotScreen extends StatefulWidget {
  TouristSpot? touristspot;
  UpdateTouristSpotScreen({
    Key? key,
    this.touristspot,
  }) : super(key: key);
  @override
  State<UpdateTouristSpotScreen> createState() =>
      _UpdateTouristSpotScreenState();
}

class _UpdateTouristSpotScreenState extends State<UpdateTouristSpotScreen> {
  final authcontroller = Get.find<AuthController>();
  final touristcontroller = Get.find<TouristSpotController>();

  late TextEditingController _nameController;
  late TextEditingController _shortNameController;
  late TextEditingController _aboutController;
  late TextEditingController _moreController;

  GeoModel? selectedLocation;

  late FocusNode _nameFucusNode;
  late FocusNode _shortNameFucusNode;
  late FocusNode _aboutFucusNode;
  late FocusNode _moreFucusNode;

  final _key = GlobalKey<FormState>();
  final _focusScopeNode = FocusScopeNode();

  final picker = ImagePicker();
  List<File> _images = [];
  File? _image;
  late List<String> existing_featured_image;
   List<String> remove_featured = [];

  @override
  void initState() {
    // TODO: implement initStat
    super.initState();

    _nameController =
        TextEditingController(text: widget.touristspot?.name ?? '');
    _shortNameController =
        TextEditingController(text: widget.touristspot?.famouse_name ?? '');
    _aboutController = TextEditingController(
        text: widget.touristspot?.about_information ?? '');
    _moreController =
        TextEditingController(text: widget.touristspot?.more_information ?? '');
    selectedLocation = GeoModel(
      place_id: widget.touristspot?.place_id ?? '',
      formatted_address: widget.touristspot?.formatted_address ?? '',
      latitude: widget.touristspot?.latitude,
      longitude: widget.touristspot?.longtitude,
    );
    existing_featured_image = widget.touristspot?.featured_image ?? [];

    _nameFucusNode = FocusNode();
    _shortNameFucusNode = FocusNode();
    _aboutFucusNode = FocusNode();
    _moreFucusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _shortNameController.dispose();
    _aboutController.dispose();
    _moreController.dispose();

    _nameFucusNode.dispose();
    _shortNameFucusNode.dispose();
    _aboutFucusNode.dispose();
    _moreFucusNode.dispose();
    super.dispose();
  }

  void chooseImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images.addAll(
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList());
      });
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _images.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
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

  _update(BuildContext context) {
    _focusScopeNode.unfocus();

    // Validate the form
    if (_key.currentState!.validate()) {
      if (selectedLocation == null ||
          selectedLocation?.formatted_address == null) {
        Modal.showToast(
            context: context, message: 'Tourist spot  location is required');
        return;
      }

      if (_image == null && widget.touristspot?.cover_image == null) {
        Modal.showToast(context: context, message: 'Cover  image is required');
        return;
      }
      List<String>? featured_image_url =
          widget.touristspot!.featured_image ?? [];

      if (featured_image_url.isEmpty && _images.length < 3) {
        Modal.showToast(
            context: context,
            message: 'You should have atleast 3 featured image');
        return;
      }

      TouristSpot updated_value_toursit_spot = widget.touristspot!.copyWith(

        name: _nameController.text.trim(),
        famouse_name: _shortNameController.text.trim(),
        about_information: _aboutController.text.trim(),
        more_information: _moreController.text.trim(),
        formatted_address: selectedLocation!.formatted_address,
        place_id: selectedLocation!.place_id,
        latitude: selectedLocation!.latitude,
        longtitude: selectedLocation!.longitude,

      );

      touristcontroller.updateTouristSpot(
          context: context,
          touristspot: updated_value_toursit_spot,
          cover_image: _image,
          featured_image: _images,
          remove_featured: remove_featured
          );
    }
  }

  void removeFeaturedImage(int index) {
     int total_featured_image =existing_featured_image.length + _images.length;

     if(total_featured_image > 3){

    setState(() {
      _images.removeAt(index);
    });

     }else{
              Modal.showToast(context: context ,message: '3  featured  image. Try adding one first to delete the image');

     }
  }

  void removeExistingFeatured(int index) {
       int total_featured_image =existing_featured_image.length + _images.length;


       if(total_featured_image > 3){

         setState(() {
         remove_featured.add(existing_featured_image[index]);
          existing_featured_image.removeAt(index);
        });
       }else{
        Modal.showToast(context: context ,message: 'You must have atleast 3  featured  image. Try adding one to delete the image');
       }


    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new Tourist Spot'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Container(
          child: Form(
            key: _key,
            child: FocusScope(
              node: _focusScopeNode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tourist spot name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(),
                    controller: _nameController,
                    focusNode: _nameFucusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is Required ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Tourist spot famouse name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(),
                    controller: _shortNameController,
                    focusNode: _shortNameFucusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is Required ';
                      }
                      return null;
                    },
                  ),
                  const VSpace(20),
                  Text(
                    'About information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    maxLines: 5,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(),
                    controller: _aboutController,
                    focusNode: _aboutFucusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is Required ';
                      }
                      return null;
                    },
                  ),
                  const VSpace(20),
                  Text(
                    'More information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    maxLines: 5,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(),
                    controller: _moreController,
                    focusNode: _moreFucusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is Required ';
                      }
                      return null;
                    },
                  ),
                  const VSpace(20),
                  Text(
                    'Tourist spot Location',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  InkWell(
                    onTap: () async {
                      GeoModel response = await Get.to(() =>
                          SelectTouristLocationSpotScreen(
                              selectedLocation: selectedLocation));

                      if (response != null) {
                        setState(() {
                          selectedLocation = response;
                        });
                      } else {
                        setState(() {
                          selectedLocation = null;
                        });
                      }
                    },
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "Find",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Icon(Icons.location_on),
                          ),
                        ],
                      ),
                    ),
                  ),
                  VSpace(16),
                  Container(
                    padding: EdgeInsets.all(20),
                    constraints: BoxConstraints(
                      minHeight: 100,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(selectedLocation?.formatted_address ?? ''),
                    ),
                  ),
                  const VSpace(20),
                  Text(
                    'Tourist spot cover image',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const VSpace(10),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: chooseImage,
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _image != null
                            ? Image.file(
                                width: double.infinity,
                                _image!,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  // Handle image load errors here
                                  return Center(
                                      child: Text('Error loading image'));
                                },
                              )
                            : widget.touristspot?.cover_image != null
                                ? CachedNetworkImage(
                                    imageUrl: widget.touristspot?.cover_image ??
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
                                  )
                                : Center(
                                    child: Icon(Icons.image),
                                  ),
                      ),
                    ),
                  ),
                  const VSpace(20),
                  if (existing_featured_image.length > 0)
                    Column(
                      children: [
                        Text(
                          'Existing featured image',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const VSpace(10),
                        GestureDetector(
                            behavior: HitTestBehavior.opaque,
                      onTap: () {
                        // Handle tap here
                      },
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: List.generate(
                          existing_featured_image.length,
                          (index) => Stack(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: existing_featured_image[index],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Shimmer.fromColors(
                                      child: Container(color: Colors.grey[300]),
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                    ),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                   behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      removeExistingFeatured(index);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(Icons.close, size: 18),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                          ),
                        )
                      ],
                    ),

                  const VSpace(20),

             
                  Text(
                    'Tourist spot featured image',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const VSpace(10),
                  Container(
                    height: 215,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        // Handle tap here
                      },
                      child: GridView.builder(
                        itemCount: _images.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: chooseImages,
                                      icon: Icon(Icons.add),
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                      fit: StackFit.expand,
                                      clipBehavior: Clip.none,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.file(
                                            _images[index - 1],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: -16,
                                          right: -10,
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () =>
                                                removeFeaturedImage(index - 1),
                                            child: ClipOval(
                                              child: Container(
                                                color: Colors.grey.shade300,
                                                width: 26,
                                                height: 26,
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                );
                        },
                      ),
                    ),
                  ),
                  const VSpace(10),
                  GetBuilder<TouristSpotController>(
                    builder: (controller) => SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () => controller.isUpdating.value
                            ? null
                            : _update(context),
                        style: TextButton.styleFrom(
                          backgroundColor: AppTheme.ORANGE,
                          primary: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: controller.isUpdating.value
                            ? LoaderWidget(
                                color: Colors.white,
                              )
                            : const Text(
                                "Update",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const VSpace(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

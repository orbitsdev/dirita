

import 'dart:io';

import 'package:dirita_tourist_spot_app/pages/auth/controller/auth_controller.dart';
import 'package:dirita_tourist_spot_app/pages/public/controller/profile_controller.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({ Key? key }) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final profilecontroller = Get.find<ProfileController>();
  final authcontroller = Get.find<AuthController>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController ;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState() {

      if(authcontroller.user.value.uid != null){

            firstNameController = TextEditingController(text: authcontroller.user.value.first_name);
lastNameController = TextEditingController(text: authcontroller.user.value.last_name);

      }else{
    firstNameController = TextEditingController();
lastNameController = TextEditingController();

      }
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  void updateUserDetails(BuildContext context) {
    if (formKey.currentState!.validate()) {

        profilecontroller.updateUserDetails(context: context, firstName: firstNameController.text.trim(), lastName: lastNameController.text.trim());
    
    }
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.0),
              Text(
                'User Details',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              GetBuilder<ProfileController>(
                builder: (controller) {
                  return ElevatedButton(
                    onPressed: ()=> controller.isUpdating.value ? null: updateUserDetails(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.ORANGE,
                      foregroundColor: Colors.white, // Set the button color to your custom color
                    ),
                    child:controller.isUpdating.value ? Center(child: LoaderWidget(color: Colors.white,)) :  Text('Update'),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }


}











import 'package:dirita_tourist_spot_app/pages/auth/views/login_screen_widget.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Modal {

  static void showBottomSheet(BuildContext context){
      showModalBottomSheet(
        
         isScrollControlled: true,
        context: context, builder: (context)=>Padding(
         padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom,
    ),
          child: Container(
         constraints: BoxConstraints(
          minHeight:   MediaQuery.of(context).size.height * 0.55,
        
         ),
           child: const LoginScreenWidget(),
              ),
        ));
  }



 static void showProgressDialog({required BuildContext context , String message = 'Loading'}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppTheme.ORANGE,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.FONT,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


 static void showMediumProgressDialog({required BuildContext context , String message = 'Loading', bool dismissible  = true}) {
  showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppTheme.ORANGE,
                ),
              ),
              // const SizedBox(height: 20),
              // Container(
              //   child: Text(
              //     message,
              //     style: const TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.bold,
              //       color: AppTheme.FONT,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
    },
  );
}

static void showErrorDialog({required BuildContext context, String message = 'Error'}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: AppTheme.RED,
                size: 48,
              ),
              const SizedBox(height: 20),
              Text(
                'Error',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.FONT,
                 
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.FONT,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: AppTheme.ORANGE,
                  primary: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                   
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

static void showToast({required BuildContext context, String message = 'Hellow'}){

  Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppTheme.RED,
        textColor: Colors.white,
        fontSize: 16.0
    );
}

static void showSuccesToast({required BuildContext context, String message = 'Success'}){

  Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
}


  static void showUploadProgress(
      {required BuildContext context, required TaskSnapshot snapshot}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Uploading file...'),
                SizedBox(height: 16.0),
                Text(
                  '${(snapshot.totalBytes / 1024 / 1024).toStringAsFixed(2)} MB',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                LinearProgressIndicator(
                  value: snapshot.bytesTransferred / snapshot.totalBytes,
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  static void test({required BuildContext context, String filetype = 'Uploading file...'}){
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(filetype),
                  SizedBox(height: 16.0),
                  Text(
                    '25 MB',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  LinearProgressIndicator(
                    value:100,
                  ),
                ],
              ),
            ),
      );
    },
  );
  }


}
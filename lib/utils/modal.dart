





import 'package:dirita_tourist_spot_app/pages/auth/views/login_screen_widget.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

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



 static void showProgressDialog({required BuildContext context , String message = 'Loading...'}) {
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
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.FONT,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


static void showErrorDialog({ required BuildContext context, String message = 'Error'}) {
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
                message,
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

}
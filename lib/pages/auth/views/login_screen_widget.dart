import 'package:dirita_tourist_spot_app/pages/auth/controller/auth_controller.dart';
import 'package:dirita_tourist_spot_app/pages/auth/views/account_selection_screen.dart';
import 'package:dirita_tourist_spot_app/pages/auth/views/signup_screen.dart';
import 'package:dirita_tourist_spot_app/utils/app_theme.dart';
import 'package:dirita_tourist_spot_app/utils/asset.dart';
import 'package:dirita_tourist_spot_app/utils/modal.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({Key? key}) : super(key: key);

  @override
  _LoginScreenWidgetState createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  final authcontroller = Get.find<AuthController>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _key = GlobalKey<FormState>();

  final _focusScopeNode = FocusScopeNode();

  @override
  void dispose() {


    _emailController.dispose();
    _passwordController.dispose();

 

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _focusScopeNode.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    // Unfocus the current input field
    _focusScopeNode.unfocus();

    // Validate the form
    if (_key.currentState!.validate()) {


  
      authcontroller.loginWithEmailAndPassword(context: context, email: _emailController.text.trim(), password: _passwordController.text.trim());
        

    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _key,
          child: FocusScope(
            node: _focusScopeNode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(),
                const VSpace(6),
                ClipOval(
                  child: SizedBox(
                      height: 90,
                      width: 90,
                      child: Image.asset(Asset.imagePath('dirita_logo.png'))),
                ),
                   const VSpace(6),
                Text(
                  'Signup to DIRIKITA',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(),
                ),
                const VSpace(20),
               
                TextFormField(
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(),
                    labelText: 'Email address',
                  ),
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    return null;
                  },
                ),
                const VSpace(10),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const VSpace(24),
                GetBuilder<AuthController>(
                  builder: (controller){
                   return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ORANGE,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => controller.isLoginLoading.value ? null :  _login(context),
                      child:  Center(
                        child: Text(
                          'Login ${controller.isLoginLoading.value.toString()}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                  }
                ),
                const VSpace(20),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "Signup",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.ORANGE,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(()=>  AccountSelectionScreen(), transition: Transition.cupertino);
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dirita_tourist_spot_app/pages/auth/views/login_screen.dart';
import 'package:dirita_tourist_spot_app/utils/asset.dart';
import 'package:dirita_tourist_spot_app/widgets/v_space.dart';

import '../../../utils/app_theme.dart';

class SignupScreen extends StatefulWidget {

  String? name;
   SignupScreen({
    Key? key,
    this.name,
  }) : super(key: key);
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

// controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

//focus node
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _key = GlobalKey<FormState>();

  final _focusScopeNode = FocusScopeNode();

  @override
  void dispose() {

    _firstNameController.dispose();
    _lastNameController.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _focusScopeNode.dispose();
    super.dispose();
  }

  void _register(BuildContext context) {
    // Unfocus the current input field
    _focusScopeNode.unfocus();

    // Validate the form
    if (_key.currentState!.validate()) {
      // Submit the form
      // ...
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

     
      ),
      body:SingleChildScrollView(
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
                   const VSpace(10),
                Text(
                  'Signup to DIRIKITA',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(),
                  textAlign: TextAlign.center,
                ),
                 const VSpace(10),
                Text(
                  'as',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(),
                  textAlign: TextAlign.center,
                ),
                 const VSpace(10),
                Text(
                  '${widget.name ?? 'tourist'}'.toUpperCase(),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 24,
                    color: AppTheme.ORANGE
                  ),
                  textAlign: TextAlign.center,
                ),
                const VSpace(20),
                 TextFormField(
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(),
                    labelText: 'First name',
                  ),
                  controller: _firstNameController,
                  focusNode: _firstNameFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name ';
                    }
                    return null;
                  },
                ),
                const VSpace(10),
                TextFormField(
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(),
                    labelText: 'Last name',
                  ),
                  controller: _lastNameController,
                  focusNode: _lastNameFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const VSpace(10),
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
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.ORANGE,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _register(context),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const VSpace(20),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "Signin",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.ORANGE,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                           Get.to(()=> LoginScreen());
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
    ),
    );
  }
}
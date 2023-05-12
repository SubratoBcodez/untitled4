import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled4/ui/views/home_screen.dart';
import 'package:untitled4/ui/widgets/custom_button.dart';
import 'package:untitled4/ui/widgets/custom_text.dart';

import '../../logic/auth.dart';
import '../route/route.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 200),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 80,
                ),
                customText('email', Icons.mail_outline,
                    TextInputType.emailAddress, _emailController, (val) {
                  if (val!.isEmpty) {
                    return "can't be empty";
                  } else if (val.length < 8) {
                    return "can't be less then 8";
                  }
                }),
                SizedBox(
                  height: 15,
                ),
                customText(
                  'password',
                  Icons.remove_red_eye_outlined,
                  TextInputType.text,
                  _passController,
                  (val) {
                    if (val!.isEmpty) {
                      return "can't be empty";
                    } else if (val.length < 8) {
                      return "can't be less then 8";
                    }
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 15,
                ),
                customButton('Sign In', () {
                  if (_formKey.currentState!.validate()) {
                    final email = _emailController.text;
                    final pass = _passController.text;
                    Auth().log(email, pass, context);
                  }
                }),
                SizedBox(
                  height: 15,
                ),
                RichText(
                    text: TextSpan(
                        text: 'Don\'t Have an Account?',
                        style: TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(reg),
                          text: 'Create Now',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w600))
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

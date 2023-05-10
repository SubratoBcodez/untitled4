import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled4/const/app_string.dart';
import 'package:untitled4/ui/route/route.dart';

import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();
  chooseScreen(context) {
    var loginchk = box.read('loginchk');
    var regchk = box.read('regchk');
    // print(login);
    // print(reg);

    if (loginchk == true) {
      Get.toNamed(login);
    } else if (regchk == true) {
      Get.toNamed(reg);
    } else {
      Get.toNamed(intro);
    }

    // Future.delayed(const Duration(seconds: 3), () => Get.toNamed(intro));
  }

  // chooseScreen() {
  //   Future.delayed(
  //       Duration(seconds: 3),
  //           () => Navigator.push(
  //           context, CupertinoPageRoute(builder: (_)=>introScreen())));
  // }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () => chooseScreen(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Center(
                    child: Image.asset(
                  'assets/images/main.png',
                  width: 130,
                )),
              ),
              // Center(child: Image.asset('assets/images/main.png', width: 120,),),
              SizedBox(
                height: 10,
              ),
              Text(
                AppString.app_name,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}

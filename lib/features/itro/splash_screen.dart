// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/functions/navigations.dart';
import 'package:flutter_application_1/core/utils/text_style.dart';
import 'package:flutter_application_1/features/home/home_screen.dart';
import 'package:flutter_application_1/features/upload/upload_screen.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    var userBox = Hive.box("user");
    bool isuploaded = userBox.get("isuploaded")??false;
    Future.delayed(Duration(seconds: 3),(){
      if((isuploaded)) {
      pushWithReplacment(context, HomeScreen());
     }else
      {
        pushWithReplacment(context, UploadScreen());
      }
     
  });}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('./assets/images/logo.json'),
            Text("Taskati", style: getTitleTextStyle()),
            Text("its time to run the task", style:getTitleTextStyle(fontSize:18, fontWeight:FontWeight.w400,color: AppColor.secondaryColor)),
          ],
          
        )
      ),
    );
  }
}
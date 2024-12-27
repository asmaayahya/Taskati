// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/components/custom_button.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/text_style.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           CircleAvatar(
             backgroundColor:  Colors.grey,
             child: Icon(Icons.camera_alt, color: Colors.white,),
             radius: 70.0,
            
            
           ),
                SizedBox(height: 20.0),
            customButton(text: "Upload From Camera",),
            SizedBox(height: 20.0),
            customButton(text: "Upload From Gallery",),
              
          ],
        )
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/text_style.dart';

class customButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color ?backgroundColor;
  final Color ?foregroundColor;
  final Function() onPressed;


   customButton({
    super.key,
     required this.text,
     this.width =250,
     this.height=45,
     this.backgroundColor,
     this.foregroundColor,
     required this.onPressed,
    

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: (){} , child: Text(text, style: getTitleTextStyle(color: foregroundColor?? AppColor.whitecolor, fontSize: 15),),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor??AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          
        ),
        ),
    );
  }
}
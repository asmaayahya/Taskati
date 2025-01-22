// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/text_style.dart';
import 'package:hive/hive.dart';

class custom_row extends StatelessWidget {
  final Widget myWidget;
  final String firstText;
  final String secondText;
  const custom_row({
    required this.firstText,
    required this.secondText,
    required this.myWidget,
    super.key,
    required this.userBox,
  });

  final Box userBox;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
          Text(firstText,
          style:getTitleTextStyle(fontSize: 15,color: AppColor.primaryColor,fontWeight: FontWeight.w500)),
          Text(secondText,
          style:getTitleTextStyle(fontSize: 20,color:AppColor.secondaryColor,fontWeight: FontWeight.w600)),
          
        ],),
       myWidget
      ],
    );
  }
}

 

        
        
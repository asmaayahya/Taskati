import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';

getTitleTextStyle({double? fontSize, Color? color, FontWeight? fontWeight}){
  return TextStyle(
    fontSize:fontSize??30,
    color: color ??AppColor.primaryColor,
    fontWeight: fontWeight ??FontWeight.bold
  );
}
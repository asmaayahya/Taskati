import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/upload/upload_screen.dart';

void pushTO(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}


pushWithReplacment(BuildContext context, Widget newScreen){
   Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) => newScreen));
    
}
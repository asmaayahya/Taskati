import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/upload/upload_screen.dart';

pushTO(BuildContext context, Widget newScreen){
   Navigator.push(context, MaterialPageRoute(
    builder: (context) => newScreen));
    
}

pushWithReplacment(BuildContext context, Widget newScreen){
   Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) => newScreen));
    
}
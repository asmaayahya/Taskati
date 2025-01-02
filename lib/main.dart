import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/itro/splash_screen.dart';

void main(){
  runApp(MainApp());
}
class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
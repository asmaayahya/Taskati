import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/functions/model/task_adapter.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/features/itro/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open the "user" box
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox("user");
  await Hive.openBox("task");

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: ThemeData(
      
        
        inputDecorationTheme: InputDecorationTheme(
      
                    
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                 
        )
        
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

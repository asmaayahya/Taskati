// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/components/custom_button.dart';
import 'package:flutter_application_1/core/functions/navigations.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/text_style.dart';
import 'package:flutter_application_1/features/home/home_screen.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  final ImagePicker picker=ImagePicker();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      AppBar(actions: [
        TextButton(onPressed: (){
        if(formKey.currentState!.validate()&& path!=null){
      pushWithReplacment(context, HomeScreen());
        }else if(path==null){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text("Warning"),
              content: Text("Please select an image"),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text("Ok")),
              ],
            );
          });
        }
        }, child: Text(
          " Done",
          style: TextStyle(color: AppColor.primaryColor, fontSize: 18.0, fontWeight: FontWeight.w800),
        ))
      ],),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             CircleAvatar(
               
               
               radius: 70.0,
               backgroundImage: path!=null? FileImage(File(path!)): NetworkImage("http://picsum.photos/200"),
              
              
             ),
                  SizedBox(height: 20.0),
              customButton(text: "Upload From Camera",onPressed: ()async {
               await ImagePicker().pickImage(source: ImageSource.camera).then((value){
                if(value!=null){
                   setState(() {
                    path = value.path;
                  });
                }
               });
              },),
              
              SizedBox(height: 20.0),
              customButton(text: "Upload From Gallery",onPressed: ()async{
                 await ImagePicker().pickImage(source: ImageSource.gallery).then((value){
                if(value!=null){
                  setState(() {
                    path = value.path;
                  });
                  }
               });
              },),
              SizedBox(height: 20.0),
              Divider(
                color: AppColor.primaryColor,
                thickness: 2.0,
                indent: 20,
                endIndent: 20,
          
              ),
               SizedBox(height: 20.0),
               
                 Form(
                  key: formKey,
              
                   child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Name is required';
                      }else if(value.length < 3){
                        return 'Name should be at least 3 characters long';
                      } else {
                        return null;
                      }
                    },
                    controller: nameController ,
                    decoration: InputDecoration(
                      hintText: 'Enter your Name...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.primaryColor),
                        borderRadius: BorderRadius.circular(10),
                       
                        
                      )
                    ),
                    onChanged: (text) {
                      // Update the caption text
                    },
                   ),
                 ),
               
              
                
            ],
          ),
        )
      ),
    );
  }
}

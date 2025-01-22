import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/components/custom_button.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/text_style.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userBox = Hive.box("user");
  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  String? path;

  @override
  void initState() {
    super.initState();
    nameController.text = userBox.get("name", defaultValue: ""); 
    path = userBox.get("image", defaultValue: null); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text(
          'My Profile',
          style: getTitleTextStyle(color: AppColor.whitecolor, fontSize: 22, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: AppColor.whitecolor, size: 20),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                CircleAvatar(
                  radius: 50,
                  backgroundImage: path != null
                      ? (path!.startsWith("http")
                          ? NetworkImage(path!)
                          : FileImage(File(path!)) as ImageProvider)
                      : AssetImage("assets/default_profile_image.png"),
                ),
                SizedBox(height: 20),
                
                
                CustomButton(
                  width: 600,
                  height: 50,
                  text: "Take a photo",
                  onPressed: () async {
                    var pickedFile = await picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      setState(() {
                        path = pickedFile.path;
                      });
                      userBox.put("image", path); 
                    }
                  },
                ),
                SizedBox(height: 20.0),
                
                
                CustomButton(
                  width: 600,
                  height: 50,
                  text: "Choose photo",
                  onPressed: () async {
                    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        path = pickedFile.path;
                      });
                      userBox.put("image", path); 
                    }
                  },
                ),
                SizedBox(height: 20.0),
            
                Divider(color: AppColor.primaryColor, thickness: 2.0, indent: 20, endIndent: 20),
                SizedBox(height: 20.0),
            
                
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      } else if (value.length < 3) {
                        return 'Name should be at least 3 characters long';
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'Enter your Name...'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.secondaryColor,
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            
            userBox.put("name", nameController.text);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profile updated successfully!")),
            );
          }
        },
        child: Icon(Icons.save_rounded, color: AppColor.whitecolor),
      ),
    );
  }
}

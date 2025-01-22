import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/core/components/custom_button.dart';
import 'package:flutter_application_1/core/functions/navigations.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/features/home/home_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path; // Stores the image path
  final ImagePicker picker = ImagePicker();
  var nameController = TextEditingController(); // Controller for name input
  var formKey = GlobalKey<FormState>(); // Form key for validation

  // Default image URL (can be a local asset or a network image)
  final String defaultImageUrl = "https://picsum.photos/seed/picsum/200/200";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                // Open the Hive box
                var userBox = await Hive.openBox("user");

                // Assign default image if no image is selected
                if (path == null) {
                  path = defaultImageUrl;
                }

                // Save name and image path to Hive
                userBox.put("name", nameController.text);
                userBox.put("image", path);
                userBox.put("isuploaded", true);

                // Navigate to the HomeScreen
                pushWithReplacment(context, HomeScreen());
              } else if (path == null) {
                // Show a warning dialog if no image was selected
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Warning"),
                      content: Text("Please select an image"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Ok"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text(
              "Done",
              style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // CircleAvatar to show the selected or default image
                CircleAvatar(
          radius: 70.0,
          backgroundImage: path != null
        ? (path!.startsWith("http") // Check if it's a URL
            ? NetworkImage(path!) // Network image if it's a URL
            : File(path!).existsSync() // Check if the file exists
                ? FileImage(File(path!)) // Local file image if file exists
                : NetworkImage(defaultImageUrl)) // Fallback if file does not exist
        : NetworkImage(defaultImageUrl), // Default image if path is null
        ),
        
                SizedBox(height: 20.0),
                // Button to upload image from the camera
                CustomButton(
                  text: "Upload From Camera",
                  onPressed: () async {
                    await picker.pickImage(source: ImageSource.camera).then((value) {
                      if (value != null) {
                        setState(() {
                          path = value.path;
                        });
                      }
                    });
                  },
                ),
                SizedBox(height: 20.0),
                // Button to upload image from the gallery
                CustomButton(
                  text: "Upload From Gallery",
                  onPressed: () async {
                    await picker.pickImage(source: ImageSource.gallery).then((value) {
                      if (value != null) {
                        setState(() {
                          path = value.path;
                        });
                      }
                    });
                  },
                ),
                SizedBox(height: 20.0),
                Divider(
                  color: AppColor.primaryColor,
                  thickness: 2.0,
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(height: 20.0),
                // Form for the name input
                Form(
                  key: formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      } else if (value.length < 3) {
                        return 'Name should be at least 3 characters long';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your Name...',
                      
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskaty/components/buttons/main_button.dart';
import 'package:taskaty/core/extensions/dialogs.dart';
import 'package:taskaty/core/utils/colors.dart';
import 'package:taskaty/core/services/local_helper.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  Uint8List? imageBytes;
  String? imagePath;
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (imageBytes != null && nameController.text.isNotEmpty) {
                LocalHelper.cacheData(LocalHelper.kName, nameController.text);
                if (imagePath != null) {
                  LocalHelper.cacheData(LocalHelper.kImage, imagePath);
                }
                Navigator.pushReplacementNamed(context, '/home');
              } else if (imageBytes != null && nameController.text.isEmpty) {
                showErrorDialog(context, 'Please enter your name');
              } else if (imageBytes == null && nameController.text.isNotEmpty) {
                showErrorDialog(context, 'Please upload your profile image');
              } else {
                showErrorDialog(
                  context,
                  'Please enter your name and upload your profile image',
                );
              }
            },
            child: Text('Done'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: AppColors.primaryColor,
                  backgroundImage: imageBytes != null
                      ? MemoryImage(imageBytes!)
                      : const AssetImage('assets/images/user.png'),
                ),
                Gap(20),
                MainButton(
                  width: 250,
                  text: 'Upload From Camera',
                  onPressed: () {
                    uploadImage(true);
                  },
                ),
                Gap(10),
                MainButton(
                  width: 250,
                  text: 'Upload From Gallery',
                  onPressed: () async {
                    uploadImage(false);
                  },
                ),
                Gap(20),
                Divider(),
                Gap(20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Enter your name'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  uploadImage(bool isCamera) async {
    final xfile = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (xfile != null) {
      final bytes = await xfile.readAsBytes();
      if (!mounted) return;
      setState(() {
        imageBytes = bytes;
        imagePath = xfile.path;
      });
    }
  }
}

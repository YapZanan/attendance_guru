import 'dart:io';

import 'package:attendance_guru/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ImageUploader {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();
  late String imageUrl;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late PermissionStatus permissionStatus;

  Future<void> uploadImage({required String id, required BuildContext context}) async {
    XFile? image;

    // Check Permissions
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        await Permission.storage.request();
        permissionStatus = await Permission.storage.status;
      } else {
        await Permission.photos.request();
        permissionStatus = await Permission.photos.status;
      }
    }

    if (permissionStatus.isGranted) {
      // Select Image
      image = await _imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // Upload to Firebase
        var file = File(image.path);
        var snapshot = await _firebaseStorage.ref()
            .child('$id/default_profile.jpg') // Use the provided id in the image path
            .putFile(file);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Foto berhasil diubah', textAlign: TextAlign.center),
          ),
        );

        var downloadUrl = await snapshot.ref.getDownloadURL();

        imageUrl = downloadUrl;
        UserTest.photoURL = downloadUrl;
      } else {
        print('No Image Path Received');
      }
    } else if (permissionStatus.isDenied) {
      // The user denied the permission, you can request it again or show a prompt
      var secondRequest = await Permission.photos.request();
      if (secondRequest.isGranted) {
        // Permission granted on the second request
        // You can now proceed to select and upload an image
        image = await _imagePicker.pickImage(source: ImageSource.gallery);
        // Continue with image uploading logic...
      } else {
        print('Permission not granted. Try Again with permission access');
      }
    }
  }
}

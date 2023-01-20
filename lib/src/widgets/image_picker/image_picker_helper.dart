import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerHelper {
  static Future<File?> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return null;

      return File(image.path);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }

    return null;
  }

  static Future<File?> takeImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return null;

      return File(image.path);
    } on PlatformException catch (e) {
      print('Failed to take image: $e');
    }

    return null;
  }
}

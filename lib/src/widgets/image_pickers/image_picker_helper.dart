import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerHelper {
  static Future<File?> pickImage(Function() showErrorDialog) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return null;

      return File(image.path);
    } on PlatformException catch (_) {
      showErrorDialog();
    }

    return null;
  }

  static Future<File?> takeImage(Function() showErrorDialog) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return null;

      return File(image.path);
    } on PlatformException catch (_) {
      showErrorDialog();
    }

    return null;
  }
}

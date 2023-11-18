import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerService {
  Future<File?> pickImage(ImageSource source) async {
    File? imageFile;
    try {
      final XFile? image = await ImagePicker().pickImage(source: source, imageQuality: 100, maxWidth: 600, maxHeight: 600);

      if (image != null) {
        imageFile = File(image.path);
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }

    return imageFile;
  }
}

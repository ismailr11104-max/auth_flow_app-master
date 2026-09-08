import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourcePicker {
  static final ImagePicker _picker = ImagePicker();

  static Future<void> show(
    BuildContext context, {
    required Function(String filePath) onImageSelected,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                  );
                  if (image != null) {
                    onImageSelected(image.path);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                  );
                  if (image != null) {
                    onImageSelected(image.path);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

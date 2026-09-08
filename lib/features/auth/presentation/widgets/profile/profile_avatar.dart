import 'dart:io';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? selectedImagePath;
  final String? currentPhotoUrl;
  final bool isLoading;
  final VoidCallback onCameraPressed;

  const ProfileAvatar({
    super.key,
    this.selectedImagePath,
    this.currentPhotoUrl,
    required this.isLoading,
    required this.onCameraPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey[200],
          backgroundImage: selectedImagePath != null
              ? FileImage(File(selectedImagePath!)) as ImageProvider
              : (currentPhotoUrl != null && currentPhotoUrl!.isNotEmpty
                  ? NetworkImage(currentPhotoUrl!) as ImageProvider
                  : null),
          child: (selectedImagePath == null &&
                  (currentPhotoUrl == null || currentPhotoUrl!.isEmpty))
              ? const Icon(Icons.person, size: 60, color: Colors.grey)
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: 20,
            child: IconButton(
              icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
              onPressed: isLoading ? null : onCameraPressed,
            ),
          ),
        ),
      ],
    );
  }
}

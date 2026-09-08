import 'package:flutter/material.dart';

class ProfileNameField extends StatelessWidget {
  final TextEditingController controller;

  const ProfileNameField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Display Name',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person_outline),
      ),
    );
  }
}

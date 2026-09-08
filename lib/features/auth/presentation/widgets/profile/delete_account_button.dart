import 'package:flutter/material.dart';

class DeleteAccountButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const DeleteAccountButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        onPressed: isLoading ? null : onPressed,
        icon: const Icon(Icons.delete_forever),
        label: const Text('Delete Account', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

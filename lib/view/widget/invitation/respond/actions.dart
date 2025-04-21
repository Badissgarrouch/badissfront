import 'package:flutter/material.dart';

class RespondActions extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const RespondActions({
    super.key,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.check, size: 24),
            label: const Text(
              "Accepter l'invitation",
              style: TextStyle(fontSize: 16),
            ),
            onPressed: onAccept,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey,
              side: const BorderSide(color: Colors.grey),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.close, size: 24),
            label: const Text(
              "Refuser l'invitation",
              style: TextStyle(fontSize: 16),
            ),
            onPressed: onReject,
          ),
        ),
      ],
    );
  }
}
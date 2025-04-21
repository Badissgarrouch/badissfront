import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../conroller/invitation/send_controller.dart';
class SendActions extends StatelessWidget {
  final VoidCallback onSend;
  final VoidCallback onCancel;
  final bool hasSentInvitation;
  final bool isLoading;

  const SendActions({
    super.key,
    required this.onSend,
    required this.onCancel,
    required this.hasSentInvitation,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isLoading)
          const CircularProgressIndicator()
        else if (hasSentInvitation)
          ElevatedButton.icon(
            onPressed: onCancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.delete),
            label: const Text("Supprimer l'invitation"),
          )
        else
          ElevatedButton.icon(
            onPressed: onSend,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.send),
            label: const Text("Envoyer l'invitation"),
          ),
      ],
    );
  }
}

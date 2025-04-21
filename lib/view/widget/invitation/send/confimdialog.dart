import 'package:flutter/material.dart';

void showSendConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirmer l'envoi"),
      content: const Text("Voulez-vous envoyer une invitation à ce commerçant ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annuler"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: const Text("Confirmer"),
        ),
      ],
    ),
  );
}

void showDeleteConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Supprimer l'invitation"),
      content: const Text("Voulez-vous supprimer l'invitation envoyée à ce commerçant ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annuler"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: const Text("Supprimer"),
        ),
      ],
    ),
  );
}
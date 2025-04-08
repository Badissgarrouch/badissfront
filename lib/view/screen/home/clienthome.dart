import 'package:flutter/material.dart';

class Clienthome extends StatelessWidget {
  const Clienthome({super.key});

  // Fonction pour envoyer l'invitation
  void _sendInvitation(BuildContext context) {
    // Afficher un snackbar pour confirmer l'envoi
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invitation envoyée avec succès!'),
        duration: Duration(seconds: 2),
      ),
    );

    // Ici vous pourriez ajouter la vraie logique d'envoi
    // Par exemple: appel API, partage via intent, etc.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to home',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20), // Espacement
            ElevatedButton(
              onPressed: () => _sendInvitation(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                'Envoyer invitation',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
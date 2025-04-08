import 'package:flutter/material.dart';

class CustomerButton extends StatelessWidget {
  final String textButton;
  final void Function()? onPressed;

  const CustomerButton({
    super.key,
    required this.textButton,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 12), // Espacement ajusté
        color: Colors.lightBlueAccent,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Coins arrondis
        ),
        onPressed: onPressed,
        child: Text(
          textButton,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}

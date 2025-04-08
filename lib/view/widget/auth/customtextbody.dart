import 'package:flutter/material.dart';

class Customtextbody extends StatelessWidget {
  final String text;

  const Customtextbody({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15, color: Colors.grey),
      ),
    );
  }
}

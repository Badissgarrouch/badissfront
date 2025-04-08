import 'package:flutter/material.dart';

class Customtexttitle extends StatelessWidget {
  final String text;

  const Customtexttitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 27,
      ),
    );
  }
}

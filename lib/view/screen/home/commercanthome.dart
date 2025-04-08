import 'package:flutter/material.dart';

class Commercanthome extends StatelessWidget {
  const Commercanthome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text(
          'Welcome to home',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
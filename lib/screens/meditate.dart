import 'package:flutter/material.dart';

class Meditate extends StatelessWidget {
  const Meditate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/breathe.gif',
          width: 700,
          height: 700,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
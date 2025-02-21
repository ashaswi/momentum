import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  //const BaseScreen({super.key, required this.child});
  final bool hasPadding;
  const BaseScreen({super.key, required this.child, this.hasPadding = true});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: Container(
        height: double.infinity,
        color: Colors.white,
        child: child,
      )),
    );
  }
}
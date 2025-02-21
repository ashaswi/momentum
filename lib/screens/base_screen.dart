import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final bool hasPadding;
  const BaseScreen({super.key, required this.child, this.hasPadding = true});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: Container(
        padding: hasPadding ?  const EdgeInsets.all(20) : null,
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: child,
      )),
    );
  }
}
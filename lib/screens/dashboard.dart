import 'package:flutter/material.dart';
import 'package:momentum/Screens/base_screen.dart';
//import 'package:momentum/components/curved_curtain.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return const BaseScreen(child: Center(child: Text("Welcome to dashboard", style: TextStyle(fontSize: 20),)));
  }
}

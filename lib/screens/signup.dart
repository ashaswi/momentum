import 'package:flutter/material.dart';
import 'package:momentum/Screens/base_screen.dart';
import 'package:momentum/components/curved_curtain.dart';
import 'package:momentum/forms/signup_form.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hasPadding: false,
      child: Stack(
        children: [
          Positioned(
              top: 200,
              left: 30,
              child: Container(
                width: MediaQuery.of(context).size.width -70,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign up',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SignupForm(),
                  ],
                ),
              )),
          Positioned(
            top: -300,
            child: Transform.scale(scale: 1.1, child: const CurvedCurtain())),
        ],
      ),
    );
  }
}
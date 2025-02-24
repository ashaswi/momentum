import 'package:flutter/material.dart';
import 'package:momentum/Screens/base_screen.dart';
//import 'package:momentum/components/curved_curtain.dart';
import 'package:momentum/forms/forgot_password_form.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hasPadding: false,
      child: Stack(
        children: [
          Positioned(
              top: 220,
              left: 30,
              child: Container(
                width: MediaQuery.of(context).size.width -70,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reset',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const ForgotPasswordForm(),
                  ],
                ),
              )),
          // Positioned(
            // top: -300,
            // child: Transform.scale(scale: 1.1, child: const CurvedCurtain())),
        ],
      ),
    );
  }
}
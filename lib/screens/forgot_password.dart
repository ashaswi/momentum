import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:momentum/Screens/base_screen.dart';
import 'package:momentum/components/curved_curtain.dart';
import 'package:momentum/forms/forgot_password_form.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hasPadding: false,
      child: Stack(
        children: [
                 // Add the SVG in the desired position
          Positioned(
            top: -90,
            left: -10,
            right: -10,
            child: SvgPicture.asset(
              'assets/images/gradient/Gradient.svg',
              fit: BoxFit.cover,
              height: 600, // Adjust height based on the desired size
            ),
          ),
          Positioned(
              top: 220,
              left: 30,
              child: Container(
                width: MediaQuery.of(context).size.width -70,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      const Text(
                      'Reset',
                      style: TextStyle(fontSize: 38, color: Color(0xFF424242), fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                    ),
                       const SizedBox(height: 16), // Add spacing
                    SvgPicture.asset(
                    'assets/images/icons/line_icon.svg',
                      width: 80,  // Adjust width as needed
                     ),
                    const SizedBox(height: 16),
                    const ForgotPasswordForm(),
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
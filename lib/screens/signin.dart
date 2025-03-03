import 'package:flutter/material.dart';
import 'package:momentum/Screens/base_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:momentum/components/curved_curtain.dart';
import 'package:momentum/forms/signin_form.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hasPadding: false,
      child: Stack(
        children: [
           // Add the SVG in the desired position
          Positioned(
            top: -200,
            left: -10,
            right: -10,
            child: SvgPicture.asset(
              'assets/images/gradient/Gradient.svg',
              fit: BoxFit.cover,
              height: 500, // Adjust height based on the desired size
            ),
          ),
          Positioned(
              top: 270,
              left: 30,
              child: Container(
                width: MediaQuery.of(context).size.width -70,
               // color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 38, color: Color(0xFF424242), fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                    ),
                    const SizedBox(height: 16), // Add spacing
                    SvgPicture.asset(
                    'assets/images/icons/line_icon.svg',
                      width: 80,  // Adjust width as needed
                     ),
                    const SizedBox(height: 16), // Add spacing before the form
                    SigninForm(),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:momentum/Screens/base_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:momentum/components/curved_curtain.dart';
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
            top: -100,
            left: -10,
            right: -10,
            child: SvgPicture.asset(
              'assets/images/gradient/Gradient.svg',
              fit: BoxFit.cover,
              height: 500, // Adjust height based on the desired size
            ),
          ),
          Positioned(
              top: 350,
              left: 30,
              child: Container(
                width: MediaQuery.of(context).size.width -70,
               // color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    SigninForm(),
                  ],
                ),
              )),
          Transform.scale(scale: 1.1, child: const CurvedCurtain()),
        ],
      ),
    );
  }
}

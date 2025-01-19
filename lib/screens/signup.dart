import 'package:flutter/material.dart';
import 'package:momentum/Screens/base_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:momentum/components/ContinueButton.dart';
//import 'package:momentum/components/curved_curtain.dart';
import 'package:momentum/forms/signup_form.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        children: [
           // Adding the SVG in the desired position
          Positioned(
            top: -200, 
            left: -10,
            right: -10, 
            child: SvgPicture.asset(
              'assets/images/gradient/Gradient.svg',
              fit: BoxFit.cover,
              height: 500, // Adjusting height based on the desired size
            ),
          ),
          Positioned(
              top: 350,
              left: 30,
              child: Container(
                width: MediaQuery.of(context).size.width -70,
             //color: Colors.white,
                height: MediaQuery.of(context).size.height - 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SignupForm(),
                    // Text(
                    //   'Lorem ipsum dolor sit amet consectetur. Lorem id sit ',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     color: Colors.grey.withOpacity(0.5),
                    //   ),
                    // )
                  ],
                ),
              )),
          //Transform.scale(scale: 1.1, child: CurvedCurtain()),
          // add the floating action button on bottom right
          /*const Positioned(
            bottom: 40,
            right: 20,
            child: ContinueButton() 
          ),*/
        ],
      ),
    );
  }
}


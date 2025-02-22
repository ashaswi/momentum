import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:momentum/screens/base_screen.dart';
import 'package:momentum/components/ContinueButton.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hasPadding: false,
      child: Stack(
        children: [
          // Add the SVG in the desired position
          Positioned(
            top: -10,
            left: -10,
            right: -10,
            child: SvgPicture.asset(
              'assets/images/gradient/Gradient.svg',
              fit: BoxFit.cover,
              height: 500, // Adjust height based on the desired size
            ),
          ),
          Positioned(
              top: 480,
              left: 30,
              child: Container(
                width: MediaQuery.of(context).size.width - 100,
                //color: Colors.white,
                height: MediaQuery.of(context).size.height - 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Lorem ipsum dolor sit amet consectetur. Lorem id sit ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    )
                  ],
                ),
              )),
          // Add the floating action button on the bottom right
          const Positioned(
            bottom: 40,
            right: 20,
            child: ContinueButton(route: '/signin'),
          ),
        ],
      ),
    );
  }
}

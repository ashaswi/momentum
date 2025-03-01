import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Meditate extends StatefulWidget {
  const Meditate({super.key});

  @override
  _MeditateState createState() => _MeditateState();
}

class _MeditateState extends State<Meditate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/icons/background_elements.svg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/breathe.gif',
              width: 500,
              height: 500,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

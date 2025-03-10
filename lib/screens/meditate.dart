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
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF371B34)), 
          onPressed: () {
            Navigator.pushNamed(context, '/dashboard'); 
          },
        ),
        title: const Text(
          'Meditation',
          style: TextStyle(
            color: Color(0xFF371B34), 
          ),
        ),
      ),
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

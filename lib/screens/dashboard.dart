import 'package:flutter/material.dart';
import 'package:momentum/Screens/base_screen.dart';
//import 'package:momentum/components/curved_curtain.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        children: [
          Positioned(
              top: 350,
              left: 30,
              child: Container(
                width: MediaQuery.of(context).size.width -70,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
              )),
          //Transform.scale(scale: 1.1, child: const CurvedCurtain(height: 600,)),
        ],
      ),
    );
  }
}

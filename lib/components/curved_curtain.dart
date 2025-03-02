import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CurvedCurtain extends StatelessWidget {
  const CurvedCurtain({super.key});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/gradient/Gradient.svg',
);
}
}
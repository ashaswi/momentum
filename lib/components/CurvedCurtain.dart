/*import 'package:flutter/material.dart';

class CurvedCurtain extends StatelessWidget {
  final int height;
  const CurvedCurtain({super.key,this.height = 700 });
  @override
  Widget build(BuildContext context) {
    return ClipPath(
          clipper:  MyClipper(),
          child:  BlueBox(height: height),
        );
  }
  
}
class BlueBox extends StatelessWidget {
  final int height;
  const BlueBox({
    super.key,
    this.height = 700,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.toDouble(),
      

      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Color(0xFF7140FC),
            Color(0xFF7E67C1)
        ]),
      ),
      child: Center(
        child: Text(
          '',
          style: Theme.of(context).textTheme.headlineLarge, // Use default theme style
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  const MyClipper();

  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 896;
    path.lineTo(112.935 * _xScaling,456.798 * _yScaling);
    path.cubicTo(73.1093 * _xScaling,452.667 * _yScaling,11 * _xScaling,467.727 * _yScaling,11 * _xScaling,467.727 * _yScaling,);
    path.cubicTo(11 * _xScaling,467.727 * _yScaling,11 * _xScaling,7 * _yScaling,11 * _xScaling,7 * _yScaling,);
    path.cubicTo(11 * _xScaling,7 * _yScaling,447.707 * _xScaling,7 * _yScaling,447.707 * _xScaling,7 * _yScaling,);
    path.cubicTo(447.707 * _xScaling,7 * _yScaling,447.707 * _xScaling,535.599 * _yScaling,447.707 * _xScaling,535.599 * _yScaling,);
    path.cubicTo(447.707 * _xScaling,535.599 * _yScaling,422.75 * _xScaling,546.525 * _yScaling,405.93 * _xScaling,550.554 * _yScaling,);
    path.cubicTo(369.906 * _xScaling,559.185 * _yScaling,347.275 * _xScaling,559.112 * _yScaling,311.236 * _xScaling,550.554 * _yScaling,);
    path.cubicTo(262.77 * _xScaling,539.046 * _yScaling,244.355 * _xScaling,509 * _yScaling,201.502 * _xScaling,483.832 * _yScaling,);
    path.cubicTo(170.614 * _xScaling,465.692 * _yScaling,149.218 * _xScaling,460.562 * _yScaling,112.935 * _xScaling,456.798 * _yScaling,);
    path.cubicTo(112.935 * _xScaling,456.798 * _yScaling,112.935 * _xScaling,456.798 * _yScaling,112.935 * _xScaling,456.798 * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}*/
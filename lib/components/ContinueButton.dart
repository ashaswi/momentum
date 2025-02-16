import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContinueButton extends StatelessWidget{
  // const ContinueButton({super.key});
  final String route;
  const ContinueButton({super.key,required this.route});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      //onTap: () => Navigator.pushNamed(context, '/signup'),
      onTap: () => Navigator.pushNamed(context, route),
      child: Row(
        children: [
          Text('Continue', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(width: 10),
          SvgPicture.asset('assets/images/icons/arrow_icon.svg'),
          ],
          ),
     );
  }
}
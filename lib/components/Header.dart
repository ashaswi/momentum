import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(
      {super.key, required this.primayHeaderText, this.secondaryHeaderText});
  final String primayHeaderText;
  final String? secondaryHeaderText;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
        primayHeaderText,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      if (secondaryHeaderText != null)
        Text(
          secondaryHeaderText!,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
    ]);
  }
}
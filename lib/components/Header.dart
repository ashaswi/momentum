import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.primayHeaderText,
    this.secondaryHeaderText,
    this.secondaryTextSize = 14, // Default value
  });

  final String primayHeaderText;
  final String? secondaryHeaderText;
  final double secondaryTextSize; // Added parameter

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          primayHeaderText,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: const Color(0xFF371B34),
              ),
        ),
        if (secondaryHeaderText != null)
          Text(
            secondaryHeaderText!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF371B34),
                  fontSize: secondaryTextSize,
                  fontWeight: FontWeight.bold,
                ),
          ),
      ],
    );
  }
}

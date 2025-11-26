import 'package:flutter/material.dart';
import 'package:project_strava/theme/dark_theme.dart';

class BrandHeading extends StatelessWidget {
  const BrandHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'STRAVA',
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
        color: DarkTheme.textPrimary,
        fontWeight: FontWeight.w800,
        letterSpacing: 6,
      ),
      textAlign: TextAlign.center,
    );
  }
}

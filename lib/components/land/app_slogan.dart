import 'package:flutter/material.dart';
import '../language/app_localizations.dart';
import 'package:project_strava/theme/dark_theme.dart';

class AppSlogan extends StatelessWidget {
  const AppSlogan({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Text(
      t.slogan,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: DarkTheme.textPrimary,
        height: 1.3,
      ),
      textAlign: TextAlign.center,
    );
  }
}

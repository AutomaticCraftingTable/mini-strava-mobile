import 'package:flutter/material.dart';
import '../../theme/dark_theme.dart';
import '../language/app_localizations.dart';

class AuthDisclaimer extends StatelessWidget {
  const AuthDisclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Text(
      t.authDisclaimer,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: DarkTheme.textSecondary,
        fontSize: 12,
      ),
    );
  }
}

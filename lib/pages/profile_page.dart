import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/profile/profile_form.dart';
import '../theme/dark_theme.dart';
import '../components/language/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: DarkTheme.primary,

      appBar: Header(title: t.navYou),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: const ProfileForm(),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_strava/theme/dark_theme.dart';
import '../../components/language/app_localizations.dart';
import '../../components/auth/primary_button.dart';
import '../../components/land/app_slogan.dart';
import '../../components/land/brand_heading.dart';
import '../../components/land/secondary_text_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});


  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: DarkTheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              const BrandHeading(),

              const Spacer(),

              const AppSlogan(),
              const SizedBox(height: 32),

              PrimaryButton(
                onPressed: () => context.go('/signup'),
                label: t.joinFree,
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: SecondaryTextButton(
                  onPressed: () => context.go('/login'),
                  label: t.login,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

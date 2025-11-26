import 'package:flutter/material.dart';
import 'package:project_strava/theme/dark_theme.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    super.key,
    required this.title,
    required this.children,
    this.bottom,
  });

  final String title;
  final List<Widget> children;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkTheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: DarkTheme.hintColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 24),
              ...children,
              const SizedBox(height: 16),
              if (bottom != null) bottom!,
            ],
          ),
        ),
      ),
    );
  }
}

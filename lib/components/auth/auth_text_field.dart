import 'package:flutter/material.dart';
import 'package:project_strava/theme/dark_theme.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.autofillHints,
    this.textInputAction,
    this.validator,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;

  InputDecoration _decoration(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: DarkTheme.fillColor,
    hintStyle: const TextStyle(color: DarkTheme.hintColor),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: DarkTheme.textPrimary),
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      textInputAction: textInputAction,
      decoration: _decoration(hint),
      validator: validator,
      onFieldSubmitted: onSubmitted,
    );
  }
}

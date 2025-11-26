import 'package:flutter/material.dart';
import 'package:project_strava/theme/dark_theme.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.hint,
    this.autofillHints = const [AutofillHints.password],
    this.textInputAction,
    this.validator,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String hint;
  final List<String> autofillHints;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

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
    suffixIcon: IconButton(
      icon: Icon(
        _obscure ? Icons.visibility : Icons.visibility_off,
        color: DarkTheme.textDimmed,
      ),
      onPressed: () => setState(() => _obscure = !_obscure),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(color: DarkTheme.textPrimary),
      obscureText: _obscure,
      autofillHints: widget.autofillHints,
      textInputAction: widget.textInputAction,
      decoration: _decoration(widget.hint),
      validator: widget.validator,
      onFieldSubmitted: widget.onSubmitted,
    );
  }
}

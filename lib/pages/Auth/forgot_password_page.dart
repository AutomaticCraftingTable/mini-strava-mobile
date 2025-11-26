import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/auth/auth_screen.dart';
import '../../components/auth/auth_text_field.dart';
import '../../components/auth/primary_button.dart';
import '../../components/language/app_localizations.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  String? _validateEmail(String? v) {
    final t = AppLocalizations.of(context);
    final s = v?.trim() ?? '';
    if (s.isEmpty) return t.authErrorEmailRequired;
    if (!s.contains('@')) return t.authErrorEmailInvalid;
    return null;
  }

  Future<void> _sendReset() async {
    if (!_formKey.currentState!.validate()) return;

    final t = AppLocalizations.of(context);

    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${t.authResetSentTo} ${_email.text.trim()}',
        ),
      ),
    );

    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return AuthScreen(
      title: t.authForgotTitle,
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTextField(
                controller: _email,
                hint: t.authEmail,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.done,
                validator: _validateEmail,
                onSubmitted: (_) => _sendReset(),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                onPressed: _loading ? null : _sendReset,
                label: t.authSendReset,
                loading: _loading,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

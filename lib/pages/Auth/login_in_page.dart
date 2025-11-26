import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/auth/auth_screen.dart';
import '../../components/auth/auth_text_field.dart';
import '../../components/auth/password_field.dart';
import '../../components/auth/primary_button.dart';
import '../../components/language/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => _loading = false);

    final t = AppLocalizations.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.authLoginSuccess)),
    );

    context.go('/main');
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return AuthScreen(
      title: t.authLoginTitle,
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              AuthTextField(
                controller: _email,
                hint: t.authEmail,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.next,
                validator: (v) {
                  final s = v?.trim() ?? '';
                  if (s.isEmpty) return t.authErrorEmailRequired;
                  if (!s.contains('@')) return t.authErrorEmailInvalid;
                  return null;
                },
              ),
              const SizedBox(height: 14),
              PasswordField(
                controller: _password,
                hint: t.authPassword,
                textInputAction: TextInputAction.done,
                validator: (v) {
                  final s = v ?? '';
                  if (s.isEmpty) return t.authErrorPasswordRequired;
                  if (s.length < 6) return t.authErrorPasswordShort;
                  return null;
                },
                onSubmitted: (_) => _onLogin(),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.go('/forgot'),
                  child: Text(t.authForgotPassword),
                ),
              ),

              const SizedBox(height: 8),
              const SizedBox(height: 20),
              PrimaryButton(
                onPressed: _loading ? null : _onLogin,
                label: t.login,
                loading: _loading,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

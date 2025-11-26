import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_strava/theme/dark_theme.dart';
import '../../components/auth/auth_disclaimer.dart';
import '../../components/auth/auth_screen.dart';
import '../../components/auth/auth_text_field.dart';
import '../../components/auth/password_field.dart';
import '../../components/auth/primary_button.dart';
import '../../components/language/app_localizations.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _onSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => _loading = false);

    final t = AppLocalizations.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.authSignupSuccess)),
    );

    context.go('/main');
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return AuthScreen(
      title: t.authCreateAccount,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
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
                autofillHints: const [AutofillHints.newPassword],
                textInputAction: TextInputAction.next,
                validator: (v) {
                  final s = v ?? '';
                  if (s.isEmpty) return t.authErrorPasswordRequired;
                  if (s.length < 6) return t.authErrorPasswordShort;
                  return null;
                },
              ),
              const SizedBox(height: 14),
              PasswordField(
                controller: _confirm,
                hint: t.authRepeatPassword,
                autofillHints: const [AutofillHints.newPassword],
                textInputAction: TextInputAction.done,
                validator: (v) {
                  final s = v ?? '';
                  if (s.isEmpty) return t.authErrorPasswordRepeatRequired;
                  if (s != _password.text) return t.authErrorPasswordMismatch;
                  return null;
                },
                onSubmitted: (_) => _onSignUp(),
              ),
              const SizedBox(height: 30),

              const AuthDisclaimer(),

              const SizedBox(height: 30),

              PrimaryButton(
                onPressed: _loading ? null : _onSignUp,
                label: t.authSignUp,
                loading: _loading,
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t.authAlreadyHaveAccount,
                    style: const TextStyle(
                      color: DarkTheme.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/login'),
                    child: Text(
                      t.login,
                      style: const TextStyle(
                        color: DarkTheme.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

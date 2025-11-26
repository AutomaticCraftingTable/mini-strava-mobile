import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/dark_theme.dart';
import '../../../models/user_profile.dart';
import '../language/app_localizations.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  static const double _kFieldHeight = 56;
  static const double _kGap = 16;

  final _formKey = GlobalKey<FormState>();
  final repo = UserProfileRepo.instance;

  late final TextEditingController _first =
  TextEditingController(text: repo.current.firstName ?? '');
  late final TextEditingController _last =
  TextEditingController(text: repo.current.lastName ?? '');
  late final TextEditingController _height =
  TextEditingController(
      text: repo.current.heightCm?.toStringAsFixed(0) ?? '');
  late final TextEditingController _weight =
  TextEditingController(
      text: repo.current.weightKg?.toStringAsFixed(1) ?? '');

  String? _gender = UserProfileRepo.instance.current.gender; // 'male'|'female'|'other'
  DateTime? _birth = UserProfileRepo.instance.current.birthDate;

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }

  InputDecoration _dec(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: DarkTheme.primaryHover,
    hintStyle: const TextStyle(
      color: DarkTheme.hintColor,
      fontSize: 14,
    ),
    isDense: false,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide:
      BorderSide(color: DarkTheme.textPrimary.withOpacity(0.08)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide:
      const BorderSide(color: DarkTheme.secondary, width: 1.4),
    ),
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
  );

  Future<void> _pickBirth() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: _birth ?? DateTime(now.year - 20, 1, 1),
      firstDate: DateTime(1900, 1, 1),
      lastDate: now,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          dialogBackgroundColor: DarkTheme.primary,
          colorScheme: const ColorScheme.dark(
            primary: DarkTheme.secondary,
            surface: DarkTheme.primary,
            onSurface: DarkTheme.textPrimary,
          ),
        ),
        child: child!,
      ),
    );
    if (d != null) setState(() => _birth = d);
  }

  String _birthLabel(AppLocalizations t) {
    if (_birth == null) return t.profileBirthNotSet;
    return '${_birth!.day.toString().padLeft(2, '0')}.'
        '${_birth!.month.toString().padLeft(2, '0')}.'
        '${_birth!.year}';
  }

  void _save() {
    final t = AppLocalizations.of(context);

    if (!_formKey.currentState!.validate()) return;

    final h = _height.text.trim().isEmpty
        ? null
        : double.tryParse(
      _height.text.trim().replaceAll(',', '.'),
    );
    final w = _weight.text.trim().isEmpty
        ? null
        : double.tryParse(
      _weight.text.trim().replaceAll(',', '.'),
    );

    repo.current = repo.current.copyWith(
      firstName: _first.text.trim(),
      lastName: _last.text.trim(),
      birthDate: _birth,
      gender: _gender,
      heightCm: h,
      weightKg: w,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.profileSaved)),
    );

    if (context.mounted && context.canPop()) {
      context.pop();
    } else {
      context.go('/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 520;

        return Form(
          key: _formKey,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 44,
                backgroundColor: DarkTheme.primaryPressed,
                child: Icon(
                  Icons.person_outline,
                  size: 44,
                  color: DarkTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 20),

              if (isWide) ...[
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: _kFieldHeight,
                        child: TextFormField(
                          controller: _first,
                          decoration: _dec(t.profileFirstName),
                          style: const TextStyle(
                            color: DarkTheme.textPrimary,
                            fontSize: 16,
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? t.profileRequired
                              : null,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    const SizedBox(width: _kGap),
                    Expanded(
                      child: SizedBox(
                        height: _kFieldHeight,
                        child: TextFormField(
                          controller: _last,
                          decoration: _dec(t.profileLastName),
                          style: const TextStyle(
                            color: DarkTheme.textPrimary,
                            fontSize: 16,
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? t.profileRequired
                              : null,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                SizedBox(
                  height: _kFieldHeight,
                  child: TextFormField(
                    controller: _first,
                    decoration: _dec(t.profileFirstName),
                    style: const TextStyle(
                      color: DarkTheme.textPrimary,
                      fontSize: 16,
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? t.profileRequired
                        : null,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height: _kGap),
                SizedBox(
                  height: _kFieldHeight,
                  child: TextFormField(
                    controller: _last,
                    decoration: _dec(t.profileLastName),
                    style: const TextStyle(
                      color: DarkTheme.textPrimary,
                      fontSize: 16,
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? t.profileRequired
                        : null,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
              const SizedBox(height: _kGap),

              SizedBox(
                height: _kFieldHeight,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: _pickBirth,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: DarkTheme.primaryHover,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: DarkTheme.textPrimary.withOpacity(0.08),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              t.profileBirthDate,
                              style: const TextStyle(
                                color: DarkTheme.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            _birthLabel(t),
                            style: const TextStyle(
                              color: DarkTheme.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.calendar_month,
                            color: DarkTheme.textPrimary,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: _kGap),

              SizedBox(
                height: _kFieldHeight,
                child: DropdownButtonFormField<String>(
                  value: _gender,
                  items: [
                    DropdownMenuItem(
                      value: 'male',
                      child: Text(t.profileGenderMale),
                    ),
                    DropdownMenuItem(
                      value: 'female',
                      child: Text(t.profileGenderFemale),
                    ),
                    DropdownMenuItem(
                      value: 'other',
                      child: Text(t.profileGenderOther),
                    ),
                  ],
                  onChanged: (v) => setState(() => _gender = v),
                  decoration: _dec(t.profileGender),
                  dropdownColor: DarkTheme.primaryHover,
                  style: const TextStyle(
                    color: DarkTheme.textPrimary,
                    fontSize: 16,
                  ),
                  iconEnabledColor: DarkTheme.textPrimary,
                ),
              ),
              const SizedBox(height: _kGap),

              if (isWide) ...[
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: _kFieldHeight,
                        child: TextFormField(
                          controller: _height,
                          keyboardType: TextInputType.number,
                          decoration: _dec(t.profileHeight),
                          style: const TextStyle(
                            color: DarkTheme.textPrimary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: _kGap),
                    Expanded(
                      child: SizedBox(
                        height: _kFieldHeight,
                        child: TextFormField(
                          controller: _weight,
                          keyboardType:
                          const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: _dec(t.profileWeight),
                          style: const TextStyle(
                            color: DarkTheme.textPrimary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                SizedBox(
                  height: _kFieldHeight,
                  child: TextFormField(
                    controller: _height,
                    keyboardType: TextInputType.number,
                    decoration: _dec(t.profileHeight),
                    style: const TextStyle(
                      color: DarkTheme.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: _kGap),
                SizedBox(
                  height: _kFieldHeight,
                  child: TextFormField(
                    controller: _weight,
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    decoration: _dec(t.profileWeight),
                    style: const TextStyle(
                      color: DarkTheme.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DarkTheme.secondary,
                    foregroundColor: DarkTheme.textPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  child: Text(t.profileSave),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

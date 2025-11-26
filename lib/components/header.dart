import 'package:flutter/material.dart';
import '../theme/dark_theme.dart';
import 'language/language_controller.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onProfileTap;

  const Header({
    super.key,
    required this.title,
    this.onProfileTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: DarkTheme.primary,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: kToolbarHeight,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: DarkTheme.textPrimary.withOpacity(0.10),
                width: 0.6,
              ),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                    color: DarkTheme.textPrimary,
                  ),
                ),
              ),

              Positioned(
                left: 4,
                top: 0,
                bottom: 0,
                child: _ProfileIcon(onTap: onProfileTap),
              ),

              const Positioned(
                right: 6,
                top: 0,
                bottom: 0,
                child: _LanguageToggleButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileIcon extends StatelessWidget {
  final VoidCallback? onTap;
  const _ProfileIcon({this.onTap});

  @override
  Widget build(BuildContext context) {
    final icon = const Icon(
      Icons.person_outline,
      size: 26,
      color: DarkTheme.textPrimary,
    );

    if (onTap == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: icon,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: Icon(Icons.person_outline,
                size: 26, color: DarkTheme.textPrimary),
          ),
        ),
      ),
    );
  }
}

class _LanguageToggleButton extends StatelessWidget {
  const _LanguageToggleButton();

  @override
  Widget build(BuildContext context) {
    final isPl = LanguageController.instance.locale.languageCode == 'pl';

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => LanguageController.instance.toggleLanguage(),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: DarkTheme.primaryHover,
          shape: BoxShape.circle,
          border: Border.all(
            color: DarkTheme.textPrimary.withOpacity(0.18),
          ),
        ),
        child: Center(
          child: Icon(
            Icons.language_rounded,
            color: DarkTheme.textPrimary,
            size: 18,
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../theme/dark_theme.dart';
import 'language/app_localizations.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Theme(
      data: Theme.of(context).copyWith(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: DarkTheme.primary,
          selectedItemColor: DarkTheme.secondary,
          unselectedItemColor: DarkTheme.textPrimary,
          selectedIconTheme: IconThemeData(size: 26),
          unselectedIconTheme: IconThemeData(size: 26),
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(LucideIcons.circle),
            label: t.navRecord,
          ),
          BottomNavigationBarItem(
            icon: const Icon(LucideIcons.book),
            label: t.navHistory,
          ),
          BottomNavigationBarItem(
            icon: const Icon(LucideIcons.users),
            label: t.ratingWeeklyTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(LucideIcons.user),
            label: t.navYou,
          ),
        ],
      ),
    );
  }
}

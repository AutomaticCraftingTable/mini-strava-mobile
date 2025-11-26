import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/header.dart';
import '../components/custom_bottom_nav_bar.dart';
import 'language/app_localizations.dart';
import '../pages/record_page.dart';
import '../pages/history_page.dart';
import '../pages/rating_page.dart';
import '../pages/you_page.dart';
import '../theme/dark_theme.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final String title = switch (index) {
      0 => t.navRecord,
      1 => t.navHistory,
      2 => t.ratingWeeklyTitle,
      _ => t.navYou,
    };

    return Scaffold(
      backgroundColor: DarkTheme.primary,
      appBar: Header(
        title: title,
        onProfileTap: () => context.push('/profile'),
      ),
      body: IndexedStack(
        index: index,
        children: const [
          RecordPage(),
          HistoryPage(),
          RatingPage(),
          YouPage(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/dark_theme.dart';
import '../../models/activity.dart';
import '../components/language/app_localizations.dart';
import '../components/rating/leaderboard.dart';
import '../components/rating/weekly_distance_card.dart';


class RatingPage extends StatelessWidget {
  const RatingPage({super.key});

  double _computeWeeklyDistanceKm(List<Activity> activities) {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));

    double totalKm = 0;
    for (final a in activities) {
      if (a.start.isAfter(weekAgo)) {
        totalKm += a.distanceKm;
      }
    }
    return totalKm;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return AnimatedBuilder(
      animation: ActivityRepo.instance,
      builder: (context, _) {
        final activities = ActivityRepo.instance.activities;
        final myWeeklyKm = _computeWeeklyDistanceKm(activities);

        final List<LeaderboardEntry> entries = [
          LeaderboardEntry(
            name: t.navYou,
            distanceKm: myWeeklyKm,
            isCurrentUser: true,
          ),
          const LeaderboardEntry(name: 'Alex', distanceKm: 32.4),
          const LeaderboardEntry(name: 'Marta', distanceKm: 18.7),
          const LeaderboardEntry(name: 'Kamil', distanceKm: 12.3),
          const LeaderboardEntry(name: 'Sara', distanceKm: 7.9),
        ];

        entries.sort((a, b) => b.distanceKm.compareTo(a.distanceKm));

        return Container(
          color: DarkTheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              Text(
                t.ratingWeeklyTitle,
                style: const TextStyle(
                  color: DarkTheme.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),

              Text(
                t.ratingWeeklySub,
                style: const TextStyle(
                  color: DarkTheme.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),

              WeeklyDistanceCard(weeklyKm: myWeeklyKm),

              const SizedBox(height: 20),

              Text(
                t.ratingTableTitle,
                style: const TextStyle(
                  color: DarkTheme.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: entries.isEmpty
                    ? Center(
                  child: Text(
                    t.ratingNoData,
                    style: const TextStyle(
                      color: DarkTheme.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                )
                    : LeaderboardList(entries: entries),
              ),
            ],
          ),
        );
      },
    );
  }
}

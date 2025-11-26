// lib/pages/components/weekly_distance_card.dart
import 'package:flutter/material.dart';
import '../../theme/dark_theme.dart';
import '../language/app_localizations.dart';

class WeeklyDistanceCard extends StatelessWidget {
  final double weeklyKm;

  const WeeklyDistanceCard({super.key, required this.weeklyKm});

  String _formatDistance(double km) => km.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: DarkTheme.primaryHover,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: DarkTheme.textPrimary.withOpacity(0.08),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: DarkTheme.secondary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.directions_run_rounded,
              color: DarkTheme.secondary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.ratingYouWeekly,
                  style: const TextStyle(
                    color: DarkTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_formatDistance(weeklyKm)} km',
                  style: const TextStyle(
                    color: DarkTheme.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

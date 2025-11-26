// lib/pages/tabs/you_page.dart
import 'package:flutter/material.dart';
import '../../theme/dark_theme.dart';
import '../../models/activity.dart';
import '../components/language/app_localizations.dart';

class YouPage extends StatelessWidget {
  const YouPage({super.key});

  String _formatDistance(double km) {
    return km.toStringAsFixed(2);
  }

  String _formatSpeed(double kmh) {
    return kmh.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return AnimatedBuilder(
      animation: ActivityRepo.instance,
      builder: (context, _) {
        final activities = ActivityRepo.instance.activities;

        final int count = activities.length;

        double totalDistanceKm = 0;
        int totalSeconds = 0;

        for (final a in activities) {
          totalDistanceKm += a.distanceKm;
          totalSeconds += a.duration.inSeconds;
        }

        final double avgSpeedKmh;
        if (totalSeconds > 0 && totalDistanceKm > 0) {
          final hours = totalSeconds / 3600.0;
          avgSpeedKmh = totalDistanceKm / hours;
        } else {
          avgSpeedKmh = 0;
        }

        return Container(
          color: DarkTheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              Text(
                t.youTitle,
                style: const TextStyle(
                  color: DarkTheme.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),

              Text(
                count > 0
                    ? t.youSubtitleHasData
                    : t.youSubtitleEmpty,
                style: const TextStyle(
                  color: DarkTheme.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: t.youTrainings,
                      value: count.toString(),
                      subtitle: t.totalNumber,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _StatCard(
                      label: t.youDistance,
                      value: '${_formatDistance(totalDistanceKm)} km',
                      subtitle: t.youDistanceSub,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: t.youAvgSpeed,
                      value: '${_formatSpeed(avgSpeedKmh)} km/h',
                      subtitle: t.youAvgSpeedSub,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? subtitle;

  const _StatCard({
    super.key,
    required this.label,
    required this.value,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: DarkTheme.primaryHover,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: DarkTheme.textPrimary.withOpacity(0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: DarkTheme.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: DarkTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: TextStyle(
                color: DarkTheme.textSecondary.withOpacity(0.9),
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

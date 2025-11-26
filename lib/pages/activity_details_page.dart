import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/activity.dart';
import '../../theme/dark_theme.dart';
import '../components/activityDetails/activity_detail_map.dart';
import '../components/activityDetails/activity_stat_block.dart';
import '../components/language/app_localizations.dart';


class ActivityDetailPage extends StatelessWidget {
  final Activity activity;

  const ActivityDetailPage({
    super.key,
    required this.activity,
  });

  String _formatDateTime(DateTime d) {
    return '${d.year.toString().padLeft(4, '0')}-'
        '${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')} '
        '${d.hour.toString().padLeft(2, '0')}:'
        '${d.minute.toString().padLeft(2, '0')}';
  }

  String _formatDuration(Duration dur) {
    final h = dur.inHours;
    final m = dur.inMinutes % 60;
    final s = dur.inSeconds % 60;

    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:'
          '${m.toString().padLeft(2, '0')}:'
          '${s.toString().padLeft(2, '0')}';
    } else {
      return '${m.toString().padLeft(2, '0')}:'
          '${s.toString().padLeft(2, '0')}';
    }
  }

  IconData _iconForType(ActivityType type) {
    switch (type) {
      case ActivityType.run:
        return Icons.directions_run_rounded;
      case ActivityType.ride:
        return Icons.directions_bike_rounded;
      case ActivityType.walk:
        return Icons.directions_walk_rounded;
      default:
        return Icons.fitness_center_rounded;
    }
  }

  String _labelForType(ActivityType type, AppLocalizations t) {
    switch (type) {
      case ActivityType.run:
        return t.filterRun;
      case ActivityType.ride:
        return t.filterRide;
      case ActivityType.walk:
        return t.filterWalk;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final distanceKm = activity.distanceKm;
    final duration = activity.duration;
    final paceLabel = activity.paceLabel;
    final speed = activity.avgSpeedKmh;

    final title = activity.name?.trim().isNotEmpty == true
        ? activity.name!.trim()
        : _labelForType(activity.type, t);

    return Scaffold(
      backgroundColor: DarkTheme.primary,
      appBar: AppBar(
        backgroundColor: DarkTheme.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: DarkTheme.textPrimary),
        title: Text(
          title,
          style: const TextStyle(
            color: DarkTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ActivityDetailMap(path: activity.path),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Заголовок + дата
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor:
                        DarkTheme.secondary.withOpacity(0.2),
                        child: Icon(
                          _iconForType(activity.type),
                          color: DarkTheme.secondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: DarkTheme.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatDateTime(activity.start),
                              style: const TextStyle(
                                color: DarkTheme.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Статистика
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ActivityStatBlock(
                        label: t.recordDistance,
                        value: '${distanceKm.toStringAsFixed(2)} km',
                      ),
                      ActivityStatBlock(
                        label: t.recordDuration,
                        value: _formatDuration(duration),
                      ),
                      ActivityStatBlock(
                        label: t.recordPace,
                        value: '$paceLabel / km',
                      ),
                      ActivityStatBlock(
                        label: t.recordSpeed,
                        value: '${speed.toStringAsFixed(1)} km/h',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Notatka
                  if (activity.note != null &&
                      activity.note!.trim().isNotEmpty) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        t.detailNote,
                        style: TextStyle(
                          color: DarkTheme.textSecondary.withOpacity(0.9),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: DarkTheme.primaryHover,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: DarkTheme.textPrimary.withOpacity(0.06),
                        ),
                      ),
                      child: Text(
                        activity.note!,
                        style: const TextStyle(
                          color: DarkTheme.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Фото
                  if (activity.photoPath != null &&
                      activity.photoPath!.isNotEmpty) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        t.detailPhoto,
                        style: TextStyle(
                          color: DarkTheme.textSecondary.withOpacity(0.9),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        File(activity.photoPath!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

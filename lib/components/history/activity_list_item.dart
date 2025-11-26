// lib/pages/components/history/activity_list_item.dart
import 'package:flutter/material.dart';

import '../../../theme/dark_theme.dart';
import '../../../models/activity.dart';
import '../../components/language/app_localizations.dart';

class ActivityListItem extends StatelessWidget {
  final Activity activity;
  final VoidCallback? onTap;

  const ActivityListItem({
    super.key,
    required this.activity,
    this.onTap,
  });

  String _formatDate(DateTime d) {
    return '${d.year.toString().padLeft(4, '0')}-'
        '${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(DateTime d) {
    return '${d.hour.toString().padLeft(2, '0')}:'
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

  String _formatPace(Duration dur, double distanceKm) {
    if (distanceKm <= 0) return '--:-- / km';
    final totalSec = (dur.inSeconds / distanceKm).toInt();
    if (totalSec <= 0) return '--:-- / km';
    final min = (totalSec ~/ 60).toString().padLeft(2, '0');
    final sec = (totalSec % 60).toString().padLeft(2, '0');
    return '$min:$sec / km';
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

  String _labelForType(BuildContext context, ActivityType type) {
    final t = AppLocalizations.of(context);
    switch (type) {
      case ActivityType.run:
        return t.filterRun;
      case ActivityType.ride:
        return t.filterRide;
      case ActivityType.walk:
        return t.filterWalk;
    }
  }

  String _activityTitle(BuildContext context) {
    final name = activity.name?.trim();
    if (name == null || name.isEmpty) {
      return _labelForType(context, activity.type);
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    final distanceKm = activity.distanceMeters / 1000.0;
    final duration = activity.end.difference(activity.start);

    final dateLabel = _formatDate(activity.start);
    final timeLabel = _formatTime(activity.start);
    final durationLabel = _formatDuration(duration);
    final paceLabel = _formatPace(duration, distanceKm);

    return Container(
      decoration: BoxDecoration(
        color: DarkTheme.primaryHover,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: DarkTheme.textPrimary.withOpacity(0.06),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: DarkTheme.secondary.withOpacity(0.2),
          child: Icon(
            _iconForType(activity.type),
            color: DarkTheme.secondary,
          ),
        ),
        title: Text(
          _activityTitle(context),
          style: const TextStyle(
            color: DarkTheme.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              '$dateLabel • $timeLabel',
              style: const TextStyle(
                color: DarkTheme.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${distanceKm.toStringAsFixed(2)} km • $durationLabel • $paceLabel',
              style: const TextStyle(
                color: DarkTheme.textSecondary,
                fontSize: 12,
              ),
            ),
            if (activity.note != null && activity.note!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                activity.note!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: DarkTheme.textSecondary.withOpacity(0.9),
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

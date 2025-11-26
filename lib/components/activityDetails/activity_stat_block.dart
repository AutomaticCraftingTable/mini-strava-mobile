// lib/pages/components/activity_detail/activity_stat_block.dart
import 'package:flutter/material.dart';
import '../../../theme/dark_theme.dart';

class ActivityStatBlock extends StatelessWidget {
  final String label;
  final String value;

  const ActivityStatBlock({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: DarkTheme.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: DarkTheme.textSecondary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

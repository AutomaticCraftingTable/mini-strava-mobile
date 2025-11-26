import 'package:flutter/material.dart';
import '../../theme/dark_theme.dart';

class StatTile extends StatelessWidget {
  final String label;
  final String value;

  const StatTile({
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
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: DarkTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

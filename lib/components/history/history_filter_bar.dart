// lib/pages/components/history/history_filter_bar.dart
import 'package:flutter/material.dart';
import '../../../theme/dark_theme.dart';
import '../../components/language/app_localizations.dart';
import '../../pages/history_page.dart';

class HistoryFilterBar extends StatelessWidget {
  final ActivityFilter currentFilter;
  final ValueChanged<ActivityFilter> onFilterChanged;
  final String sortLabel;
  final VoidCallback onSortTap;

  const HistoryFilterBar({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
    required this.sortLabel,
    required this.onSortTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(
                  label: t.filterAll,
                  selected: currentFilter == ActivityFilter.all,
                  onTap: () => onFilterChanged(ActivityFilter.all),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: t.filterRun,
                  icon: Icons.directions_run_rounded,
                  selected: currentFilter == ActivityFilter.run,
                  onTap: () => onFilterChanged(ActivityFilter.run),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: t.filterRide,
                  icon: Icons.directions_bike_rounded,
                  selected: currentFilter == ActivityFilter.ride,
                  onTap: () => onFilterChanged(ActivityFilter.ride),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: t.filterWalk,
                  icon: Icons.directions_walk_rounded,
                  selected: currentFilter == ActivityFilter.walk,
                  onTap: () => onFilterChanged(ActivityFilter.walk),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),

        // кнопка сортировки
        GestureDetector(
          onTap: onSortTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: DarkTheme.primaryHover,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: DarkTheme.textPrimary.withOpacity(0.15),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.sort_rounded,
                  size: 18,
                  color: DarkTheme.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  sortLabel,
                  style: const TextStyle(
                    color: DarkTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? DarkTheme.secondary : DarkTheme.primaryHover;
    final border =
    selected ? DarkTheme.secondary : DarkTheme.textPrimary.withOpacity(0.15);
    final fg = selected ? DarkTheme.textPrimary : DarkTheme.textSecondary;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: fg),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                color: fg,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

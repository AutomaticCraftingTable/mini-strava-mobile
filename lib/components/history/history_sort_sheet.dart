import 'package:flutter/material.dart';
import '../../../theme/dark_theme.dart';
import '../../components/language/app_localizations.dart';
import '../../pages/history_page.dart';


class HistorySortSheet extends StatelessWidget {
  final ActivitySort current;

  const HistorySortSheet({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.33,
      minChildSize: 0.2,
      maxChildSize: 0.33,
      builder: (context, controller) {
        return Container(
          decoration: BoxDecoration(
            color: DarkTheme.primary,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(26),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: ListView(
            controller: controller,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: DarkTheme.textSecondary.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              Center(
                child: Text(
                  t.sortTitle,
                  style: const TextStyle(
                    color: DarkTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _item(context, t.sortNewest, ActivitySort.dateDesc),
              _item(context, t.sortOldest, ActivitySort.dateAsc),
              const Divider(color: Colors.white24, height: 24),
              _item(context, t.sortLongest, ActivitySort.distanceDesc),
              _item(context, t.sortShortest, ActivitySort.distanceAsc),
            ],
          ),
        );
      },
    );
  }

  Widget _item(BuildContext context, String label, ActivitySort value) {
    final selected = value == current;

    return InkWell(
      onTap: () => Navigator.pop(context, value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              color: selected ? DarkTheme.secondary : DarkTheme.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color:
                selected ? DarkTheme.secondary : DarkTheme.textPrimary,
                fontSize: 14,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

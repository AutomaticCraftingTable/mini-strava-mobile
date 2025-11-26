import 'package:flutter/material.dart';
import '../../theme/dark_theme.dart';

class LeaderboardEntry {
  final String name;
  final double distanceKm;
  final bool isCurrentUser;

  const LeaderboardEntry({
    required this.name,
    required this.distanceKm,
    this.isCurrentUser = false,
  });
}

class LeaderboardList extends StatelessWidget {
  final List<LeaderboardEntry> entries;

  const LeaderboardList({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final double maxDistance =
    entries.isNotEmpty ? entries.first.distanceKm : 0;

    return ListView.separated(
      itemCount: entries.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final e = entries[index];
        final position = index + 1;
        final isFirst = position == 1;
        final isSecond = position == 2;
        final isThird = position == 3;

        IconData? crownIcon;
        Color? crownColor;
        if (isFirst) {
          crownIcon = Icons.emoji_events_rounded;
          crownColor = Colors.amberAccent;
        } else if (isSecond) {
          crownIcon = Icons.emoji_events_rounded;
          crownColor = Colors.grey[300];
        } else if (isThird) {
          crownIcon = Icons.emoji_events_rounded;
          crownColor = Colors.brown[300];
        }

        final bool isMe = e.isCurrentUser;

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: isMe
                ? DarkTheme.secondary.withOpacity(0.15)
                : DarkTheme.primaryHover,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isMe
                  ? DarkTheme.secondary.withOpacity(0.8)
                  : DarkTheme.textPrimary.withOpacity(0.06),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 30,
                child: Text(
                  '$position.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isMe
                        ? DarkTheme.secondary
                        : DarkTheme.textSecondary,
                    fontSize: 14,
                    fontWeight:
                    isMe ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 6),

              if (crownIcon != null) ...[
                Icon(
                  crownIcon,
                  color: crownColor,
                  size: 18,
                ),
                const SizedBox(width: 6),
              ],

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            e.name,
                            style: TextStyle(
                              color: isMe
                                  ? DarkTheme.textPrimary
                                  : DarkTheme.textSecondary,
                              fontSize: 14,
                              fontWeight: isMe
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${e.distanceKm.toStringAsFixed(2)} km',
                          style: TextStyle(
                            color: isMe
                                ? DarkTheme.textPrimary
                                : DarkTheme.textSecondary
                                .withOpacity(0.9),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    if (maxDistance > 0)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: (e.distanceKm / maxDistance).clamp(0, 1),
                          minHeight: 6,
                          backgroundColor: Colors.white10,
                          valueColor: AlwaysStoppedAnimation(
                            isMe ? DarkTheme.secondary : Colors.white70,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

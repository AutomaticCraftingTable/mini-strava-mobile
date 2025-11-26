// lib/pages/tabs/history_page.dart
import 'package:flutter/material.dart';

import '../../theme/dark_theme.dart';
import '../../models/activity.dart';
import '../components/language/app_localizations.dart';
import 'activity_details_page.dart';

import '../components/history/history_filter_bar.dart';
import '../components/history/history_sort_sheet.dart';
import '../components/history/activity_list_item.dart';

/// Фильтрация по типу активности
enum ActivityFilter { all, run, ride, walk }

/// Сортировка
enum ActivitySort { dateDesc, dateAsc, distanceDesc, distanceAsc }

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ActivityFilter _filter = ActivityFilter.all;
  ActivitySort _sort = ActivitySort.dateDesc;

  // применяем фильтр по типу
  List<Activity> _applyFilter(List<Activity> all) {
    return all.where((a) {
      switch (_filter) {
        case ActivityFilter.all:
          return true;
        case ActivityFilter.run:
          return a.type == ActivityType.run;
        case ActivityFilter.ride:
          return a.type == ActivityType.ride;
        case ActivityFilter.walk:
          return a.type == ActivityType.walk;
      }
    }).toList();
  }

  void _applySort(List<Activity> items) {
    items.sort((a, b) {
      switch (_sort) {
        case ActivitySort.dateDesc:
          return b.start.compareTo(a.start);
        case ActivitySort.dateAsc:
          return a.start.compareTo(b.start);
        case ActivitySort.distanceDesc:
          return b.distanceMeters.compareTo(a.distanceMeters);
        case ActivitySort.distanceAsc:
          return a.distanceMeters.compareTo(b.distanceMeters);
      }
    });
  }

  String _sortLabel(BuildContext context, ActivitySort sort) {
    final t = AppLocalizations.of(context);
    switch (sort) {
      case ActivitySort.dateDesc:
        return t.sortNewest;
      case ActivitySort.dateAsc:
        return t.sortOldest;
      case ActivitySort.distanceDesc:
        return t.sortLongest;
      case ActivitySort.distanceAsc:
        return t.sortShortest;
    }
  }

  Future<void> _openSortSheet() async {
    final selected = await showModalBottomSheet<ActivitySort>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return HistorySortSheet(current: _sort);
      },
    );

    if (selected != null) {
      setState(() {
        _sort = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return AnimatedBuilder(
      animation: ActivityRepo.instance,
      builder: (context, _) {
        final all = ActivityRepo.instance.activities;
        final hasAny = all.isNotEmpty;

        final items = _applyFilter(List<Activity>.from(all));
        _applySort(items);

        return Container(
          color: DarkTheme.primary,
          child: Column(
            children: [
              // верхняя панель с фильтрами и кнопкой сортировки
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: HistoryFilterBar(
                  currentFilter: _filter,
                  sortLabel: _sortLabel(context, _sort),
                  onFilterChanged: (f) {
                    setState(() => _filter = f);
                  },
                  onSortTap: _openSortSheet,
                ),
              ),

              const Divider(
                height: 1,
                color: Color(0x22FFFFFF),
              ),

              Expanded(
                child: () {
                  if (!hasAny) {
                    return Center(
                      child: Text(
                        t.historyEmpty,
                        style: const TextStyle(
                          color: DarkTheme.textSecondary,
                          fontSize: 15,
                        ),
                      ),
                    );
                  }

                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        t.historyEmptyFilter,
                        style: const TextStyle(
                          color: DarkTheme.textSecondary,
                          fontSize: 15,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final a = items[index];
                      return ActivityListItem(
                        activity: a,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  ActivityDetailPage(activity: a),
                            ),
                          );
                        },
                      );
                    },
                  );
                }(),
              ),
            ],
          ),
        );
      },
    );
  }
}

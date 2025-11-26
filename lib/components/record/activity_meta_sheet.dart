// lib/pages/components/record/activity_meta_sheet.dart
import 'package:flutter/material.dart';
import '../../theme/dark_theme.dart';
import '../../models/activity.dart';
import '../language/app_localizations.dart';     // <— локализации
import 'stat_tile.dart';
import 'type_chip.dart';

class ActivityMetaResult {
  final String name;
  final String? note;
  final ActivityType type;
  final String? photoPath;

  ActivityMetaResult({
    required this.name,
    required this.type,
    this.note,
    this.photoPath,
  });
}

class ActivityMetaSheet extends StatefulWidget {
  final double distanceKm;
  final Duration duration;
  final String paceLabel;

  const ActivityMetaSheet({
    super.key,
    required this.distanceKm,
    required this.duration,
    required this.paceLabel,
  });

  @override
  State<ActivityMetaSheet> createState() => _ActivityMetaSheetState();
}

class _ActivityMetaSheetState extends State<ActivityMetaSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  ActivityType _type = ActivityType.run;
  String? _photoPath;

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      final t = AppLocalizations.of(context);
      final d = widget.distanceKm.toStringAsFixed(2);
      final defaultName = t.activityDefaultName;
      _nameCtrl.text = '$defaultName – $d km';

      _initialized = true;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  InputDecoration _dec(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: DarkTheme.primaryHover,
    hintStyle: const TextStyle(
      color: DarkTheme.hintColor,
      fontSize: 14,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: DarkTheme.textPrimary.withOpacity(0.08),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        color: DarkTheme.secondary,
        width: 1.4,
      ),
    ),
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final t = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (ctx, scrollController) {
          return Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: mq.viewInsets.bottom + 16,
            ),
            decoration: const BoxDecoration(
              color: DarkTheme.primary,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: DarkTheme.textSecondary.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),


                  Text(
                    t.metaTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: DarkTheme.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StatTile(
                        label: t.recordDistance,
                        value: '${widget.distanceKm.toStringAsFixed(2)} km',
                      ),
                      StatTile(
                        label: t.metaTime, // "Czas" / "Time"
                        value: '${widget.duration.inMinutes} min',
                      ),
                      StatTile(
                        label: t.recordPace,
                        value: '${widget.paceLabel} / km',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _nameCtrl,
                    decoration: _dec(t.metaNameHint),
                    style: const TextStyle(
                      color: DarkTheme.textPrimary,
                      fontSize: 16,
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? t.metaNameRequired
                        : null,
                  ),
                  const SizedBox(height: 14),

                  Text(
                    t.metaType,
                    style: const TextStyle(
                      color: DarkTheme.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      TypeChip(
                        label: t.filterRun,
                        icon: Icons.directions_run_rounded,
                        selected: _type == ActivityType.run,
                        onTap: () =>
                            setState(() => _type = ActivityType.run),
                      ),
                      const SizedBox(width: 8),
                      TypeChip(
                        label: t.filterRide,
                        icon: Icons.directions_bike_rounded,
                        selected: _type == ActivityType.ride,
                        onTap: () =>
                            setState(() => _type = ActivityType.ride),
                      ),
                      const SizedBox(width: 8),
                      TypeChip(
                        label: t.filterWalk,
                        icon: Icons.directions_walk_rounded,
                        selected: _type == ActivityType.walk,
                        onTap: () =>
                            setState(() => _type = ActivityType.walk),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _noteCtrl,
                    decoration: _dec(t.metaNoteHint),
                    style: const TextStyle(
                      color: DarkTheme.textPrimary,
                      fontSize: 14,
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      const SizedBox(width: 12),
                      if (_photoPath != null)
                        const Icon(
                          Icons.check_circle,
                          color: DarkTheme.accent,
                        ),
                    ],
                  ),
                  if (_photoPath != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      t.metaPhotoAdded,
                      style: TextStyle(
                        color: DarkTheme.textSecondary.withOpacity(0.9),
                        fontSize: 12,
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: DarkTheme.textSecondary,
                            side: BorderSide(
                              color:
                              DarkTheme.textSecondary.withOpacity(0.6),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                          ),
                          child: Text(t.metaCancel),
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;
                            Navigator.of(context).pop(
                              ActivityMetaResult(
                                name: _nameCtrl.text.trim(),
                                note: _noteCtrl.text.trim().isEmpty
                                    ? null
                                    : _noteCtrl.text.trim(),
                                type: _type,
                                photoPath: _photoPath,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: DarkTheme.secondary,
                            foregroundColor: DarkTheme.textPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                          ),
                          child: Text(
                            t.metaSave,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

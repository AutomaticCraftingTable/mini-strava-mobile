// lib/pages/tabs/record_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:geolocator/geolocator.dart' hide ActivityType;

import '../../theme/dark_theme.dart';
import '../../models/activity.dart';
import '../components/language/app_localizations.dart';
import '../components/record/activity_meta_sheet.dart';
import '../components/record/record_controller.dart';
import '../components/record/stat_tile.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late final RecordController _c;

  AppLocalizations get t => AppLocalizations.of(context);

  @override
  void initState() {
    super.initState();

    _c = RecordController(
      showMessage: (msg) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      },
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_c.canSave || _c.startTime == null) return;

    final meta = await showModalBottomSheet<ActivityMetaResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return ActivityMetaSheet(
          distanceKm: _c.distanceKm,
          duration: _c.elapsed,
          paceLabel: _c.paceLabel,
        );
      },
    );

    if (meta == null) {
      return;
    }

    final activity = Activity(
      start: _c.startTime!,
      end: _c.startTime!.add(_c.elapsed),
      distanceMeters: _c.distanceMeters,
      name: meta.name,
      note: meta.note,
      type: meta.type,
      photoPath: meta.photoPath,
      path: _c.path
          .map((p) => TrackPoint(lat: p.latitude, lon: p.longitude))
          .toList(),
    );

    ActivityRepo.instance.add(activity);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${t.recordSaved}: ${_c.formattedElapsed}, '
              '${_c.distanceKm.toStringAsFixed(2)} km',
        ),
      ),
    );

    _c.reset();
  }

  Future<void> _finishAndSave() async {
    _c.finish();
    await _save();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSession = _c.elapsed > Duration.zero || _c.isRecording;

    String mainLabel;
    if (!_c.isRecording && _c.elapsed == Duration.zero) {
      mainLabel = t.recordStart;
    } else if (_c.isPaused) {
      mainLabel = t.recordResume;
    } else {
      mainLabel = t.recordPause;
    }

    final List<latlng.LatLng> polyPoints = _c.path
        .map((Position p) => latlng.LatLng(p.latitude, p.longitude))
        .toList();

    final latlng.LatLng initialCenter = polyPoints.isNotEmpty
        ? polyPoints.last
        : const latlng.LatLng(52.0, 19.0);

    final padding = MediaQuery.of(context).padding;

    return Stack(
      children: [
        Positioned.fill(
          child: FlutterMap(
            key: ValueKey('map_${polyPoints.length}'),
            options: MapOptions(
              initialCenter: initialCenter,
              initialZoom: 16,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.project_strava',
              ),
              if (polyPoints.length >= 2)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: polyPoints,
                      color: DarkTheme.secondary,
                      strokeWidth: 4,
                    ),
                  ],
                ),
              if (polyPoints.isNotEmpty)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: polyPoints.last,
                      width: 26,
                      height: 26,
                      child: Container(
                        decoration: BoxDecoration(
                          color: DarkTheme.secondary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.45),
                  Colors.black.withOpacity(0.15),
                  Colors.black.withOpacity(0.65),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          left: 16,
          right: 16,
          top: padding.top + 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                t.recordNewActivity,
                style: const TextStyle(
                  color: DarkTheme.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      t.recordDuration,
                      style: const TextStyle(
                        color: DarkTheme.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _c.formattedElapsed,
                      style: const TextStyle(
                        color: DarkTheme.textPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        StatTile(
                          label: t.recordDistance,
                          value: '${_c.distanceKm.toStringAsFixed(2)} km',
                        ),
                        StatTile(
                          label: t.recordPace,
                          value: '${_c.paceLabel} / km',
                        ),
                        StatTile(
                          label: t.recordSpeed,
                          value:
                          '${_c.speedKmh.isNaN ? 0 : _c.speedKmh.toStringAsFixed(1)} km/h',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // НИЖНИЕ КНОПКИ
        Positioned(
          left: 16,
          right: 16,
          bottom: padding.bottom + 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (!_c.isRecording && _c.elapsed == Duration.zero) {
                        _c.startNew();
                      } else {
                        _c.togglePause();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(26),
                      backgroundColor: DarkTheme.secondary,
                      foregroundColor: DarkTheme.textPrimary,
                      elevation: 4,
                    ),
                    child: Icon(
                      (!_c.isRecording && _c.elapsed == Duration.zero)
                          ? Icons.play_arrow_rounded
                          : (_c.isPaused
                          ? Icons.play_arrow_rounded
                          : Icons.pause_rounded),
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    mainLabel,
                    style: const TextStyle(
                      color: DarkTheme.textPrimary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              if (hasSession) const SizedBox(width: 32),

              if (hasSession)
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _finishAndSave,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(26),
                        backgroundColor: DarkTheme.danger,
                        foregroundColor: DarkTheme.textPrimary,
                        elevation: 4,
                      ),
                      child: const Icon(
                        Icons.stop_rounded,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      t.recordFinish,
                      style: const TextStyle(
                        color: DarkTheme.textPrimary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

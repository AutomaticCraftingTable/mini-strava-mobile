// lib/pages/components/activity_detail/activity_detail_map.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;

import '../../../models/activity.dart';
import '../../../theme/dark_theme.dart';

class ActivityDetailMap extends StatelessWidget {
  final List<TrackPoint> path;

  const ActivityDetailMap({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    final polyPoints =
    path.map((tp) => latlng.LatLng(tp.lat, tp.lon)).toList();

    if (polyPoints.isEmpty) {
      return const SizedBox.shrink();
    }

    final latlng.LatLng center = polyPoints.last;

    return SizedBox(
      height: 260,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: center,
          initialZoom: 15,
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
          MarkerLayer(
            markers: [
              // старт
              Marker(
                point: polyPoints.first,
                width: 20,
                height: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
              // финиш
              Marker(
                point: polyPoints.last,
                width: 22,
                height: 22,
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
    );
  }
}

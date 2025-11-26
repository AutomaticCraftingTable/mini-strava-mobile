import 'package:flutter/foundation.dart';

enum ActivityType {
  run,
  ride,
  walk,
}
class TrackPoint {
  final double lat;
  final double lon;

  const TrackPoint({
    required this.lat,
    required this.lon,
  });
}
class Activity {
  final DateTime start;
  final DateTime end;
  final double distanceMeters;

  final String? name;
  final String? note;
  final ActivityType type;
  final String? photoPath;

  final List<TrackPoint> path;

  Activity({
    required this.start,
    required this.end,
    required this.distanceMeters,
    this.name,
    this.note,
    this.photoPath,
    this.type = ActivityType.run,
    this.path = const [],
  });

  Duration get duration => end.difference(start);

  double get distanceKm => distanceMeters / 1000.0;

  double get avgSpeedKmh {
    final hours = duration.inSeconds / 3600.0;
    if (hours <= 0) return 0;
    return distanceKm / hours;
  }

  double get paceSecondsPerKm {
    if (distanceKm <= 0) return 0;
    return duration.inSeconds / distanceKm;
  }

  String get paceLabel {
    final totalSec = paceSecondsPerKm.toInt();
    if (totalSec <= 0 || totalSec.isNaN) return '--:--';
    final min = (totalSec ~/ 60).toString().padLeft(2, '0');
    final sec = (totalSec % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }
}

class ActivityRepo extends ChangeNotifier {
  static final ActivityRepo instance = ActivityRepo._();
  ActivityRepo._();

  final List<Activity> _activities = [];

  List<Activity> get activities => List.unmodifiable(_activities);

  void add(Activity activity) {
    _activities.add(activity);
    debugPrint('ActivityRepo: added, total = ${_activities.length}');
    notifyListeners();
  }
}

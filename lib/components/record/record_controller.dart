// lib/pages/components/record/record_controller.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class RecordController extends ChangeNotifier {
  RecordController({
    required this.showMessage,
  });

  final void Function(String message) showMessage;

  bool _isRecording = false;
  bool get isRecording => _isRecording;

  bool _isPaused = false;
  bool get isPaused => _isPaused;

  DateTime? _startTime;
  DateTime? get startTime => _startTime;

  Duration _elapsed = Duration.zero;
  Duration get elapsed => _elapsed;

  double _distanceMeters = 0;
  double get distanceMeters => _distanceMeters;

  Position? _lastPosition;

  final List<Position> _path = [];
  List<Position> get path => List.unmodifiable(_path);

  Timer? _timer;
  StreamSubscription<Position>? _posSub;

  bool get canSave =>
      !_isRecording && _elapsed > Duration.zero && _startTime != null;

  double get distanceKm => _distanceMeters / 1000.0;

  double get speedKmh {
    final hours = _elapsed.inSeconds / 3600.0;
    if (hours <= 0) return 0;
    return distanceKm / hours;
  }

  String get paceLabel {
    if (distanceKm <= 0) return '--:--';
    final totalSec = (_elapsed.inSeconds / distanceKm).toInt();
    if (totalSec <= 0) return '--:--';
    final min = (totalSec ~/ 60).toString().padLeft(2, '0');
    final sec = (totalSec % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  String get formattedElapsed => _formatDuration(_elapsed);

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Future<bool> _ensurePermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showMessage('Lokalizacja wyłączona w systemie');
      return false;
    }

    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }

    if (perm == LocationPermission.denied) {
      showMessage('Brak zgody na użycie lokalizacji');
      return false;
    }

    if (perm == LocationPermission.deniedForever) {
      showMessage(
        'Dostęp do lokalizacji zablokowany. Zmień uprawnienia w ustawieniach.',
      );
      return false;
    }

    return true;
  }

  Future<void> startNew() async {
    debugPrint('RecordController: START NEW');

    final ok = await _ensurePermission();
    if (!ok) return;

    final now = DateTime.now();
    _isRecording = true;
    _isPaused = false;
    _startTime = now;
    _elapsed = Duration.zero;
    _distanceMeters = 0;
    _lastPosition = null;
    _path.clear();
    notifyListeners();

    showMessage('Start nagrywania');

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isRecording || _isPaused) return;
      _elapsed += const Duration(seconds: 1);
      notifyListeners();
    });

    _posSub?.cancel();
    _posSub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 3,
      ),
    ).listen((pos) {
      if (!_isRecording || _isPaused) return;

      _path.add(pos);

      if (_lastPosition != null) {
        final d = Geolocator.distanceBetween(
          _lastPosition!.latitude,
          _lastPosition!.longitude,
          pos.latitude,
          pos.longitude,
        );
        if (d > 0) {
          _distanceMeters += d;
        }
      }
      _lastPosition = pos;
      notifyListeners();
    });
  }

  void togglePause() {
    if (!_isRecording) return;

    _isPaused = !_isPaused;
    if (_isPaused) {
      _lastPosition = null;
    }
    notifyListeners();

    showMessage(_isPaused
        ? 'Aktywność wstrzymana'
        : 'Aktywność wznowiona');
  }

  void finish() {

    if (!_isRecording && _elapsed <= Duration.zero) return;

    _timer?.cancel();
    _posSub?.cancel();

    _isRecording = false;
    _isPaused = false;
    _lastPosition = null;
    notifyListeners();
  }
  void reset() {
    _isRecording = false;
    _isPaused = false;
    _startTime = null;
    _elapsed = Duration.zero;
    _distanceMeters = 0;
    _lastPosition = null;
    _path.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _posSub?.cancel();
    super.dispose();
  }
}

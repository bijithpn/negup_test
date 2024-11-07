import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../services/services.dart';

class HomeViewModel extends ChangeNotifier {
  final List<Position> _currentPositions = [];
  bool _isTracking = false;
  Timer? _locationTimer;
  final NotificationService notificationService = NotificationService();
  final LocationService _locationService = LocationService();
  final PermissionHandlerService permissionHandlerService =
      PermissionHandlerService();

  List<Position> get currentPositions => _currentPositions;
  bool get isTracking => _isTracking;

  Future<void> startTracking(BuildContext context) async {
    bool hasLocationPermission =
        await permissionHandlerService.requestLocationPermission();
    if (hasLocationPermission == false) {
      bool isPermanentlyDenied = await permissionHandlerService
          .isLocationPermissionPermanentlyDenied();
      if (isPermanentlyDenied) {
        if (context.mounted) {
          permissionHandlerService.showPermissionDialog(context);
        }
        return;
      }
    }
    bool hasNotificationPermission =
        await permissionHandlerService.requestNotificationPermission();
    if (hasLocationPermission && hasNotificationPermission) {
      _isTracking = true;
      await getLocation();
      _startLocationUpdates();
      notifyListeners();
    } else {
      _isTracking = false;
      notifyListeners();
    }
  }

  void _startLocationUpdates() {
    _locationTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      await getLocation();
    });
  }

  Future<void> getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission = await Geolocator.checkPermission();
      if (!serviceEnabled || permission == LocationPermission.denied) {
        return;
      }
      Position position = await _locationService.getCurrentLocation();
      _currentPositions.add(position);
      notificationService.showNotification(
        title: "Location updated",
        message: "Your location has been updated.",
      );
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching location: $e");
    }
  }

  void stopTracking() {
    _locationTimer?.cancel();
    _isTracking = false;
    notifyListeners();
  }
}

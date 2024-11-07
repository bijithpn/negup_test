import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:negup_test/core/constants/storage_keys.dart';
import 'package:negup_test/core/utils/utils.dart';

import '../services/services.dart';

class HomeViewModel extends ChangeNotifier {
  final NotificationService notificationService = NotificationService();
  final PermissionHandlerService permissionHandlerService =
      PermissionHandlerService();

  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  final List<Position> _currentPositions = [];
  bool _isTracking = false;
  final LocationService _locationService = LocationService();
  Timer? _locationTimer;

  void fetchLocationData() async {
    try {
      var data =
          await sharedPreferencesService.getData(StorageKeys.positionList);
      if (data != null) {
        _currentPositions.addAll(Utils.positionsFromJson(data));
        notifyListeners();
      }
    } catch (e, stack) {
      debugPrint(stack.toString());
      debugPrint(e.toString());
    }
  }

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
      if (!_isTracking) {
        await getLocation();
      }
      _isTracking = true;
      startLocationUpdates();
      notifyListeners();
    } else {
      _isTracking = false;
      notifyListeners();
    }
  }

  void startLocationUpdates() {
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
      savePositions(_currentPositions);
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching location: $e");
    }
  }

  void savePositions(List<Position> positions) async {
    List<Map<String, dynamic>> positionMaps =
        positions.map((position) => Utils.positionToMap(position)).toList();
    await sharedPreferencesService.saveData(
        StorageKeys.positionList, positionMaps);
  }

  void stopTracking() {
    _locationTimer?.cancel();
    _isTracking = false;
    notifyListeners();
  }
}

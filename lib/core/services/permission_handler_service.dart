import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class PermissionHandlerService {
  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      return false;
    } else if (status.isPermanentlyDenied) {
      return false;
    }
    return false;
  }

  Future<bool> isLocationPermissionPermanentlyDenied() async {
    var status = await Permission.location.status;
    return status.isPermanentlyDenied;
  }

  Future<void> showPermissionDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Denied'),
          content: const Text(
              'Location permission has been permanently denied. Please enable it in the app settings to continue tracking location.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openAppSettings();
              },
              child: const Text('Go to Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> requestNotificationPermission() async {
    var status = await Permission.notification.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}

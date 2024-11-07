import 'package:negup_test/core/constants/app_strings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class PermissionHandlerService {
  static final PermissionHandlerService _singleton =
      PermissionHandlerService._internal();

  factory PermissionHandlerService() {
    return _singleton;
  }

  PermissionHandlerService._internal();

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
    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text(
            AppStrings.locationPermissionDenied,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          content: Text(
            AppStrings.locationPermissionPermanentlyDenied,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openAppSettings();
              },
              child: Text(AppStrings.goToSetting,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppStrings.cancel,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
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

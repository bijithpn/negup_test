class AppStrings {
  AppStrings._();

  // App related strings
  static const String appName = 'Negup Test';
  static const String appbarTitle = 'Test App';

  // Tracking related strings
  static const String startTracking = 'Start Tracking';
  static const String stopLocationUpdate = 'Stop Location Update';
  static const String startLocationUpdate = 'Start Location Update';

  // Location permission related strings
  static const String locationAccess = "Location Access";
  static const String locationEnabled = "Location Permission Enabled";
  static const String locationDeniedDialog =
      "This app needs access to your location to provide accurate information. Please allow location access.";
  static const String locationEnabledMessage =
      "Location Permission Denied. Go to settings and enable location";
  static const String requestLocationPermission = 'Request Location Permission';
  static const String locationPermissionPermanentlyDenied =
      'Location permission has been permanently denied. Please enable it in the app settings to continue tracking location.';
  static const String locationPermissionDenied = 'Location Permission Denied';

  // Notification permission related strings
  static const String requestNotificationPermission =
      'Request Notification Permission';
  static const String notificationPermissionDenied =
      "Notification Permission Denied. Go to settings and enable notifications";
  static const String notificationPermissionEnabled =
      "Notification Permission Enabled";

  // Messages related to location updates
  static const String locationUpdateStoppedTitle = "Location update stopped";
  static const String locationUpdateStoppedMessage =
      "Location tracking has been paused. You can resume it later.";
  static const String locationUpdatedTitle = "Location updated";
  static const String locationUpdatedMessage =
      "Your location has been updated.";

  // Dialog and button related strings
  static const String goToSetting = 'Go to Settings';
  static const String cancel = "Cancel";
  static const String yes = "Yes";
  static const String no = "No";
  static const String settings = 'Settings';
}

import 'package:geolocator/geolocator.dart';

class Utils {
  static Map<String, dynamic> positionToMap(Position position) {
    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'altitude': position.altitude,
      'accuracy': position.accuracy,
      'speed': position.speed,
      'heading': position.heading,
      'timestamp': position.timestamp.toIso8601String(),
    };
  }

  static List<Position> positionsFromJson(List<dynamic>? jsonData) {
    if (jsonData == null) return [];
    return jsonData.map((map) {
      return Position(
        speed: map['speed'] ?? 0.0,
        speedAccuracy: map['speedAccuracy'] ?? 0.0,
        accuracy: map['accuracy'] ?? 0.0,
        heading: map['heading'] ?? 0.0,
        headingAccuracy: map['headingAccuracy'] ?? 0.0,
        altitude: map['altitude'] ?? 0.0,
        latitude: map['latitude'] ?? 0.0,
        altitudeAccuracy: map['altitudeAccuracy'] ?? 0.0,
        longitude: map['longitude'] ?? 0.0,
        timestamp: DateTime.parse(map['timestamp']),
      );
    }).toList();
  }
}

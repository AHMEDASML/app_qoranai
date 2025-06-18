import 'dart:math' as math;

import 'package:sensors_plus/sensors_plus.dart';


class MathUtils {
  static double radians(double degrees) => degrees * (math.pi / 180);
  static double degrees(double radians) => radians * (180 / math.pi);

  static double calculateQiblaAngle(double lat, double lon) {
    const double kaabaLat = 21.4225;
    const double kaabaLon = 39.8262;
    double deltaLon = radians(kaabaLon - lon);
    double userLatRad = radians(lat);
    double kaabaLatRad = radians(kaabaLat);
    double y = math.sin(deltaLon) * math.cos(kaabaLatRad);
    double x = math.cos(userLatRad) * math.sin(kaabaLatRad) -
        math.sin(userLatRad) * math.cos(kaabaLatRad) * math.cos(deltaLon);
    double angle = math.atan2(y, x);
    return (degrees(angle) + 360) % 360;
  }

  static double getShortestRotation(double previous, double current) {
    double diff = (current - previous) % 360;
    if (diff > 180) {
      diff -= 360;
    } else if (diff < -180) {
      diff += 360;
    }
    return previous + diff;
  }

  static void listenToSensors(Function calculateHeading) {
    accelerometerEvents.listen((event) {
      calculateHeading(event.x, event.y, event.z, null, null, null);
    });
    magnetometerEvents.listen((event) {
      calculateHeading(null, null, null, event.x, event.y, event.z);
    });
  }
  
}

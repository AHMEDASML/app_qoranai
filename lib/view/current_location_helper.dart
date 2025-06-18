import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:geolocator/geolocator.dart';

Future<void> getCurrentLocationAndSave({int retryCount = 3}) async {
  int attempts = 0;

  while (attempts < retryCount) {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("Location service is disabled.");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        print("Location permission permanently denied.");
        return;
      }

      if (permission == LocationPermission.denied) {
        print("Location permission denied.");
        attempts++;
        continue; // retry
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await GlobalFunctions.setLat(position.latitude);
      await GlobalFunctions.setLng(position.longitude);
      print("Location saved: (${position.latitude}, ${position.longitude})");
      return;

    } catch (e) {
      print("Error getting location: $e");
      attempts++;
      await Future.delayed(const Duration(seconds: 2)); // optional delay before retry
    }
  }

  print("Failed to get location after $retryCount attempts.");
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestCameraPermission() async {
  bool granted = false;

  // التحقق من حالة الإذن الحالي للكاميرا
  PermissionStatus cameraStatus = await Permission.camera.status;

  if (cameraStatus.isDenied) {
    // إذا تم منع الإذن، نطلب إعادة تقييمه
    cameraStatus = await Permission.camera.request();

    if (cameraStatus.isPermanentlyDenied) {
      // إذا تم منعه بشكل دائم، نوجه المستخدم إلى إعدادات التطبيق
      openAppSettings();
    }
  } else if (cameraStatus.isLimited || cameraStatus.isRestricted) {
    // في حالات iOS الخاصة، قد تكون هناك قيود على الإذن
    cameraStatus = await Permission.camera.request();
  }

  granted = cameraStatus.isGranted;

  return granted;
}

Future<bool> requestStoragePermission() async {
  bool granted = false;

  // التحقق من حالة الإذن الحالي للخزن
  PermissionStatus storageStatus = await Permission.storage.status;

  if (storageStatus.isDenied) {
    // إذا تم منع الإذن، نطلب إعادة تقييمه
    storageStatus = await Permission.storage.request();

    if (storageStatus.isPermanentlyDenied) {
      // إذا تم منعه بشكل دائم، نوجه المستخدم إلى إعدادات التطبيق
      openAppSettings();
    }
  } else if (storageStatus.isLimited || storageStatus.isRestricted) {
    // في حالات iOS الخاصة، قد تكون هناك قيود على الإذن
    storageStatus = await Permission.storage.request();
  }

  granted = storageStatus.isGranted;

  return granted;
}

Future<bool> checkPermissions() async {
  bool granted = false;

  PermissionStatus locationStatus = await Permission.location.status;

  if (locationStatus.isDenied) {
    locationStatus = await Permission.location.request();

    if (locationStatus.isPermanentlyDenied) {
      openAppSettings();
    }
  } else if (locationStatus.isLimited || locationStatus.isRestricted) {
    locationStatus = await Permission.location.request();
  }

  granted = locationStatus.isGranted;

  // التحقق من تشغيل خدمة الموقع
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isLocationServiceEnabled) {
    granted = false;
  }

  return granted;
}

class LocationService {
  // دالة للتحقق من الأذونات وخدمة الموقع
  static Future<bool> checkPermissions(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showDialog(
          context,
          "إذن الموقع مرفوض",
          "يرجى السماح للتطبيق بالوصول إلى موقعك.",
          openAppSettings,
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _showDialog(
        context,
        "إذن الموقع مرفوض نهائيًا",
        "لقد منعت الإذن بشكل دائم، الرجاء تفعيله من إعدادات التطبيق.",
        openAppSettings,
      );
      return false;
    }
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showDialog(
        context,
        "خدمة الموقع غير مفعلة",
        "يرجى تفعيل خدمة الموقع من الإعدادات.",
        openLocationSettings,
      );
      return false;
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  // دالة لجلب موقع المستخدم
  static Future<Position?> getCurrentLocation(BuildContext context) async {
    bool hasPermission = await checkPermissions(context);
    if (!hasPermission) return null;

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // دالة لفتح إعدادات الموقع
  static Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  // دالة لفتح إعدادات التطبيق
  static Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  // دالة لعرض رسالة تنبيه مع زر فتح الإعدادات
  static void _showDialog(BuildContext context, String title, String message,
      VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء"),
            ),
            TextButton(
              onPressed: () {
                onPressed();
                Navigator.pop(context);
              },
              child: const Text("فتح الإعدادات"),
            ),
          ],
        );
      },
    );
  }
}

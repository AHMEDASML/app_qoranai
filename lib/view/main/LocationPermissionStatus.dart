import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LocationPermissionStatus {
  granted,
  denied,
  deniedForever,
  serviceDisabled,
  unknown
}

class LocationPermissionService {
  static final LocationPermissionService _instance = LocationPermissionService._internal();
  factory LocationPermissionService() => _instance;
  LocationPermissionService._internal();

  final Location _location = Location();

  /// فحص شامل لحالة صلاحيات الموقع
  Future<LocationPermissionStatus> checkLocationPermissionStatus() async {
    try {
      // 1. فحص تفعيل خدمة الموقع
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        print('🚫 خدمة الموقع غير مفعلة');
        return LocationPermissionStatus.serviceDisabled;
      }

      // 2. فحص صلاحيات الموقع (استخدام location package)
      PermissionStatus permissionGranted = await _location.hasPermission();

      switch (permissionGranted) {
        case PermissionStatus.granted:
        case PermissionStatus.grantedLimited:
          print('✅ صلاحية الموقع ممنوحة');
          return LocationPermissionStatus.granted;

        case PermissionStatus.denied:
          print('⚠️ صلاحية الموقع مرفوضة');
          return LocationPermissionStatus.denied;

        case PermissionStatus.deniedForever:
          print('🚫 صلاحية الموقع مرفوضة نهائياً');
          return LocationPermissionStatus.deniedForever;

        default:
          return LocationPermissionStatus.unknown;
      }
    } catch (e) {
      print('❌ خطأ في فحص صلاحيات الموقع: $e');
      return LocationPermissionStatus.unknown;
    }
  }

  /// طلب تفعيل خدمة الموقع
  Future<bool> requestLocationService() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        print('📍 طلب تفعيل خدمة الموقع...');
        serviceEnabled = await _location.requestService();

        if (serviceEnabled) {
          print('✅ تم تفعيل خدمة الموقع');
        } else {
          print('❌ لم يتم تفعيل خدمة الموقع');
        }
      }
      return serviceEnabled;
    } catch (e) {
      print('❌ خطأ في طلب تفعيل خدمة الموقع: $e');
      return false;
    }
  }

  /// طلب صلاحيات الموقع
  Future<LocationPermissionStatus> requestLocationPermission() async {
    try {
      print('🔑 طلب صلاحية الموقع...');

      // استخدام location package فقط
      PermissionStatus permission = await _location.requestPermission();

      switch (permission) {
        case PermissionStatus.granted:
        case PermissionStatus.grantedLimited:
          print('✅ تم منح صلاحية الموقع');
          return LocationPermissionStatus.granted;

        case PermissionStatus.denied:
          print('⚠️ تم رفض صلاحية الموقع');
          return LocationPermissionStatus.denied;

        case PermissionStatus.deniedForever:
          print('🚫 تم رفض صلاحية الموقع نهائياً');
          return LocationPermissionStatus.deniedForever;

        default:
          return LocationPermissionStatus.unknown;
      }
    } catch (e) {
      print('❌ خطأ في طلب صلاحية الموقع: $e');
      return LocationPermissionStatus.unknown;
    }
  }

  /// إعداد صلاحيات الموقع بالكامل
  Future<LocationPermissionStatus> setupLocationPermissions() async {
    try {
      print('🚀 بدء إعداد صلاحيات الموقع...');

      // 1. طلب تفعيل خدمة الموقع
      bool serviceEnabled = await requestLocationService();
      if (!serviceEnabled) {
        return LocationPermissionStatus.serviceDisabled;
      }

      // 2. فحص الصلاحيات الحالية
      LocationPermissionStatus currentStatus = await checkLocationPermissionStatus();

      if (currentStatus == LocationPermissionStatus.granted) {
        print('✅ صلاحيات الموقع جاهزة');
        return LocationPermissionStatus.granted;
      }

      // 3. طلب الصلاحيات إذا لم تكن ممنوحة
      if (currentStatus == LocationPermissionStatus.denied) {
        return await requestLocationPermission();
      }

      return currentStatus;
    } catch (e) {
      print('❌ خطأ في إعداد صلاحيات الموقع: $e');
      return LocationPermissionStatus.unknown;
    }
  }

  /// الحصول على الموقع الحالي
  Future<LocationData?> getCurrentLocation() async {
    try {
      print('📍 الحصول على الموقع الحالي...');

      // التأكد من الصلاحيات أولاً
      LocationPermissionStatus status = await setupLocationPermissions();
      if (status != LocationPermissionStatus.granted) {
        print('❌ لا توجد صلاحيات للموقع');
        return null;
      }

      // الحصول على الموقع مع timeout
      LocationData locationData = await _location.getLocation().timeout(
        Duration(seconds: 15),
        onTimeout: () {
          throw Exception('انتهت مهلة الحصول على الموقع');
        },
      );

      if (locationData.latitude != null && locationData.longitude != null) {
        print('✅ تم الحصول على الموقع: ${locationData.latitude}, ${locationData.longitude}');
        return locationData;
      } else {
        throw Exception('بيانات الموقع غير صحيحة');
      }
    } catch (e) {
      print('❌ خطأ في الحصول على الموقع: $e');
      return null;
    }
  }

  /// عرض حوار تفسيري لصلاحيات الموقع
  Future<bool> showLocationPermissionDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'location_permission'.tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on,
                size: 50,
                color: Colors.blue,
              ),
              SizedBox(height: 16),
              Text(
                'location_permission_explanation'.tr,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Text('• ${'prayer_times_feature'.tr}'),
              Text('• ${'emergency_location_feature'.tr}'),
              Text('• ${'nearby_places_feature'.tr}'),
              Text('• ${'navigation_feature'.tr}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('deny'.tr),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('allow'.tr),
            ),
          ],
        );
      },
    ) ?? false;
  }

  /// عرض حوار إعدادات التطبيق
  Future<bool> showAppSettingsDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'permissions_required'.tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.settings,
                size: 50,
                color: Colors.orange,
              ),
              SizedBox(height: 16),
              Text(
                'location_permission_denied_forever_message'.tr,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('cancel'.tr),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                await permission_handler.openAppSettings();
              },
              child: Text('open_settings'.tr),
            ),
          ],
        );
      },
    ) ?? false;
  }

  /// عرض رسالة خطأ خدمة الموقع
  Future<bool> showLocationServiceDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'location_service_disabled'.tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_off,
                size: 50,
                color: Colors.red,
              ),
              SizedBox(height: 16),
              Text(
                'location_service_disabled_message'.tr,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('cancel'.tr),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                await requestLocationService();
              },
              child: Text('enable'.tr),
            ),
          ],
        );
      },
    ) ?? false;
  }

  /// معالجة شاملة لصلاحيات الموقع مع الحوارات
  Future<LocationData?> handleLocationPermissionsWithUI(BuildContext context) async {
    try {
      // 1. فحص الحالة الحالية
      LocationPermissionStatus status = await checkLocationPermissionStatus();

      switch (status) {
        case LocationPermissionStatus.serviceDisabled:
        // خدمة الموقع معطلة
          bool userAccepted = await showLocationServiceDialog(context);
          if (!userAccepted) return null;

          // إعادة المحاولة بعد التفعيل
          return await handleLocationPermissionsWithUI(context);

        case LocationPermissionStatus.denied:
        // الصلاحية مرفوضة - إظهار حوار تفسيري
          bool userAccepted = await showLocationPermissionDialog(context);
          if (!userAccepted) return null;

          // طلب الصلاحية
          LocationPermissionStatus newStatus = await requestLocationPermission();
          if (newStatus == LocationPermissionStatus.granted) {
            return await getCurrentLocation();
          } else if (newStatus == LocationPermissionStatus.deniedForever) {
            await showAppSettingsDialog(context);
          }
          return null;

        case LocationPermissionStatus.deniedForever:
        // الصلاحية مرفوضة نهائياً
          await showAppSettingsDialog(context);
          return null;

        case LocationPermissionStatus.granted:
        // الصلاحية ممنوحة - الحصول على الموقع
          return await getCurrentLocation();

        default:
          print('❌ حالة غير معروفة لصلاحيات الموقع');
          return null;
      }
    } catch (e) {
      print('❌ خطأ في معالجة صلاحيات الموقع: $e');
      return null;
    }
  }
}
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/config/permission.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:Al_Arqam/core/resources/text/text16.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../../core/resources/asset_manger.dart';
import 'package:get/get.dart';
class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  _CompassScreenState createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  double? heading = 0;
  double previousHeading = 0;
  double? qiblaDirection;
  Position? currentPosition;

  List<double>? accelerometerValues;
  List<double>? magnetometerValues;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _listenToSensors();
  }

  Future<void> _getUserLocation() async {
    Position? position = await LocationService.getCurrentLocation(context);
    position ??= currentPosition;
    if (!mounted) return;
    setState(() {
      currentPosition = position;
      qiblaDirection = _calculateQiblaAngle(
        position?.latitude ?? 21.422510,
        position?.longitude ?? 39.826168,
      );
    });
  }

  double _calculateQiblaAngle(double lat, double lon) {
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

  StreamSubscription? _accelerometerSubscription;
  StreamSubscription? _magnetometerSubscription;

  void _listenToSensors() {
    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      accelerometerValues = [event.x, event.y, event.z];
      _calculateHeading();
    });

    _magnetometerSubscription = magnetometerEventStream().listen((event) {
      magnetometerValues = [event.x, event.y, event.z];
      _calculateHeading();
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _magnetometerSubscription?.cancel();
    super.dispose();
  }

  void _calculateHeading() {
    if (accelerometerValues == null || magnetometerValues == null) return;

    List<double> acc = accelerometerValues!;
    List<double> mag = magnetometerValues!;

    double ax = acc[0], ay = acc[1], az = acc[2];
    double mx = mag[0], my = mag[1], mz = mag[2];

    double normAcc = math.sqrt(ax * ax + ay * ay + az * az);
    ax /= normAcc;
    ay /= normAcc;
    az /= normAcc;

    double hx = my * az - mz * ay;
    double hy = mz * ax - mx * az;

    double headingRad = math.atan2(hy, hx);
    double headingDeg = (degrees(headingRad) + 360) % 360;
    if (!mounted) return;
    setState(() {
      previousHeading = heading ?? 0;
      heading = _getShortestRotation(previousHeading, headingDeg);
    });
  }

  double _getShortestRotation(double previous, double current) {
    double diff = (current - previous) % 360;
    if (diff > 180) {
      diff -= 360;
    } else if (diff < -180) {
      diff += 360;
    }
    return previous + diff;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBackground,
      appBar: CustomAppBar(
        title: 'compass_title'.tr,
        backgroundColor: AppColors.whiteBackground,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _getUserLocation();
          _listenToSensors();
        },
        color: AppColors.primary,
        child: ListView(children: [
          Container(
            height: 1.h,
            color: AppColors.greyVerfication,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 100.h),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/twaff.png",
                    height: 80.h,
                    width: 100.w,
                    fit: BoxFit.contain,
                  ),
                  TweenAnimationBuilder<double>(
  tween: Tween<double>(
    begin: -radians(previousHeading),
    end: -radians(heading ?? 0),
  ),
  duration: const Duration(milliseconds: 300),
  builder: (context, value, child) {
    return AnimatedContainer(
       duration: const Duration(milliseconds: 300),
      width: 500.w,
      height: 500.h,

      margin: EdgeInsets.all(25.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:  ((heading != null && qiblaDirection != null) &&
                                  shortestAngleDifference(heading!, qiblaDirection!).abs() <= 5)
                            ?
                         Colors.green:Colors.transparent,
          width: 3,
        ),
      ),
      child: Center(
        child: Transform.rotate(
          angle: value,
          child: Padding(
            padding:  EdgeInsets.only(top:25.h),
            child: Image.asset(
              AppImages.compass,
              width: 400.w, // Optional: slightly smaller for visual margin
              height: 400.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  },
),
                  ((heading != null && qiblaDirection != null) &&
                          shortestAngleDifference(heading!, qiblaDirection!).abs() <= 5)
                      ? AnimatedOpacity(
                          opacity: ((heading != null && qiblaDirection != null) &&
                                  shortestAngleDifference(heading!, qiblaDirection!).abs() <= 5)
                              ? 1.0
                              : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: CustomButton(
                            backgroundColor: Colors.green,
                            onPressed: () {},
                            width: double.infinity,
                            child: Text16(
                              text: 'you_are_facing_qibla'.tr,
                              color: AppColors.white,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(vertical: 12.h),
                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                              color: AppColors.greyVerfication,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text12(
                              isBold: true,
                              text: 'improve_accuracy_message'.tr),
                        )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

double shortestAngleDifference(double angle1, double angle2) {
  double diff = (angle2 - angle1 + 360) % 360;
  return diff > 180 ? diff - 360 : diff;
}

double radians(double degrees) => degrees * (math.pi / 180);
double degrees(double radians) => radians * (180 / math.pi);
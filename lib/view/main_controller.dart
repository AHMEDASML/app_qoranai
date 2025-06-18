import 'dart:convert';
import 'package:Al_Arqam/core/enums/twaff_enum.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/models/medicin/all_medicins_model.dart';
import 'package:Al_Arqam/models/medicin/data_source/medicins_reminder_data_source.dart';
import 'package:Al_Arqam/view/current_location_helper.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Al_Arqam/core/enums/locations_enum.dart';
import 'package:Al_Arqam/models/capmping/camping_model.dart';
import 'package:Al_Arqam/models/map/resturant_model.dart';
import 'package:Al_Arqam/services/camping_service.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

import 'main/LocationPermissionStatus.dart';

class MainController extends GetxController {


  RxBool prayerTimesLoading = false.obs;
  RxBool prayerTimesError = false.obs;
  RxString prayerTimesErrorMessage = ''.obs;
  final LocationPermissionService _locationService = LocationPermissionService();

  var prayerTimes = {}.obs;
  var times = <String, String>{}.obs;
  var isLocationLoading = false.obs;


  RxBool isLocationPermissionGranted = false.obs;
  RxBool isLocationServiceEnabled = false.obs;
  Rx<LocationPermissionStatus> locationPermissionStatus = LocationPermissionStatus.unknown.obs;
  RxString locationStatusMessage = 'unknown'.obs;




  RxString locationStatus = 'unknown'.obs;

  RxBool showMap = false.obs;
  RxBool showLocation = false.obs;
  RxBool showCamping = false.obs;
  RxBool showRestaurants = false.obs;
  GoogleMapController? mapController;
  RxBool isLoading = false.obs;
  var fontSize = 12.0.obs;
  var selectedTwaffTab = TwaffEnum.twaff.obs;
  var selectedTwaffTabHajj = TwaffWaysEnum.dwa.obs;


  var restaurants = <Restaurant>[].obs;
  var selectedLocation = LocationsEnum.locations.obs;
  var markers = <Marker>{}.obs;
  var currentPosition = "".obs;
  var current = "".obs;
  RxBool showRestaurantInfo = false.obs;
  Restaurant selectedRestaurant = Restaurant(name: "", lat: 0.0, lng: 0.0);
  var campaign = CampaignApi(success: false, message: '',campaign:CampaignResponse(id: '0', guide:[], program: [])).obs;
  var errorMainMessage = ''.obs;
  var statusCode = 0.obs;
  final CampingService _campingService = CampingService();



  String _formatPrayerTime(String? time) {
    if (time == null || time.isEmpty) return '...';

    try {
      // إزالة المنطقة الزمنية إذا كانت موجودة
      String cleanTime = time.split(' ')[0];

      // تحويل إلى 12 ساعة إذا لزم الأمر
      List<String> parts = cleanTime.split(':');
      if (parts.length >= 2) {
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1]);

        String period = hour >= 12 ? 'PM' : 'AM';
        if (hour > 12) hour -= 12;
        if (hour == 0) hour = 12;

        return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
      }

      return cleanTime;
    } catch (e) {
      print('خطأ في تنسيق الوقت: $e');
      return time;
    }
  }

  // إضافة هذه الدالة الجديدة
  Future<void> refreshPrayerTimes() async {
    if (GlobalFunctions.hasValidLocation()) {
      await fetchPrayerTimes(GlobalFunctions.getLat(), GlobalFunctions.getLng());
    } else {
      await _getCurrentLocationSafe();
    }
  }

  // استبدال getCurrentLocation بالكامل
  Future<void> getCurrentLocation() async {
    await getCurrentLocationAndUpdateMap();
  }


  // إضافة هذه الدالة الجديدة
  Future<void> getCurrentLocationAndFetchPrayerTimes() async {
    try {
      await _getCurrentLocationSafe();
    } catch (e) {
      print('❌ خطأ في getCurrentLocationAndFetchPrayerTimes: $e');
      await _useDefaultLocation();
    }
  }
  // Predefined locations
  final List<Map<String, dynamic>> locations = [
    {'name':  'kaaba', 'latitude': 21.4225, 'longitude': 39.8262},
    {'name':  'mount_arafat', 'latitude': 21.3891, 'longitude': 39.9703},
    {'name': 'mina', 'latitude': 21.4224, 'longitude': 39.8690},
    {'name': 'grand_mosque', 'latitude': 21.4225, 'longitude': 39.8262},
    {'name':  'prophet_mosque', 'latitude': 24.4686, 'longitude': 39.6122},
    {'name':  'cave_hira', 'latitude': 21.4221, 'longitude': 39.8749},
    {'name': 'cave_thor', 'latitude': 21.3872, 'longitude': 39.8687},
    {'name': 'namira_mosque', 'latitude': 21.3921, 'longitude': 39.9883},
  ];
  String mapStyle = '''
  [
    {
      "elementType": "geometry",
      "stylers": [{"color": "#F3EADA"}]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [{"color": "#D6D6D6"}]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [{"color": "#F5F5DD"}]
    }
  ]
  ''';
  @override

  void onInit() async {
    super.onInit();
    print('🚀 بدء تهيئة MainController');

    // تهيئة بيانات التطبيق
    await _initializeApp();
  }


  Future<void> _initializeApp() async {
    try {
      // 1. تهيئة صلاحيات ومعلومات الموقع
      await _initializeLocationPermissions();

      // 2. جلب البيانات الأساسية
      await _fetchInitialData();

      print('✅ تم إعداد التطبيق بنجاح');
    } catch (e) {
      print('❌ خطأ في تهيئة التطبيق: $e');
    }
  }

  Future<void> _initializeLocationPermissions() async {
    try {
      isLocationLoading.value = true;
      locationStatusMessage.value = 'checking_permissions'.tr;

      print('🔍 فحص صلاحيات الموقع...');

      // فحص الحالة الحالية
      LocationPermissionStatus status = await _locationService.checkLocationPermissionStatus();
      locationPermissionStatus.value = status;

      switch (status) {
        case LocationPermissionStatus.granted:
          print('✅ صلاحيات الموقع ممنوحة');
          isLocationPermissionGranted.value = true;
          isLocationServiceEnabled.value = true;
          locationStatusMessage.value = 'location_ready'.tr;

          // جلب الموقع وأوقات الصلاة
          await _fetchLocationAndPrayerTimes();
          break;

        case LocationPermissionStatus.denied:
          print('⚠️ صلاحيات الموقع مرفوضة');
          isLocationPermissionGranted.value = false;
          locationStatusMessage.value = 'location_permission_denied'.tr;

          // استخدام موقع افتراضي
          await _useDefaultLocation();
          break;

        case LocationPermissionStatus.deniedForever:
          print('🚫 صلاحيات الموقع مرفوضة نهائياً');
          isLocationPermissionGranted.value = false;
          locationStatusMessage.value = 'location_permission_denied_forever'.tr;

          // استخدام موقع افتراضي
          await _useDefaultLocation();
          break;

        case LocationPermissionStatus.serviceDisabled:
          print('📱 خدمة الموقع معطلة');
          isLocationServiceEnabled.value = false;
          locationStatusMessage.value = 'location_service_disabled'.tr;

          // استخدام موقع افتراضي
          await _useDefaultLocation();
          break;

        default:
          print('❓ حالة غير معروفة للموقع');
          locationStatusMessage.value = 'location_status_unknown'.tr;
          await _useDefaultLocation();
      }
    } catch (e) {
      print('❌ خطأ في تهيئة صلاحيات الموقع: $e');
      locationStatusMessage.value = 'location_initialization_error'.tr;
      await _useDefaultLocation();
    } finally {
      isLocationLoading.value = false;
    }
  }



  /// الحصول على الموقع وأوقات الصلاة
  Future<void> _fetchLocationAndPrayerTimes() async {
    try {
      // التحقق من وجود موقع محفوظ صالح
      if (GlobalFunctions.hasValidLocation()) {
        double lat = GlobalFunctions.getLat();
        double lng = GlobalFunctions.getLng();

        print('📍 استخدام الموقع المحفوظ: $lat, $lng');
        current.value = "$lat $lng";
        currentPosition.value = "$lat $lng";

        await fetchPrayerTimes(lat, lng);
      } else {
        // الحصول على موقع جديد
        await _getCurrentLocationSafe();
      }
    } catch (e) {
      print('❌ خطأ في جلب الموقع وأوقات الصلاة: $e');
      await _useDefaultLocation();
    }
  }

  /// الحصول على الموقع الحالي بأمان
  Future<void> _getCurrentLocationSafe() async {
    try {
      print('📍 الحصول على الموقع الحالي...');
      locationStatusMessage.value = 'getting_current_location'.tr;

      LocationData? locationData = await _locationService.getCurrentLocation();

      if (locationData != null) {
        await GlobalFunctions.saveLocation(locationData.latitude!, locationData.longitude!);

        current.value = "${locationData.latitude} ${locationData.longitude}";
        currentPosition.value = "${locationData.latitude} ${locationData.longitude}";

        await fetchPrayerTimes(locationData.latitude!, locationData.longitude!);

        print('✅ تم الحصول على الموقع بنجاح');
        locationStatusMessage.value = 'location_ready'.tr;
      } else {
        throw Exception('فشل في الحصول على الموقع');
      }
    } catch (e) {
      print('❌ خطأ في الحصول على الموقع: $e');
      await _useDefaultLocation();
    }
  }

  /// استخدام موقع افتراضي (مكة المكرمة)
  Future<void> _useDefaultLocation() async {
    try {
      print('🕋 استخدام الموقع الافتراضي: مكة المكرمة');

      double defaultLat = 21.4225; // مكة المكرمة
      double defaultLng = 39.8262;

      await GlobalFunctions.saveLocation(defaultLat, defaultLng);

      current.value = "$defaultLat $defaultLng";
      currentPosition.value = "$defaultLat $defaultLng";

      await fetchPrayerTimes(defaultLat, defaultLng);

      locationStatusMessage.value = 'using_default_location'.tr;
      print('✅ تم استخدام الموقع الافتراضي');
    } catch (e) {
      print('❌ خطأ في استخدام الموقع الافتراضي: $e');
      locationStatusMessage.value = 'location_error'.tr;
    }
  }

  /// جلب البيانات الأولية
  Future<void> _fetchInitialData() async {
    try {
      print('📚 جلب البيانات الأولية...');

      // يمكن تشغيل هذه العمليات بالتوازي
      await Future.wait([
        fetchCampaign(),
        fetchMedicins(),
      ]);

      print('✅ تم جلب البيانات الأولية');
    } catch (e) {
      print('❌ خطأ في جلب البيانات الأولية: $e');
    }
  }

  // استبدال fetchPrayerTimes بالكامل
  Future<void> fetchPrayerTimes(double latitude, double longitude) async {
    try {
      prayerTimesLoading.value = true;
      prayerTimesError.value = false;
      prayerTimesErrorMessage.value = '';

      print('⏰ جلب أوقات الصلاة للموقع: $latitude, $longitude');

      final url = Uri.https('api.aladhan.com', '/v1/timings', {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'method': '2', // طريقة الحساب
        'school': '0', // المذهب الحنفي
      });

      final response = await http.get(url).timeout(
        Duration(seconds: 10),
        onTimeout: () {
          throw Exception('انتهت مهلة الاتصال');
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['code'] == 200 && data['data'] != null) {
          final timings = data['data']['timings'] as Map<String, dynamic>;

          // تنظيف وتحديث أوقات الصلاة
          times.value = {
            'Fajr': _formatPrayerTime(timings['Fajr']),
            'Dhuhr': _formatPrayerTime(timings['Dhuhr']),
            'Asr': _formatPrayerTime(timings['Asr']),
            'Maghrib': _formatPrayerTime(timings['Maghrib']),
            'Isha': _formatPrayerTime(timings['Isha']),
          };

          prayerTimes.value = timings;

          print('✅ تم تحديث أوقات الصلاة بنجاح: ${times.value}');
        } else {
          throw Exception('استجابة غير صحيحة من API');
        }
      } else {
        throw Exception('خطأ في الخادم: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ خطأ في جلب أوقات الصلاة: $e');
      prayerTimesError.value = true;
      prayerTimesErrorMessage.value = e.toString();

      // أوقات افتراضية في حالة الفشل
      times.value = {
        'Fajr': '05:30',
        'Dhuhr': '12:30',
        'Asr': '15:45',
        'Maghrib': '18:15',
        'Isha': '19:45',
      };
    } finally {
      prayerTimesLoading.value = false;
      update();
    }
  }


  Future<void> initializeLocation() async {
    try {
      isLocationLoading.value = true;

      // التحقق من وجود موقع محفوظ
      if (GlobalFunctions.hasValidLocation()) {
        double lat = GlobalFunctions.getLat();
        double lng = GlobalFunctions.getLng();

        print('استخدام الموقع المحفوظ: $lat, $lng');
        await fetchPrayerTimes(lat, lng);
      } else {
        // الحصول على الموقع الحالي
        print('الحصول على الموقع الحالي...');
        await getCurrentLocationAndFetchPrayerTimes();
      }
    } catch (e) {
      print('خطأ في تهيئة الموقع: $e');
      // استخدام موقع افتراضي (مكة المكرمة)
      await fetchPrayerTimes(21.4225, 39.8262);
    } finally {
      isLocationLoading.value = false;
    }
  }



  List<MedicineElement> medicines = <MedicineElement>[]; // Replace Medicine with your actual model

  void changeTabTwaff(TwaffEnum tab) {
    selectedTwaffTab.value = tab;

  }
  void changeTabTwaffWay(TwaffWaysEnum tab) {
    selectedTwaffTabHajj.value = tab;

  }
  Future<void> fetchMedicins() async {
    print('lllllllllllllllllllllllllllllllllllll');
    isLoading.value = true;
    try {
      if(GlobalFunctions.isAuth())
      {AllMedicinsModel result = await MedicinsReminderDataSource().getMedicins();
      medicines.assignAll(result.medicines!);
      }else{
        medicines=[];
      }
      update();
      // Adjust based on your model structure
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> getCurrentLocationAndUpdateMap() async {
    try {
      isLocationLoading.value = true;
      markers.clear();

      print('📍 تحديث الموقع والخريطة...');

      // الحصول على الموقع الحالي
      LocationData? locationData = await _locationService.getCurrentLocation();

      if (locationData != null) {
        // حفظ الموقع الجديد
        await GlobalFunctions.saveLocation(locationData.latitude!, locationData.longitude!);

        // تحديث المتغيرات
        currentPosition.value = "${locationData.latitude} ${locationData.longitude}";
        current.value = "${locationData.latitude} ${locationData.longitude}";

        // إضافة علامة للموقع الحالي
        _addMarkerForCurrentLocation(locationData);

        // تحريك الكاميرا للموقع الجديد
        animateToLocation();

        // تحديث أوقات الصلاة بناءً على الموقع الجديد
        await fetchPrayerTimes(locationData.latitude!, locationData.longitude!);

        print('✅ تم تحديث الموقع والخريطة بنجاح');
        print('📍 الموقع الجديد: ${locationData.latitude}, ${locationData.longitude}');

      } else {
        throw Exception('فشل في الحصول على الموقع');
      }
    } catch (e) {
      print('❌ خطأ في getCurrentLocationAndUpdateMap: $e');

      // في حالة الفشل، استخدام الموقع المحفوظ إذا توفر
      if (GlobalFunctions.hasValidLocation()) {
        print('🔄 استخدام الموقع المحفوظ...');

        double lat = GlobalFunctions.getLat();
        double lng = GlobalFunctions.getLng();

        currentPosition.value = "$lat $lng";
        current.value = "$lat $lng";

        // إضافة علامة للموقع المحفوظ
        LocationData savedLocation = LocationData.fromMap({
          'latitude': lat,
          'longitude': lng,
        });
        _addMarkerForCurrentLocation(savedLocation);
        animateToLocation();
      }

      rethrow; // إعادة إلقاء الخطأ للتعامل معه في المستوى الأعلى
    } finally {
      isLocationLoading.value = false;
      update();
    }
  }



  void onMarkerTapped() async {
    // Get the current location
    // Position positionCurrent = await Geolocator.getCurrentPosition();
    List<String> positions = currentPosition.value.split(" ");
    List<String> currentPositions = current.value.split(" ");
    double distanceInMeters = Geolocator.distanceBetween(
      double.parse(currentPositions[0]),
      double.parse(currentPositions[1]),
      double.parse(positions[0]),
      double.parse(positions[1]),
    );

    // Calculate estimated time (e.g., assuming an average speed of 5 km/h)
    double estimatedTimeInHours = distanceInMeters / 5000; // 5 km/h
    String estimatedTime =
    (estimatedTimeInHours * 60).toStringAsFixed(0); // Convert to minutes

    // Open Google Maps
    String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&origin=${double.parse(currentPositions[0])},${double.parse(currentPositions[1])}&destination=${double.parse(positions[0])},${double.parse(positions[1])}&travelmode=driving';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }

    // // Show distance and time in a snackbar
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Distance: ${distanceInMeters / 1000} km, Estimated Time: $estimatedTime min')),
    // );
  }

  void sendMessage() async {

    if(!GlobalFunctions.hasValidLocation()){
      await getCurrentLocationAndSave();
    }
    final messagear = '''
🚨 للطوارئ
اسم المستخدم: ${GlobalFunctions.getUsername()}
البريد الإلكتروني: ${GlobalFunctions.getEmail()}
رابط الموقع: ${'https://www.google.com/maps/search/?api=1&query=${GlobalFunctions.getLat()},${GlobalFunctions.getLng()}'}
''';
    final messagen = '''
🚨 Emergency Alert
Username: ${GlobalFunctions.getUsername()}
Email: ${GlobalFunctions.getEmail()}
Location Link: ${'https://www.google.com/maps/search/?api=1&query=${GlobalFunctions.getLat()},${GlobalFunctions.getLng()}'}
''';
    String message = GlobalFunctions.getLangCode() == "ar" ? messagear : messagen;
    String phoneNumber = '+97339118187'; // Specify the phone number

    String url ='https://wa.me/${phoneNumber.replaceAll('+', '')}?text=${Uri.encodeComponent(message)}';
    // url = 'https://wa.me/${phoneNumber.replaceAll('+', '')}?text=${Uri.encodeComponent(message)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("❌ WhatsApp is not available or cannot launch the URL.");
    }
  }

  String formatDate(String dateString) {
    print('kjfkdgjfdhgd${dateString}');
    // Assuming the input date string is in a recognized format (e.g., "yyyy-MM-dd")
    DateTime dateTime = DateTime.parse(dateString);
    // Format it to "M/d/yyyy"
    return DateFormat('MM/d/yyyy').format(dateTime);
  }

  String formatTime(DateTime dateTime) {
    // Define the hour format
    String hourFormat = DateFormat('h:mm a').format(dateTime);

    // Replace AM/PM with Arabic equivalents
    hourFormat = hourFormat.replaceAll('AM', 'صباحا').replaceAll('PM', 'مساءا');

    return hourFormat;
  }

  void getLatLongByName(String name) {
    markers.clear();
    for (var location in locations) {
      if (location['name'] == name) {
        currentPosition.value =
        "${location['latitude']} ${location['longitude']}";
        _addMarker(location);
        animateToLocation();
        update();
        return; // Exit once the location is found
      }
    }
  }

  Future<void> fetchCampaign() async {
    try {
      // print('jfkgfjdgkfdjgfkdgjkhjgkjhgjhgkh');
      isLoading.value = true;
      var response = await _campingService.fetchCampaign();

      campaign.value = response;

      errorMainMessage.value = '';
      statusCode.value = 200;
      //  print('jfkgfjdgkfdjgfkdgjkhjgkjhgjhgkh${response.campaign!.guide}');
      update();

    } catch (e) {
      errorMainMessage.value = e.toString();
      statusCode.value = 500;
    } finally {
      isLoading.value = false;
    }
  }

  void uploadLocationPlaces(String name) {
    markers.clear();
    for (var guide in campaign.value.campaign!.guide!) {
      if (guide.title == name) {
        currentPosition.value =
        "${guide.location!.coordinates![0]} ${guide.location!.coordinates![1]}";
        _addMarkerForGuide(guide);
        animateToLocation();
        update();
      }
    }
  }

  void changePosition() {
    animateToLocation();
    update();
  }

  void _addMarker(Map<String, dynamic> location) {
    markers.add(
      Marker(
        onTap: onMarkerTapped,
        markerId: MarkerId(location['name']),
        position: LatLng(location['latitude'], location['longitude']),
      ),
    );
  }

  void _addMarkerForGuide(Guide guide) {
    markers.add(
      Marker(
        onTap: onMarkerTapped,
        markerId: MarkerId(guide.title),
        position: LatLng(
            guide.location!.coordinates![0], guide.location!.coordinates![1]),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      ),
    );
  }

  void animateToLocation() {
    var latLng = currentPosition.value.split(" ").map(double.parse).toList();
    if(mapController!=null) {
      mapController!
          .animateCamera(CameraUpdate.newLatLng(LatLng(latLng[0], latLng[1])));
    }
  }

  void increaseFontSize() {
    if (fontSize.value < 17) {
      fontSize.value += 1.0;
    }
  }

  void decreaseFontSize() {
    if (fontSize.value >= 12) {
      fontSize.value -= 1.0;
    }
  }

  Future<void> updateLocation() async {
    final position = currentPosition.value;
    if (position.isNotEmpty) {
      var latLng = position.split(" ").map(double.parse).toList();
      await fetchNearbyRestaurants(latLng[0], latLng[1]);
    }
  }



  Future<bool> _checkLocationService() async {
    bool serviceEnabled = await Location().serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Location().requestService();
    }
    return serviceEnabled;
  }

  void _addMarkerForCurrentLocation(LocationData locationData) {
    markers.add(
      Marker(
        markerId: MarkerId("current_location"),
        position: LatLng(locationData.latitude!, locationData.longitude!),
        onTap: onMarkerTapped,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(
          title: 'current_location'.tr,
          snippet: 'your_current_position'.tr,
        ),
      ),
    );

    print('📍 تمت إضافة علامة الموقع الحالي');
  }

  Future<void> fetchNearbyRestaurants(double lat, double lng) async {
    const String apiKey = 'AIzaSyCelGVfAwELSGcVjMiVTuPwMDiyhcByqBo';
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=1500&type=restaurant&key=$apiKey';

    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        restaurants.value = (data['results'] as List)
            .map((restaurant) => Restaurant.fromJson(restaurant))
            .toList();
        updateMarkers();
        update();
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      errorMainMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void updateMarkers() {
    markers.clear();
    for (var restaurant in restaurants) {
      markers.add(
        Marker(
          markerId: MarkerId(restaurant.name),
          position: LatLng(restaurant.lat, restaurant.lng),
          onTap: () {
            showRestaurantInfo.value = true;
            showMap.value = false;
            selectedRestaurant = restaurant;
            currentPosition.value="${restaurant.lat} ${restaurant.lng}";
            update();
          },
        ),
      );
    }
  }



  String getPhotoUrl(String photoReference) {
    const String apiKey = 'AIzaSyCelGVfAwELSGcVjMiVTuPwMDiyhcByqBo';
    return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$apiKey';
  }
}


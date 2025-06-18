import '../../../resources/type_def.dart';

class PrayersParams with Params {
  double? latitude;
  double? longitude;

  PrayersParams({
    this.latitude,
    this.longitude,
  });
  @override
  QueryParams getParams() {
    return {
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
      "method": "2"
    };
  }
}

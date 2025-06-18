import 'package:Al_Arqam/core/network/get_api.dart';
import 'package:Al_Arqam/models/home/prayer_times_model.dart';

import '../../../core/resources/type_def.dart';

class PrayerDataSource {
  Future<PrayerTimesModel> getPrayertimes(QueryParams params) async {
    GetApi postApi = GetApi(
        uri: Uri(
            host: "api.aladhan.com",
            queryParameters: params,
            path: "v1/timings",
            scheme: "https"),
        fromJson: prayerTimesModelFromJson);
    var result = await postApi.callRequest();
    return result;
  }
}

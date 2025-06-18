import 'package:Al_Arqam/core/network/api_variables.dart';
import 'package:Al_Arqam/core/network/delete_api.dart';
import 'package:Al_Arqam/core/network/get_api.dart';
import 'package:Al_Arqam/core/network/post_api.dart';
import 'package:Al_Arqam/core/resources/type_def.dart';
import 'package:Al_Arqam/models/general_model.dart';
import 'package:Al_Arqam/models/medicin/all_medicins_model.dart';
import 'package:Al_Arqam/models/medicin/medicin_details_model.dart';
import 'package:Al_Arqam/models/medicin/update_medicin_model.dart';

import '../../../core/network/put_api.dart';

class MedicinsReminderDataSource {
  Future<GeneralModel> deleteMedicin(String medicinId) async {
    DeleteApi deletApi = DeleteApi(
        uri: ApiVariables.deleteMedicin(
            path: "health-record/remove-medicine/$medicinId"),
        fromJson: generalModelFromJson);
    var result = await deletApi.callRequest();
    return result;
  }

  Future<UpdateMedicinModel> updateMedicin(
      String medicinId, BodyMap body) async {
    PutApi putApi = PutApi(
        body: body,
        uri: ApiVariables.updateMedicin(
            path: "health-record/update-medicine/$medicinId"),
        fromJson: updateMedicinModelFromJson);
    var result = await putApi.callRequest();
    return result;
  }

  Future<AllMedicinsModel> getMedicins() async {
    GetApi getApi = GetApi(
        uri: ApiVariables.getAllMedicins(), fromJson: allMedicinsModelFromJson);
    var result = await getApi.callRequest();
    return result;
  }

  Future<MedicinDetailsModel> addMedicin(BodyMap body) async {
    PostApi postApi = PostApi(
        body: body,
        uri: ApiVariables.addMedicin(),
        fromJson: medicinDetailsModelFromJson);
    var result = await postApi.callRequest();
    return result;
  }
}

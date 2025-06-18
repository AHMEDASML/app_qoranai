import 'package:Al_Arqam/models/medicin/all_medicins_model.dart';
import 'package:Al_Arqam/models/medicin/data_source/medicins_reminder_data_source.dart';
import 'package:Al_Arqam/models/medicin/medicin_details_model.dart';
import 'package:Al_Arqam/models/medicin/update_medicin_model.dart';

import '../../core/handling_error/handling_exception_manager.dart';
import '../../core/resources/type_def.dart';
import '../../models/general_model.dart';

abstract class MedicinsReminderController {
  DataResponse<GeneralModel> deleteMedicin(String medicinId);
  DataResponse<UpdateMedicinModel> updateMedicin(
      String medicinId, BodyMap body);
  DataResponse<MedicinDetailsModel> addMedicin(BodyMap body);
  DataResponse<AllMedicinsModel> getAllMedicins();
}

class MedicinsReminderControllerImp
    with HandlingExceptionManager
    implements MedicinsReminderController {
  final medicinDataSource = MedicinsReminderDataSource();

  @override
  DataResponse<MedicinDetailsModel> addMedicin(BodyMap body) {
    var result = wrapHandling(
      tryCall: () {
        return medicinDataSource.addMedicin(body);
      },
    );
    return result;
  }

  @override
  DataResponse<GeneralModel> deleteMedicin(String medicinId) {
    var result = wrapHandling(
      tryCall: () {
        return medicinDataSource.deleteMedicin(medicinId);
      },
    );
    return result;
  }

  @override
  DataResponse<AllMedicinsModel> getAllMedicins() {
    var result = wrapHandling(
      tryCall: () {
        return medicinDataSource.getMedicins();
      },
    );
    return result;
  }

  @override
  DataResponse<UpdateMedicinModel> updateMedicin(
      String medicinId, BodyMap body) {
    var result = wrapHandling(
      tryCall: () {
        return medicinDataSource.updateMedicin(medicinId, body);
      },
    );
    return result;
  }
}

import 'dart:async';
import 'dart:developer';

import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:Al_Arqam/controllers/medicins_reminder/medicins_reminder_controller.dart';
import 'package:Al_Arqam/core/app/params/medicins_reminder/update_medicin_body.dart';
import 'package:Al_Arqam/core/config/flutter_local_notification_config.dart';
import 'package:Al_Arqam/core/network/network_info.dart';

import 'package:Al_Arqam/models/medicin/all_medicins_model.dart';
import 'package:get/get.dart';

import 'package:meta/meta.dart';

part 'medicin_reminder_event.dart';
part 'medicin_reminder_state.dart';

class MedicinReminderBloc
    extends Bloc<MedicinReminderEvent, MedicinReminderState> {
  final medicinsReminderControllerImp = MedicinsReminderControllerImp();
  MedicinReminderBloc() : super(MedicinReminderState()) {
    on<GetAllMedicins>(_getAllMedicins);
    on<AddMedicin>(_addMedicin);
    on<DeleteMedicin>(_deleteMedicin);
    on<UpdateMedicin>(_updateMedicin);
  }
  FutureOr<void> _getAllMedicins(
      GetAllMedicins event, Emitter<MedicinReminderState> emit) async {
    emit(state.copyWith(allMedicinsStatus: AllMedicinsStatus.load));

    var connection = await checkRealConnection();
    if (connection) {
      var result = await medicinsReminderControllerImp.getAllMedicins();
      result.fold(
        (l) => emit(state.copyWith(
            allMedicinsStatus: AllMedicinsStatus.fail,
            messageErrorAllmedicins: l.message)),
        (r) => emit(state.copyWith(
          allMedicinsStatus: AllMedicinsStatus.succ,
          medicinsList: r.medicines,
        )),
      );
    } else {
      emit(state.copyWith(
          allMedicinsStatus: AllMedicinsStatus.fail,
          messageErrorAllmedicins: "No Internet"));
    }
  }

  FutureOr<void> _addMedicin(
      AddMedicin event, Emitter<MedicinReminderState> emit) async {
    emit(state.copyWith(addMedicinStatus: AddMedicinStatus.load));
    var connection = await checkRealConnection();
    if (connection) {
      var result =
          await medicinsReminderControllerImp.addMedicin(event.body.getBody());
      result.fold(
        (l) => emit(state.copyWith(
            addMedicinStatus: AddMedicinStatus.fail,
            messageErrorAddmedicin: l.message)),
        (r) async {
          // MainController().fetchMedicins();
          emit(state.copyWith(
            addMedicinStatus: AddMedicinStatus.succ,
          ));
         
          log("${event.dateTime}:00");
        //  
          // int notificationId = r.savedMedicine!.id.hashCode;
          await GlobalFunctions.setNotificationCount(GlobalFunctions.getNotificationCount()+1);
           print('GlobalFunctions.getNotificationCount()${GlobalFunctions.getNotificationCount()}');
           NotificationService().scheduleNotification(
    id: GlobalFunctions.getNotificationCount(),
     title: 'reminder_title'.tr,
    body: '${'dont_forget_take'.tr} ${event.body.name!} ${'now'.tr} ${'your_health_matters'.tr}',
    scheduledDate:event.dateTime,
  );
        },
      );
    } else {
      emit(state.copyWith(
          addMedicinStatus: AddMedicinStatus.fail,
          messageErrorAddmedicin: "No Internet"));
    }
  }

  FutureOr<void> _updateMedicin(
      UpdateMedicin event, Emitter<MedicinReminderState> emit) async {
    emit(state.copyWith(updateMedicinStatus: UpdateMedicinStatus.load));

    var connection = await checkRealConnection();
    if (connection) {
      var result = await medicinsReminderControllerImp.updateMedicin(
        event.medicinId,
        event.body.getBody(),
      );
      result.fold(
        (l) => emit(state.copyWith(
            updateMedicinStatus: UpdateMedicinStatus.fail,
            messageErrorUpdatemedicin: l.message)),
        (r) async {
          emit(state.copyWith(
            updateMedicinStatus: UpdateMedicinStatus.succ,
          ));
          log(" ${event.dateTime}:00");
          GlobalFunctions.setNotificationCount(GlobalFunctions.getNotificationCount()+1);
          // int notificationId = r.updatedMedicine!.id.hashCode;
          NotificationService().scheduleNotification(
    id: GlobalFunctions.getNotificationCount(),
    title: 'reminder_title'.tr,
    body: '${'dont_forget_take'.tr} ${event.body.name!} ${'now'.tr} ${'your_health_matters'.tr}',
    scheduledDate: event.dateTime,
  );
        },
      );
    } else {
      emit(state.copyWith(
          updateMedicinStatus: UpdateMedicinStatus.fail,
          messageErrorUpdatemedicin: "No Internet"));
    }
  }

  FutureOr<void> _deleteMedicin(
      DeleteMedicin event, Emitter<MedicinReminderState> emit) async {
    emit(state.copyWith(deleteMedicinStatus: DeleteMedicinStatus.load));

    var connection = await checkRealConnection();
    if (connection) {
      var result =
          await medicinsReminderControllerImp.deleteMedicin(event.medicinId);
      result.fold(
        (l) => emit(state.copyWith(
            deleteMedicinStatus: DeleteMedicinStatus.fail,
            messageErrorDeletemedicin: l.message)),
        (r) async {
          

          emit(state.copyWith(
            deleteMedicinStatus: DeleteMedicinStatus.succ,
          ));
         
        },
      );
    } else {
      emit(state.copyWith(
          deleteMedicinStatus: DeleteMedicinStatus.fail,
          messageErrorDeletemedicin: "No Internet"));
    }
  }
}

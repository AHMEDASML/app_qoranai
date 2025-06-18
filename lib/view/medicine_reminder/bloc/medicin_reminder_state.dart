// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'medicin_reminder_bloc.dart';

enum AllMedicinsStatus { init, load, fail, succ }

enum AddMedicinStatus { init, load, fail, succ }

enum DeleteMedicinStatus { init, load, fail, succ }

enum UpdateMedicinStatus { init, load, fail, succ }

class MedicinReminderState {
  final String messageErrorAllmedicins;
  final AllMedicinsStatus allMedicinsStatus;
  final List<MedicineElement> medicinsList;
  final AddMedicinStatus addMedicinStatus;
  final String messageErrorAddmedicin;
  final DeleteMedicinStatus deleteMedicinStatus;
  final String messageErrorDeletemedicin;
  final UpdateMedicinStatus updateMedicinStatus;
  final String messageErrorUpdatemedicin;

  MedicinReminderState(
      {this.messageErrorAllmedicins = "",
      this.allMedicinsStatus = AllMedicinsStatus.init,
      this.medicinsList = const [],
      this.addMedicinStatus = AddMedicinStatus.init,
      this.messageErrorAddmedicin = "",
      this.deleteMedicinStatus = DeleteMedicinStatus.init,
      this.messageErrorDeletemedicin = "",
      this.updateMedicinStatus = UpdateMedicinStatus.init,
      this.messageErrorUpdatemedicin = ""});

  MedicinReminderState copyWith(
      {String? messageErrorAllmedicins,
      AllMedicinsStatus? allMedicinsStatus,
      List<MedicineElement>? medicinsList,
      AddMedicinStatus? addMedicinStatus,
      DeleteMedicinStatus? deleteMedicinStatus,
      String? messageErrorDeletemedicin,
      String? messageErrorAddmedicin,
      UpdateMedicinStatus? updateMedicinStatus,
      String? messageErrorUpdatemedicin}) {
    return MedicinReminderState(
        deleteMedicinStatus: deleteMedicinStatus ?? this.deleteMedicinStatus,
        messageErrorDeletemedicin:
            messageErrorDeletemedicin ?? this.messageErrorDeletemedicin,
        addMedicinStatus: addMedicinStatus ?? this.addMedicinStatus,
        messageErrorAddmedicin:
            messageErrorAddmedicin ?? this.messageErrorAddmedicin,
        messageErrorAllmedicins:
            messageErrorAllmedicins ?? this.messageErrorAllmedicins,
        allMedicinsStatus: allMedicinsStatus ?? this.allMedicinsStatus,
        medicinsList: medicinsList ?? this.medicinsList,
        messageErrorUpdatemedicin:
            messageErrorUpdatemedicin ?? this.messageErrorUpdatemedicin,
        updateMedicinStatus: updateMedicinStatus ?? this.updateMedicinStatus);
  }
}

part of 'medicin_reminder_bloc.dart';

@immutable
sealed class MedicinReminderEvent {}

class GetAllMedicins extends MedicinReminderEvent {}

class DeleteMedicin extends MedicinReminderEvent {
  final String medicinId;

  DeleteMedicin({required this.medicinId});
}

class AddMedicin extends MedicinReminderEvent {
  final UpdateMedicinBody body;
  final DateTime dateTime;

  AddMedicin({
    required this.body,
    required this.dateTime,
  });
}

class UpdateMedicin extends MedicinReminderEvent {
  final UpdateMedicinBody body;
  final String medicinId;
  final DateTime dateTime;

  UpdateMedicin({
    required this.dateTime,
    required this.body,
    required this.medicinId,
  });
}

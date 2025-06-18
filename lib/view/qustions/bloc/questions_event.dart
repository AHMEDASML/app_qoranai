part of 'questions_bloc.dart';

@immutable
sealed class QuestionsEvent {}

class QuestionsTypeEvent extends QuestionsEvent {
  final String type;

  QuestionsTypeEvent({required this.type});
}

class GetQuestionsEvent extends QuestionsEvent {
  final bool isReload;
  final InquiriesParams inquiriesParams;

  GetQuestionsEvent({required this.inquiriesParams, this.isReload = false});
}

class AddQuestionEvent extends QuestionsEvent {
  final AddInquiryBody addInquiryBody;

  AddQuestionEvent({required this.addInquiryBody});
}

class DeleteQuestionEvent extends QuestionsEvent {
  final String iquiryId;
  final int index;

  DeleteQuestionEvent({required this.iquiryId, required this.index});
}

class UpdateQuestionEvent extends QuestionsEvent {
  final String inquiryId;
  final UpdateInquiryBody updateInquiryBody;

  UpdateQuestionEvent(
      {required this.inquiryId, required this.updateInquiryBody});
}

class ResetQuestionsEvent extends QuestionsEvent {}

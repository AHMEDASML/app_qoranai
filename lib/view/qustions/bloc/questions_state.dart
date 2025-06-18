part of 'questions_bloc.dart';

@immutable
enum GetQuestionsStatus { succ, init, fail, load }

enum AddQuestionsStatus { succ, init, fail, load }

enum DeleteQuestionsStatus { succ, init, fail, load }

enum UpdateQuestionsStatus { succ, init, fail, load }

class QuestionsState {
  final GetQuestionsStatus getQuestionsStatus;
  final AddQuestionsStatus addQuestionsStatus;
  final DeleteQuestionsStatus deleteQuestionsStatus;
  final UpdateQuestionsStatus updateQuestionsStatus;
  final String type;
  final String message;
  final List<InquiryElement> inquiryList;
  final bool isEndpage;

  const QuestionsState(
      {this.getQuestionsStatus = GetQuestionsStatus.init,
      this.addQuestionsStatus = AddQuestionsStatus.init,
      this.deleteQuestionsStatus = DeleteQuestionsStatus.init,
      this.updateQuestionsStatus = UpdateQuestionsStatus.init,
      this.type = 'public',
      this.message = "",
      this.inquiryList = const [],
      this.isEndpage = false});

  QuestionsState copyWith(
      {GetQuestionsStatus? getQuestionsStatus,
      AddQuestionsStatus? addQuestionsStatus,
      DeleteQuestionsStatus? deleteQuestionsStatus,
      UpdateQuestionsStatus? updateQuestionsStatus,
      String? type,
      String? message,
      List<InquiryElement>? inquiryList,
      bool? isEndpage}) {
    return QuestionsState(
        getQuestionsStatus: getQuestionsStatus ?? this.getQuestionsStatus,
        addQuestionsStatus: addQuestionsStatus ?? this.addQuestionsStatus,
        deleteQuestionsStatus:
            deleteQuestionsStatus ?? this.deleteQuestionsStatus,
        updateQuestionsStatus:
            updateQuestionsStatus ?? this.updateQuestionsStatus,
        type: type ?? this.type,
        message: message ?? this.message,
        inquiryList: inquiryList ?? this.inquiryList,
        isEndpage: isEndpage ?? this.isEndpage);
  }
}

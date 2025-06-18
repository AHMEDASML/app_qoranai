import 'package:Al_Arqam/core/handling_error/handling_exception_manager.dart';
import 'package:Al_Arqam/core/resources/type_def.dart';
import 'package:Al_Arqam/models/general_model.dart';
import 'package:Al_Arqam/models/questions/data_source/questions_data_source.dart';
import 'package:Al_Arqam/models/questions/questions_model.dart';

abstract class InquiriesController {
  DataResponse<QusetionModel> getInquiries(QueryParams params);
  DataResponse<GeneralModel> addInquiry(BodyMap body);
  DataResponse<GeneralModel> deleteInquiry({required String inquiryId});
  DataResponse<GeneralModel> updateInquiry(String inquiryId, BodyMap body);
}

class InquiriesControllerImp
    with HandlingExceptionManager
    implements InquiriesController {
  final _questionsDataSource = QuestionsDataSource();

  @override
  DataResponse<QusetionModel> getInquiries(QueryParams params) {
    return wrapHandling(
      tryCall: () async {
        var result = await _questionsDataSource.getInquiries(params);
        return result;
      },
    );
  }

  @override
  DataResponse<GeneralModel> addInquiry(BodyMap body) {
    return wrapHandling(
      tryCall: () async {
        var result = await _questionsDataSource.addInquiry(body);
        return result;
      },
    );
  }

  @override
  DataResponse<GeneralModel> deleteInquiry({required String inquiryId}) {
    return wrapHandling(
      tryCall: () async {
        var result =
            await _questionsDataSource.deleteInquiry(inquiryId: inquiryId);
        return result;
      },
    );
  }

  @override
  DataResponse<GeneralModel> updateInquiry(String inquiryId, BodyMap body) {
    return wrapHandling(
      tryCall: () async {
        var result = await _questionsDataSource.updateInquiry(inquiryId, body);
        return result;
      },
    );
  }
}

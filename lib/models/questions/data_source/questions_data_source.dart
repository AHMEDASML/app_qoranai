import 'dart:developer';

import 'package:Al_Arqam/core/network/api_variables.dart';
import 'package:Al_Arqam/core/network/delete_api.dart';
import 'package:Al_Arqam/core/network/get_api.dart';
import 'package:Al_Arqam/core/network/post_api.dart';
import 'package:Al_Arqam/core/network/put_api.dart';
import 'package:Al_Arqam/core/resources/type_def.dart';
import 'package:Al_Arqam/models/general_model.dart';
import 'package:Al_Arqam/models/questions/questions_model.dart';

class QuestionsDataSource {
  Future<QusetionModel> getInquiries(QueryParams params) async {
    GetApi getApi = GetApi(
        uri: ApiVariables.getInquiries(params: params),
        fromJson: qusetionModelFromJson);
    log(getApi.uri.toString());

    var resulte = await getApi.callRequest();
    return resulte;
  }

  Future<GeneralModel> addInquiry(BodyMap body) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.addInquiry(),
        body: body,
        fromJson: generalModelFromJson);
    log(postApi.uri.toString());
    var result = await postApi.callRequest();
    return result;
  }

  Future<GeneralModel> deleteInquiry({required String inquiryId}) async {
    DeleteApi deleteApi = DeleteApi(
        uri: ApiVariables.deleteInquiry(inquiryId: inquiryId),
        fromJson: generalModelFromJson);
    log(deleteApi.uri.toString());
    var result = await deleteApi.callRequest();
    return result;
  }

  Future<GeneralModel> updateInquiry(String inquiryId, BodyMap body) async {
    PutApi putApi = PutApi(
        uri: ApiVariables.updateInquiry(inquiryId: inquiryId),
        body: body,
        fromJson: generalModelFromJson);
    log(putApi.uri.toString());
    var result = await putApi.callRequest();
    return result;
  }
}

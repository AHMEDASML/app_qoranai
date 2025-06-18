import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:Al_Arqam/controllers/inquiries/inquiries_controller.dart';
import 'package:Al_Arqam/core/app/params/inquiries/add_inquiry_body.dart';
import 'package:Al_Arqam/core/app/params/inquiries/inquiries_params.dart';
import 'package:Al_Arqam/core/app/params/inquiries/update_inquiry_body.dart';
import 'package:Al_Arqam/core/network/network_info.dart';
import 'package:Al_Arqam/models/questions/questions_model.dart';
import 'dart:developer';
part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final _inquiriesControllerImp = InquiriesControllerImp();
  final int _limit = 10;
  QuestionsBloc() : super(const QuestionsState()) {
    on<QuestionsTypeEvent>((event, emit) {
      emit(state.copyWith(
        type: event.type,
        getQuestionsStatus: GetQuestionsStatus.init,
        inquiryList: [],
        message: "",
      ));
    });
    on<ResetQuestionsEvent>((event, emit) {
      emit(state.copyWith(
          getQuestionsStatus: GetQuestionsStatus.init,
          inquiryList: [],
          message: ""));
    });
    on<GetQuestionsEvent>(_mapQuestionsEvent);

    on<AddQuestionEvent>(_addQuestionEvent);

    on<DeleteQuestionEvent>(_deleteQuestionEvent);

    on<UpdateQuestionEvent>(_updateQuestionEvent);
  }

  FutureOr<void> _mapQuestionsEvent(
      GetQuestionsEvent event, Emitter<QuestionsState> emit) async {
    var connection = await checkRealConnection();
    if (connection) {
      if (state.getQuestionsStatus == GetQuestionsStatus.init ||
          event.isReload == true) {
        print("--------Start---------------");
        emit(state.copyWith(
            type: event.inquiriesParams.type.toString(),
            getQuestionsStatus: GetQuestionsStatus.load,
            deleteQuestionsStatus: DeleteQuestionsStatus.init,
            inquiryList: []));
        var result = await _inquiriesControllerImp.getInquiries({
          'type': event.inquiriesParams.type.toString(),
          'startIndex': '0',
          'limit': _limit.toString(),
          'searchTerm': event.inquiriesParams.searchTerm.toString()
        });
        result.fold((failure) {
          emit(
            state.copyWith(
                getQuestionsStatus: GetQuestionsStatus.fail,
                message: failure.message),
          );
          print("++++++++++++++++++++++++++++++++++++++++");
          print(failure.message);
        }, (response) {
          print("************************************");
          print(response.inquiries!.length);
          return emit(
            state.copyWith(
                getQuestionsStatus: GetQuestionsStatus.succ,
                inquiryList: response.inquiries!,
                isEndpage: response.inquiries!.length < _limit),
          );
        });
      } else if (!state.isEndpage) {
        emit(state.copyWith(getQuestionsStatus: GetQuestionsStatus.load));
        var result = await _inquiriesControllerImp.getInquiries({
          'type': event.inquiriesParams.type!,
          'startIndex': '${state.inquiryList.length}',
          'limit': _limit.toString(),
          'searchTerm': event.inquiriesParams.searchTerm.toString()
        });
        result.fold(
            (failure) => emit(
                  state.copyWith(
                      getQuestionsStatus: GetQuestionsStatus.fail,
                      message: failure.message),
                ), (response) {
          return emit(
            state.copyWith(
                getQuestionsStatus: GetQuestionsStatus.succ,
                inquiryList: List.of(state.inquiryList)
                  ..addAll(response.inquiries!),
                isEndpage: response.inquiries!.length < _limit),
          );
        });
      }
    } else {
      log("No Internet");
      emit(state.copyWith(
          getQuestionsStatus: GetQuestionsStatus.fail, message: "No Internet"));
    }
  }

  FutureOr<void> _deleteQuestionEvent(
      DeleteQuestionEvent event, Emitter<QuestionsState> emit) async {
    var connection = await checkRealConnection();
    if (connection) {
      emit(state.copyWith(deleteQuestionsStatus: DeleteQuestionsStatus.load));

      var result = await _inquiriesControllerImp.deleteInquiry(
          inquiryId: event.iquiryId);

      result.fold(
          (failure) => emit(
                state.copyWith(
                    deleteQuestionsStatus: DeleteQuestionsStatus.fail,
                    message: failure.message),
              ), (response) {
        state.inquiryList.removeAt(event.index);
        return emit(
          state.copyWith(
            deleteQuestionsStatus: DeleteQuestionsStatus.succ,
          ),
        );
      });
    } else {
      log("No Internet");
      emit(state.copyWith(
          deleteQuestionsStatus: DeleteQuestionsStatus.fail,
          message: "No Internet"));
    }
  }

  FutureOr<void> _addQuestionEvent(
      AddQuestionEvent event, Emitter<QuestionsState> emit) async {
    var connection = await checkRealConnection();
    if (connection) {
      emit(state.copyWith(addQuestionsStatus: AddQuestionsStatus.load));

      var result = await _inquiriesControllerImp
          .addInquiry(event.addInquiryBody.getBody());

      result.fold(
          (failure) => emit(
                state.copyWith(
                    addQuestionsStatus: AddQuestionsStatus.fail,
                    message: failure.message),
              ), (response) {
        return emit(
          state.copyWith(
            addQuestionsStatus: AddQuestionsStatus.succ,
          ),
        );
      });
    } else {
      log("No Internet");
      emit(state.copyWith(
          addQuestionsStatus: AddQuestionsStatus.fail, message: "No Internet"));
    }
  }

  FutureOr<void> _updateQuestionEvent(
      UpdateQuestionEvent event, Emitter<QuestionsState> emit) async {
    var connection = await checkRealConnection();
    if (connection) {
      emit(state.copyWith(updateQuestionsStatus: UpdateQuestionsStatus.load));

      var result = await _inquiriesControllerImp.updateInquiry(
          event.inquiryId, event.updateInquiryBody.getBody());

      result.fold(
          (failure) => emit(
                state.copyWith(
                    updateQuestionsStatus: UpdateQuestionsStatus.fail,
                    message: failure.message),
              ), (response) {
        return emit(
          state.copyWith(
            updateQuestionsStatus: UpdateQuestionsStatus.succ,
          ),
        );
      });
    } else {
      emit(state.copyWith(
          updateQuestionsStatus: UpdateQuestionsStatus.fail,
          message: "No Internet"));
      log("No Internet");
    }
  }
}

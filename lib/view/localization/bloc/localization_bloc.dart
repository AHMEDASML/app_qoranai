import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/global_functions.dart';
part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationState()) {
    on<InitializeLanguageEvent>(
      (event, emit) async {
        if (GlobalFunctions.getLangCode() != "" &&
            GlobalFunctions.getLangCode() != null) {
          if (GlobalFunctions.getLangCode() == "ar") {
            emit(state.copyWith(
                languageCode: "ar",
                isEnglish: false,
                localizationStatus: LocalizationStatus.init));
          } else if (GlobalFunctions.getLangCode() == "en") {
            emit(state.copyWith(
                languageCode: "en",
                isEnglish: true,
                localizationStatus: LocalizationStatus.init));
          }
        } else {
          Locale? lang = await Devicelocale.currentAsLocale;
          emit(state.copyWith(
              languageCode: lang!.languageCode,
              isEnglish: lang.languageCode == "en" ? true : false,
              localizationStatus: LocalizationStatus.init));
        }
      },
    );

    on<ChangeLanguageEvent>((event, emit) async {
      await GlobalFunctions.setLanguageCode(event.langCode);
      emit(state.copyWith(
          languageCode: event.langCode,
          isEnglish: event.isEnglish,
          localizationStatus: LocalizationStatus.succ));
    });
  }
}

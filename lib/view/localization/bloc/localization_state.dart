// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'localization_bloc.dart';

enum LocalizationStatus { init, succ, fail, load }

class LocalizationState {
  final String languageCode;
  final LocalizationStatus localizationStatus;
  final bool isEnglish;

  LocalizationState({
    this.languageCode = "",
    this.isEnglish = false,
    this.localizationStatus = LocalizationStatus.init,
  });

  LocalizationState copyWith({
    String? languageCode,
    LocalizationStatus? localizationStatus,
    bool? isEnglish,
  }) {
    return LocalizationState(
      languageCode: languageCode ?? this.languageCode,
      localizationStatus: localizationStatus ?? this.localizationStatus,
      isEnglish: isEnglish ?? this.isEnglish,
    );
  }
}

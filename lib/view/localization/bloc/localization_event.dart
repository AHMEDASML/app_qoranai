part of 'localization_bloc.dart';

sealed class LocalizationEvent {}

class InitializeLanguageEvent extends LocalizationEvent {}

class ChangeLanguageEvent extends LocalizationEvent {
  final bool isEnglish;
  final String langCode;

  ChangeLanguageEvent({required this.isEnglish, required this.langCode});
}

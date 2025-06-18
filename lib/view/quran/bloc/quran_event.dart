part of 'quran_bloc.dart';

@immutable
sealed class QuranEvent {}

class GetAllChapters extends QuranEvent {}

class GetAllJuzs extends QuranEvent {}

class GetVerses extends QuranEvent {
  final VersesParam versesParam;

  GetVerses({required this.versesParam});
}

class AddQuranNote extends QuranEvent {
  final String note;

  AddQuranNote({required this.note});
}

class DeleteQuranNote extends QuranEvent {
  final String noteId;

  DeleteQuranNote({required this.noteId});
}

class GetAllQuranNote extends QuranEvent {}
class IncreaseIndexEvent extends QuranEvent {
  IncreaseIndexEvent();
}

class DecreaseIndexEvent extends QuranEvent {
  DecreaseIndexEvent();
}
class ChangeIndexEvent extends QuranEvent {
  final int index;
  ChangeIndexEvent(this.index);
}

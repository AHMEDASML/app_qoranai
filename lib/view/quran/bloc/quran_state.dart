// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quran_bloc.dart';

enum AllJuzsStatus { init, load, fail, succ }

enum AllChaptersStatus { init, load, fail, succ }

enum AllVersesStatus { init, load, fail, succ }

class QuranState {
  final String messageErrorJuzs;
  final List<Juz> juzsList;
  final String messageErrorChapters;
  final List<Chapter> chaptersList;
  final String messageErrorVerses;
  final List<Verse> versesList;
  final bool isEndPage;
   final int index;
  final AllChaptersStatus allChaptersStatus;
  final AllJuzsStatus allJuzsStatus;
  final AllVersesStatus allVersesStatus;
  final List<String> notesList;
  final List<String> notesIdList;

  QuranState({
    this.notesList = const [],
    this.notesIdList = const [],
    this.messageErrorJuzs = "",
    this.juzsList = const [],
    this.messageErrorChapters = "",
    this.chaptersList = const [],
    this.messageErrorVerses = "",
    this.index=0,
    this.versesList = const [],
    this.isEndPage = false,
    this.allChaptersStatus = AllChaptersStatus.init,
    this.allJuzsStatus = AllJuzsStatus.init,
    this.allVersesStatus = AllVersesStatus.init,
  });

  QuranState copyWith({
    String? messageErrorJuzs,
    List<Juz>? juzsList,
    List<String>? notesList,
    List<String>? notesIdList,
    String? messageErrorChapters,
    List<Chapter>? chaptersList,
    String? messageErrorVerses,
    List<Verse>? versesList,
    bool? isEndPage,
    int? index,
    AllChaptersStatus? allChaptersStatus,
    AllJuzsStatus? allJuzsStatus,
    AllVersesStatus? allVersesStatus,
  }) {
    return QuranState(
      index:index??this.index,
        notesList: notesList ?? this.notesList,
        notesIdList: notesIdList ?? this.notesIdList,
        messageErrorJuzs: messageErrorJuzs ?? this.messageErrorJuzs,
        juzsList: juzsList ?? this.juzsList,
        messageErrorChapters: messageErrorChapters ?? this.messageErrorChapters,
        chaptersList: chaptersList ?? this.chaptersList,
        messageErrorVerses: messageErrorVerses ?? this.messageErrorVerses,
        versesList: versesList ?? this.versesList,
        isEndPage: isEndPage ?? this.isEndPage,
        allChaptersStatus: allChaptersStatus ?? this.allChaptersStatus,
        allJuzsStatus: allJuzsStatus ?? this.allJuzsStatus,
        allVersesStatus: allVersesStatus ?? this.allVersesStatus);
  }
}

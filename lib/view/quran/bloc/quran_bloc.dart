import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:Al_Arqam/controllers/quran/quran_contoller.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/models/quran/chapter_model.dart';
import 'package:Al_Arqam/models/quran/verses_model.dart';
import 'package:meta/meta.dart';

import '../../../core/app/params/quran/verses_param.dart';
import '../../../core/network/network_info.dart';
import '../../../models/quran/juzs_model.dart';

part 'quran_event.dart';
part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  final quranControllerImp = QuranContollerImp();
  QuranBloc() : super(QuranState()) {
    on<GetAllJuzs>(_getAllJuzs);
    on<GetAllChapters>(_getAllChapters);
    on<GetVerses>(_getVerses);
    on<GetAllQuranNote>(_getAllNotes);
    on<DeleteQuranNote>(_deleteNote);
    on<AddQuranNote>(_addNote);
    

   
    on<ChangeIndexEvent>(_changeIndex);
  }
  void _changeIndex(ChangeIndexEvent event,Emitter<QuranState> emit){
emit(state.copyWith(index: event.index));

  }
  void _getAllNotes(GetAllQuranNote event, Emitter<QuranState> emit) async {
    List<String> noteList = await GlobalFunctions.getAllNote();
    List<String> noteIdList = await GlobalFunctions.getAllNoteId();
    emit(state.copyWith(notesList: noteList, notesIdList: noteIdList));
  }

  void _deleteNote(DeleteQuranNote event, Emitter<QuranState> emit) async {
    await GlobalFunctions.deleteNote(event.noteId);
    add(GetAllQuranNote());
  }

  void _addNote(AddQuranNote event, Emitter<QuranState> emit) async {
    await GlobalFunctions.setNote(event.note);
    add(GetAllQuranNote());
  }

  FutureOr<void> _getAllJuzs(GetAllJuzs event, Emitter<QuranState> emit) async {
    var connection = await checkRealConnection();
    if (connection) {
      var result = await quranControllerImp.getJuzs();
      result.fold(
        (l) => emit(state.copyWith(
            allJuzsStatus: AllJuzsStatus.fail, messageErrorJuzs: l.message)),
        (r) {
          var uniqueJuzs = r.juzs!
              .fold<Map<int, Juz>>({}, (map, juz) {
                map[juz.juzNumber!] = juz;
                return map;
              })
              .values
              .toList();

          emit(state.copyWith(
            allJuzsStatus: AllJuzsStatus.succ,
            juzsList: uniqueJuzs,
          ));
        },
      );
    } else {
      emit(state.copyWith(
          allJuzsStatus: AllJuzsStatus.fail, messageErrorJuzs: "No Internet"));
    }
  }

  FutureOr<void> _getAllChapters(
      GetAllChapters event, Emitter<QuranState> emit) async {
    emit(state.copyWith(allChaptersStatus: AllChaptersStatus.load));
    var connection = await checkRealConnection();
    if (connection) {
      var result = await quranControllerImp.getChapters();
      result.fold(
        (l) => emit(state.copyWith(
            allChaptersStatus: AllChaptersStatus.fail,
            messageErrorChapters: l.message)),
        (r) {
          // var uniqueJuzs = r.juzs!
          //     .fold<Map<int, Juz>>({}, (map, juz) {
          //       map[juz.juzNumber!] = juz;
          //       return map;
          //     })
          //     .values
          //     .toList();
          log(r.chapters![0].nameArabic.toString());
          emit(state.copyWith(
              allChaptersStatus: AllChaptersStatus.succ,
              chaptersList: r.chapters));
        },
      );
    } else {
      emit(state.copyWith(
          allChaptersStatus: AllChaptersStatus.fail,
          messageErrorChapters: "No Internet"));
    }
  }

  FutureOr<void> _getVerses(GetVerses event, Emitter<QuranState> emit) async {
    emit(state.copyWith(allVersesStatus: AllVersesStatus.load));
    var connection = await checkRealConnection();
    if (connection) {
      var result =
          await quranControllerImp.getVerses(event.versesParam.getParams());
      result.fold(
        (l) => emit(state.copyWith(
            allVersesStatus: AllVersesStatus.fail,
            messageErrorVerses: l.message)),
        (r) {
          // var uniqueJuzs = r.juzs!
          //     .fold<Map<int, Juz>>({}, (map, juz) {
          //       map[juz.juzNumber!] = juz;
          //       return map;
          //     })
          //     .values
          //     .toList();
          // log(r.verses![0].textUthmani.toString());
          emit(state.copyWith(
              allVersesStatus: AllVersesStatus.succ, versesList: r.verses));
        },
      );
    } else {
      emit(state.copyWith(
          allVersesStatus: AllVersesStatus.fail,
          messageErrorVerses: "No Internet"));
    }
  }
}

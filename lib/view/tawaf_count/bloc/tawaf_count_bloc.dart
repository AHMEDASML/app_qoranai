import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vibration/vibration.dart';

part 'tawaf_count_event.dart';
part 'tawaf_count_state.dart';

class TawafCountBloc extends Bloc<TawafCountEvent, TawafCountState> {
  TawafCountBloc() : super(const TawafCountState()) {
    on<IncreaseCountEvent>((event, emit) async {
      double count = state.count + 0.143;
      int round = state.round + 1;

      emit(state.copyWith(count: count, round: round));
      if (await Vibration.hasVibrator()) {
        if (round < 7) {
          Vibration.vibrate(duration: 50);
        } else if (round == 7) {
          Vibration.vibrate(duration: 500);
        }
      }
    });

    on<DecreaseCountEvent>((event, emit) async {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 50);
      }
      double count = state.count - 0.143;
      int round = state.round - 1;

      emit(state.copyWith(count: count, round: round));
    });

    on<StartEvent>((event, emit) {
      emit(state.copyWith(isStart: true));
    });
     on<FinishEvent>((event, emit) {
      emit(state.copyWith(isStart: false));
    });
     on<ClearState>((event, emit) {
       double count = 0;
      int round = 0;
      emit(state.copyWith(count: count, round: round));
    });
  }
}

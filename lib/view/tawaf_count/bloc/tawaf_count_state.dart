part of 'tawaf_count_bloc.dart';

@immutable
class TawafCountState {
  final double count;
  final int round;
  final bool isStart;

  const TawafCountState({this.count = 0, this.round = 0, this.isStart = false});

  TawafCountState copyWith({double? count, int? round, bool? isStart}) {
    return TawafCountState(
        count: count ?? this.count,
        round: round ?? this.round,
        isStart: isStart ?? this.isStart);
  }
}

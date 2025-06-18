part of 'tawaf_count_bloc.dart';

@immutable
sealed class TawafCountEvent {}

class IncreaseCountEvent extends TawafCountEvent {
  IncreaseCountEvent();
}

class DecreaseCountEvent extends TawafCountEvent {
  DecreaseCountEvent();
}

class StartEvent extends TawafCountEvent {
  StartEvent();
}
class FinishEvent extends TawafCountEvent {
  FinishEvent();
}
class ClearState extends TawafCountEvent {
  ClearState();
}

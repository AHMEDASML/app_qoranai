import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../core/resources/global_functions.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState()) {
    on<CheckAuthEvent>(_mapCheckAuthState);
  }
  FutureOr<void> _mapCheckAuthState(
      CheckAuthEvent event, Emitter<SplashState> emit) async {
    print(GlobalFunctions.isFirstOpen());
    if (GlobalFunctions.isFirstOpen()) {
      emit(state.copyWith(splashAuthStatus: SplashAuthStatus.firstOpen));
    } else if (GlobalFunctions.isVisitor()) {
      emit(state.copyWith(splashAuthStatus: SplashAuthStatus.visitor));
    } else if (GlobalFunctions.isAuth()) {
      emit(state.copyWith(splashAuthStatus: SplashAuthStatus.auth));
    } else {
      emit(state.copyWith(splashAuthStatus: SplashAuthStatus.unAuth));
    }
  }
}

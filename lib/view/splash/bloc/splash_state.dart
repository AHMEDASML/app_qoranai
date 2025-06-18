// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'splash_bloc.dart';

enum SplashAuthStatus { firstOpen, auth, unAuth, visitor }

class SplashState {
  final SplashAuthStatus splashAuthStatus;

  SplashState({this.splashAuthStatus = SplashAuthStatus.unAuth});

  SplashState copyWith({
    SplashAuthStatus? splashAuthStatus,
  }) {
    return SplashState(
      splashAuthStatus: splashAuthStatus ?? this.splashAuthStatus,
    );
  }
}

part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashLoginState extends SplashState {
  final bool isLogIn;
  SplashLoginState({required this.isLogIn});
}

final class SplashNoInternetConnection extends SplashState {}

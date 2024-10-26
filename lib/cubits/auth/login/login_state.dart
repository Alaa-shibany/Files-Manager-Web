part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginNoInternetState extends LoginState {}

final class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}

final class ShowPassword extends LoginState {
  final bool show;

  ShowPassword({required this.show});
}

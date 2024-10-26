part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {}

final class ChangePasswordExpiredToken extends ChangePasswordState {}

final class ChangePasswordFailure extends ChangePasswordState {
  final String errorMessage;

  ChangePasswordFailure({required this.errorMessage});
}

final class ShowPassword extends ChangePasswordState {
  final bool show;

  ShowPassword({required this.show});
}

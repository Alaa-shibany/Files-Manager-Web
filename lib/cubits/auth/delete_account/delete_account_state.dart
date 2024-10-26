part of 'delete_account_cubit.dart';

@immutable
sealed class DeleteAccountState {}

final class DeleteAccountInitial extends DeleteAccountState {}

final class DeleteAccountLoading extends DeleteAccountState {}

final class DeleteAccountSuccess extends DeleteAccountState {}

final class DeleteAccountFailure extends DeleteAccountState {
  final String errorMessage;

  DeleteAccountFailure({required this.errorMessage});
}

final class LogoutLoading extends DeleteAccountState {}

final class LogoutSuccess extends DeleteAccountState {}

final class LogoutFailure extends DeleteAccountState {
  final String errorMessage;

  LogoutFailure({required this.errorMessage});
}

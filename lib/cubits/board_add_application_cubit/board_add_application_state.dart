part of 'board_add_application_cubit.dart';

@immutable
sealed class BoardAddApplicationState {}

final class BoardAddApplicationInitial extends BoardAddApplicationState {}

final class BoardAddApplicationLoading extends BoardAddApplicationState {}

final class BoardAddApplicationSuccess extends BoardAddApplicationState {
  Application addedApplication;
  BoardAddApplicationSuccess({required this.addedApplication});
}

final class BoardAddApplicationExpiredToken extends BoardAddApplicationState {}

final class BoardAddApplicationFailure extends BoardAddApplicationState {
  final String errorMessage;

  BoardAddApplicationFailure({required this.errorMessage});
}

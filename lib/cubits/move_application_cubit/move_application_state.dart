part of 'move_application_cubit.dart';

@immutable
sealed class MoveApplicationState {}

final class MoveApplicationInitial extends MoveApplicationState {}

final class MoveApplicationLoadingState extends MoveApplicationState {
  final String loadingMessage;

  MoveApplicationLoadingState({required this.loadingMessage});
}

final class MoveApplicationSuccessState extends MoveApplicationState {}

final class CopyApplicationSuccessState extends MoveApplicationState {}

final class DeleteTaskSuccessState extends MoveApplicationState {}

final class MoveApplicationFailedState extends MoveApplicationState {
  final String errorMessage;
  MoveApplicationFailedState({required this.errorMessage});
}

final class MoveApplicationExpiredState extends MoveApplicationState {}

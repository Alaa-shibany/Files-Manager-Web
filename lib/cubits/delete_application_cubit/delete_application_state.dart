part of 'delete_application_cubit.dart';

@immutable
sealed class DeleteApplicationState {}

final class DeleteApplicationInitial extends DeleteApplicationState {}

final class DeleteApplicationLoadingState extends DeleteApplicationState {
  final String loadingMessage;

  DeleteApplicationLoadingState({required this.loadingMessage});
}

final class DeleteApplicationSuccessState extends DeleteApplicationState {}

final class DeleteTaskSuccessState extends DeleteApplicationState {}

final class DeleteApplicationFailedState extends DeleteApplicationState {
  final String errorMessage;
  DeleteApplicationFailedState({required this.errorMessage});
}

final class DeleteApplicationExpiredState extends DeleteApplicationState {}

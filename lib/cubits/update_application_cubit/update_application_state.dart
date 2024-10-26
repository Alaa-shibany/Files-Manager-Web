part of 'update_application_cubit.dart';

@immutable
sealed class UpdateApplicationState {}

final class UpdateApplicationInitial extends UpdateApplicationState {}

final class UpdateApplicationLoadingState extends UpdateApplicationState {
  final String loadingMessage;

  UpdateApplicationLoadingState({required this.loadingMessage});
}

final class UpdateApplicationSuccessState extends UpdateApplicationState {}

final class DeleteTaskSuccessState extends UpdateApplicationState {}

final class UpdateApplicationFailedState extends UpdateApplicationState {
  final String errorMessage;
  UpdateApplicationFailedState({required this.errorMessage});
}

final class UpdateApplicationExpiredState extends UpdateApplicationState {}

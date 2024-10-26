part of 'update_task_cubit.dart';

@immutable
sealed class UpdateTaskState {}

final class UpdateTaskInitial extends UpdateTaskState {}

final class UpdateTaskLoadingState extends UpdateTaskState {
  final String loadingMessage;

  UpdateTaskLoadingState({required this.loadingMessage});
}

final class UpdateTaskSuccessState extends UpdateTaskState {}

final class DeleteTaskSuccessState extends UpdateTaskState {}

final class UpdateTaskFailedState extends UpdateTaskState {
  final String errorMessage;
  UpdateTaskFailedState({required this.errorMessage});
}

final class UpdateTaskExpiredState extends UpdateTaskState {}

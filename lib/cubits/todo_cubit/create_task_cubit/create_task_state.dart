part of 'create_task_cubit.dart';

@immutable
sealed class CreateTaskState {}

final class CreateTaskInitial extends CreateTaskState {}

final class CreateTaskLoadingState extends CreateTaskState {}

final class CreateTaskUpdateLoadingState extends CreateTaskState {}

final class CreateTaskSuccessState extends CreateTaskState {
  final TaskModel newTaskModel;
  CreateTaskSuccessState({required this.newTaskModel});
}

final class CreateTaskUpdateSuccessState extends CreateTaskState {
  final TaskModel taskModel;
  CreateTaskUpdateSuccessState({required this.taskModel});
}

final class CreateTaskFailedState extends CreateTaskState {
  final String errorMessage;
  CreateTaskFailedState({required this.errorMessage});
}

final class CreateTaskExpiredState extends CreateTaskState {}

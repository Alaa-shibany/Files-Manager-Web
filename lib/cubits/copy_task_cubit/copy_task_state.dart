part of 'copy_task_cubit.dart';

@immutable
sealed class CopyTaskState {}

final class CopyTaskInitial extends CopyTaskState {}

final class CopyTaskLoadingState extends CopyTaskState {}

final class CopyTaskSuccessState extends CopyTaskState {
  final TaskModel copiesTasks;
  CopyTaskSuccessState({required this.copiesTasks});
}

final class CopyTaskFailedState extends CopyTaskState {
  final String errorMessage;
  CopyTaskFailedState({required this.errorMessage});
}

final class CopyTaskExpiredState extends CopyTaskState {}

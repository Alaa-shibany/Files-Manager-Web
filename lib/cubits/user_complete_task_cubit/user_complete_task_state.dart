part of 'user_complete_task_cubit.dart';

@immutable
sealed class UserCompleteTaskState {}

final class UserCompleteTaskInitial extends UserCompleteTaskState {}

final class UserCompleteTaskLoadingState extends UserCompleteTaskState {}

final class UserCompleteTaskSuccessState extends UserCompleteTaskState {}

final class UserCompleteTaskFailedState extends UserCompleteTaskState {
  final String errorMessage;
  UserCompleteTaskFailedState({required this.errorMessage});
}

final class UserCompleteTaskExpiredState extends UserCompleteTaskState {}

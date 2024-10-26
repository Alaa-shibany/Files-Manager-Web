part of 'todo_cubit.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoEditData extends TodoState {}

final class TodoLoadingState extends TodoState {}

final class TodoServerState extends TodoState {}

final class TodoExpiredState extends TodoState {}

final class TodoNoInternetState extends TodoState {}

final class TodoSuccessState extends TodoState {
  final List<TaskModel> newTasks;
  final bool isReachMax;
  TodoSuccessState({required this.isReachMax, required this.newTasks});
}

final class TodoFailedState extends TodoState {
  final String errorMessage;
  TodoFailedState({required this.errorMessage});
}

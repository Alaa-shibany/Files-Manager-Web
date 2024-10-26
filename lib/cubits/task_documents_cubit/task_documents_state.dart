part of 'task_documents_cubit.dart';

@immutable
sealed class TaskDocumentsState {}

final class TaskDocumentsInitial extends TaskDocumentsState {}

final class TaskDocumentsSuccessState extends TaskDocumentsState {}

final class TaskDocumentsInternetState extends TaskDocumentsState {}

final class TaskDocumentsServerState extends TaskDocumentsState {}

final class TaskDocumentsFailedState extends TaskDocumentsState {
  final String errorMessage;
  TaskDocumentsFailedState({required this.errorMessage});
}

final class TaskDocumentsExpiredState extends TaskDocumentsState {}

final class TaskDocumentsLoadingState extends TaskDocumentsState {}

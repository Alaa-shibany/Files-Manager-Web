part of 'task_comments_cubit.dart';

@immutable
sealed class TaskCommentsState {}

final class TaskCommentsInitial extends TaskCommentsState {}

final class TaskCommentsSuccessState extends TaskCommentsState {
  final List<TaskComment> allComments;
  final bool isReachMax;
  TaskCommentsSuccessState(
      {required this.allComments, required this.isReachMax});
}

final class TaskCommentsInternetState extends TaskCommentsState {}

final class TaskCommentsSendMessageState extends TaskCommentsState {
  final DocumentModel documentModel;
  TaskCommentsSendMessageState({required this.documentModel});
}

final class TaskCommentsServerState extends TaskCommentsState {}

final class TaskCommentsFailedState extends TaskCommentsState {
  final String errorMessage;
  TaskCommentsFailedState({required this.errorMessage});
}

final class TaskCommentsExpiredState extends TaskCommentsState {}

final class TaskCommentsLoadingState extends TaskCommentsState {}

final class CommentsReplying extends TaskCommentsState {
  final TaskComment taskComment;

  CommentsReplying({required this.taskComment});
}

final class CommentsReplyCancelled extends TaskCommentsState {}

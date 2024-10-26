part of 'parent_boards_cubit.dart';

@immutable
sealed class ParentBoardsState {}

final class ParentBoardsInitial extends ParentBoardsState {}

final class ParentBoardsLoadingState extends ParentBoardsState {}

final class ParentBoardsServerState extends ParentBoardsState {}

final class ParentBoardsExpiredState extends ParentBoardsState {}

final class ParentBoardsNoInternetState extends ParentBoardsState {}

final class ParentBoardsSuccessState extends ParentBoardsState {
  final List<Board> newBoards;
  final bool isReachMax;
  ParentBoardsSuccessState({required this.isReachMax, required this.newBoards});
}

final class ParentBoardsFailedState extends ParentBoardsState {
  final String errorMessage;
  ParentBoardsFailedState({required this.errorMessage});
}

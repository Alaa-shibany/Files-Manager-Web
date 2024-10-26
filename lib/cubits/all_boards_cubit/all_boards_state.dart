part of 'all_boards_cubit.dart';

@immutable
sealed class AllBoardsState {}

final class AllBoardsInitial extends AllBoardsState {}

final class AllBoardsLoadingState extends AllBoardsState {}

final class AllBoardsServerState extends AllBoardsState {}

final class AllBoardsExpiredState extends AllBoardsState {}

final class AllBoardsNoInternetState extends AllBoardsState {}

final class AllBoardsSuccessState extends AllBoardsState {
  final List<Board> newBoards;
  final bool isReachMax;
  AllBoardsSuccessState({required this.isReachMax, required this.newBoards});
}

final class AllBoardsFailedState extends AllBoardsState {
  final String errorMessage;
  AllBoardsFailedState({required this.errorMessage});
}

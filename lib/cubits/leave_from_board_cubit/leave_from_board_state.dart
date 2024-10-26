part of 'leave_from_board_cubit.dart';

@immutable
sealed class LeaveFromBoardState {}

final class LeaveFromBoardInitial extends LeaveFromBoardState {}

final class LeaveFromBoardLoadingState extends LeaveFromBoardState {}

final class LeaveFromBoardSuccessState extends LeaveFromBoardState {
  final int index;
  LeaveFromBoardSuccessState({required this.index});
}

final class LeaveFromBoardFailedState extends LeaveFromBoardState {
  final String errorMessage;
  LeaveFromBoardFailedState({required this.errorMessage});
}

final class LeaveFromBoardFailure extends LeaveFromBoardState {
  final String errorMessage;
  LeaveFromBoardFailure({required this.errorMessage});
}

final class LeaveFromBoardExpiredState extends LeaveFromBoardState {}

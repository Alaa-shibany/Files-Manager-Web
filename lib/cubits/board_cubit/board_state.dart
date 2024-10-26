part of 'board_cubit.dart';

@immutable
sealed class BoardState {}

final class BoardInitial extends BoardState {}

final class BoardSelectTap extends BoardState {}

final class BoardAddApplication extends BoardState {}

//Delete Application State
final class DeleteApplicationsInBoardLoading extends BoardState {}

final class DeleteApplicationsInBoardSuccess extends BoardState {}

final class DeleteApplicationsInBoardFailure extends BoardState {
  final String errorMessage;

  DeleteApplicationsInBoardFailure({required this.errorMessage});
}

final class DeleteApplicationsInBoardExpiredToken extends BoardState {}

//Move Application to another Board states
final class MoveApplicationsToBoardLoading extends BoardState {}

final class MoveApplicationsToBoardSuccess extends BoardState {}

final class MoveApplicationsToBoardFailure extends BoardState {
  final String errorMessage;

  MoveApplicationsToBoardFailure({required this.errorMessage});
}

final class MoveApplicationsToBoardExpiredToken extends BoardState {}

//Copy Application to another Board states
final class CopyApplicationsToBoardLoading extends BoardState {}

final class CopyApplicationsToBoardSuccess extends BoardState {}

final class CopyApplicationsToBoardFailure extends BoardState {
  final String errorMessage;

  CopyApplicationsToBoardFailure({required this.errorMessage});
}

final class CopyApplicationsToBoardExpiredToken extends BoardState {}

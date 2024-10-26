part of 'add_board_cubit.dart';

@immutable
sealed class AddBoardState {}

final class AddBoardInitial extends AddBoardState {}

final class AddBoardLoadingState extends AddBoardState {}

final class AddBoardSuccessState extends AddBoardState {
  final bool isSubBoard;
  final Board createdBoard;
  AddBoardSuccessState({required this.isSubBoard, required this.createdBoard});
}

final class AddBoardFailedState extends AddBoardState {
  final String errorMessage;
  AddBoardFailedState({required this.errorMessage});
}

final class AddBoardExpiredState extends AddBoardState {}

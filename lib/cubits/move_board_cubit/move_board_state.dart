part of 'move_board_cubit.dart';

@immutable
sealed class MoveBoardState {}

final class MoveBoardInitial extends MoveBoardState {}

final class MoveBoardLoadingState extends MoveBoardState {}

final class MoveBoardSuccessState extends MoveBoardState {}

final class MoveBoardFailedState extends MoveBoardState {
  final String errorMessage;
  MoveBoardFailedState({required this.errorMessage});
}

final class MoveBoardExpiredState extends MoveBoardState {}

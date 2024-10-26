part of 'board_favorite_cubit.dart';

@immutable
sealed class BoardFavoriteState {}

final class BoardFavoriteInitial extends BoardFavoriteState {}

final class ChangeOrderFavoriteLoading extends BoardFavoriteState {}

final class ChangeOrderFavoriteSuccess extends BoardFavoriteState {}

final class ChangeOrderFavoriteFailed extends BoardFavoriteState {
  final String errorMessage;
  ChangeOrderFavoriteFailed({required this.errorMessage});
}

final class AddBoardFavoriteLoading extends BoardFavoriteState {}

final class AddBoardFavoriteSuccess extends BoardFavoriteState {}

final class AddBoardFavoriteFailure extends BoardFavoriteState {
  final String errorMessage;

  AddBoardFavoriteFailure({required this.errorMessage});
}

final class AddBoardFavoriteExpiredToken extends BoardFavoriteState {}

final class RemoveBoardFavoriteLoading extends BoardFavoriteState {}

final class RemoveBoardFavoriteSuccess extends BoardFavoriteState {}

final class RemoveBoardFavoriteFailure extends BoardFavoriteState {
  final String errorMessage;

  RemoveBoardFavoriteFailure({required this.errorMessage});
}

final class GetBoardFavoriteLoading extends BoardFavoriteState {}

final class GetBoardFavoriteSuccess extends BoardFavoriteState {
  final List<Board> newBoards;
  final bool isReachMax;

  GetBoardFavoriteSuccess({required this.newBoards, required this.isReachMax});
}

final class GetBoardFavoriteFailure extends BoardFavoriteState {
  final String errorMessage;

  GetBoardFavoriteFailure({required this.errorMessage});
}

final class GetBoardFavoriteExpiredToken extends BoardFavoriteState {}

final class GetBoardFavoriteServerError extends BoardFavoriteState {}

final class GetBoardFavoriteNoInternet extends BoardFavoriteState {}

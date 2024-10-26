part of 'application_cubit.dart';

@immutable
sealed class ApplicationState {}

final class ApplicationInitial extends ApplicationState {}

final class GetAllApplicationsInBoardLoading extends ApplicationState {}

final class GetAllApplicationsInBoardSuccess extends ApplicationState {
  final List<Application> newBoardsApp;
  final bool isReachMax;

  GetAllApplicationsInBoardSuccess(
      {required this.newBoardsApp, required this.isReachMax});
}

final class GetAllApplicationsInBoardFailure extends ApplicationState {
  final String errorMessage;

  GetAllApplicationsInBoardFailure({required this.errorMessage});
}

final class GetAllApplicationsInBoardExpiredToken extends ApplicationState {}

final class GetAllApplicationsInBoardServerError extends ApplicationState {}

final class GetAllApplicationsInBoardNoInternet extends ApplicationState {}

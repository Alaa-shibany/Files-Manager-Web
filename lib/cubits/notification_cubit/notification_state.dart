part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoadingState extends NotificationState {}

final class NotificationSuccessState extends NotificationState {
  final bool isFromHive;
  final bool isServerBroken;
  NotificationSuccessState(
      {required this.isFromHive, required this.isServerBroken});
}

final class NotificationFaildState extends NotificationState {
  final String errorMessage;
  NotificationFaildState({required this.errorMessage});
}

final class NotificationNoInternetState extends NotificationState {}

final class NotificationServerBrokenState extends NotificationState {}

final class NotificationNoDataState extends NotificationState {
  final bool isFromHive;
  final bool isServerBroken;
  NotificationNoDataState(
      {required this.isFromHive, required this.isServerBroken});
}

final class NotificationExpiredState extends NotificationState {}

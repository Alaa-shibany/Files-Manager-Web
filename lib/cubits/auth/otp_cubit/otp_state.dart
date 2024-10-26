part of 'otp_cubit.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OtpLoadingState extends OtpState {}

final class OtpSuccessState extends OtpState {}

final class OtpFailedState extends OtpState {
  final String errorMessage;
  OtpFailedState({required this.errorMessage});
}

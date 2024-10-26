part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class SetProfileDetailsLoading extends ProfileState {}

final class ProfileImageUpdated extends ProfileState {
  final XFile? pickedFile;

  ProfileImageUpdated({required this.pickedFile});
}

final class SetProfileDetailsExpiredToken extends ProfileState {}

final class SetProfileDetailsSuccess extends ProfileState {}

final class SetProfileDetailsServerError extends ProfileState {}

final class SetProfileDetailsNoInternet extends ProfileState {}

final class SetProfileDetailsFailure extends ProfileState {
  final String errorMessage;

  SetProfileDetailsFailure({required this.errorMessage});
}

final class FetchCountryLoading extends ProfileState {}

final class FetchCountrySuccess extends ProfileState {}

final class FetchCountryServerError extends ProfileState {}

final class FetchCountryNoInternet extends ProfileState {}

final class FetchCountryExpiredToken extends ProfileState {}

final class FetchCountryFailure extends ProfileState {
  final String errorMessage;

  FetchCountryFailure({required this.errorMessage});
}

final class ProfileUpdated extends ProfileState {}

part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterSuccessState extends RegisterState {}

final class RegisterFailureState extends RegisterState {
  final String errorMessage;
  RegisterFailureState({required this.errorMessage});
}

final class ChangeUserNumberState extends RegisterState {}

final class RegisterSubscriptionUpdated extends RegisterState {
  final bool subscribe;

  RegisterSubscriptionUpdated({required this.subscribe});
}

final class RegisterImagePickedState extends RegisterState {}

final class RegisterCountryChanged extends RegisterState {}

final class RegisterLanguageChanged extends RegisterState {}

final class RegisterGenderChanged extends RegisterState {}

final class RegisterDateOfBirthChanged extends RegisterState {}

final class ShowPassword extends RegisterState {
  final bool show;
  ShowPassword({required this.show});
}

final class FetchDataLoading extends RegisterState {}

final class FetchDataSuccess extends RegisterState {}

final class FetchDataFailure extends RegisterState {
  final String errorMessage;

  FetchDataFailure({required this.errorMessage});
}

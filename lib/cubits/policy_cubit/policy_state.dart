part of 'policy_cubit.dart';

@immutable
sealed class PolicyState {}

final class PolicyInitial extends PolicyState {}

final class PolicyLoading extends PolicyState {}

final class PolicySuccess extends PolicyState {}

final class PolicyExpiredToken extends PolicyState {}

final class PolicyServerError extends PolicyState {}

final class PolicyNoInternet extends PolicyState {}

final class PolicyFailure extends PolicyState {
  final String errorMessage;

  PolicyFailure({required this.errorMessage});
}

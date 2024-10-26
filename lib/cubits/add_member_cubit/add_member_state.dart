part of 'add_member_cubit.dart';

@immutable
sealed class AddMemberState {}

final class AddMemberInitial extends AddMemberState {}

final class AddMemberLoadingState extends AddMemberState {}

final class AddMemberSuccessState extends AddMemberState {}

final class AddMemberFailedState extends AddMemberState {
  final String errorMessage;
  AddMemberFailedState({required this.errorMessage});
}

final class AddMemberExpiredState extends AddMemberState {}

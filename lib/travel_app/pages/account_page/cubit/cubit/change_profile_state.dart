part of 'change_profile_cubit.dart';

sealed class ChangeProfileState extends Equatable {
  const ChangeProfileState();

  @override
  List<Object> get props => [];
}

final class ChangeProfileInitial extends ChangeProfileState {}

final class ChangeProfileLoading extends ChangeProfileState {}

final class ChangeProfileSuccess extends ChangeProfileState {
  final UserModel user;

  ChangeProfileSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class ChangeProfileFailed extends ChangeProfileState {
  final String message;

  ChangeProfileFailed(this.message);

  @override
  List<Object> get props => [message];
}

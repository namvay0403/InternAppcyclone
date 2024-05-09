part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final UserModel user;
  const SignupSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class SignupFailed extends SignupState {
  final String message;
  const SignupFailed(this.message);

  @override
  List<Object> get props => [message];
}

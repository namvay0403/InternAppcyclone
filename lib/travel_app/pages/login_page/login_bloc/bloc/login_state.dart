part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginSuccess extends LoginState {
  final UserModel user;

  LoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}
final class LoginFailed extends LoginState {
  final String message;

  LoginFailed(this.message);

  @override
  List<Object> get props => [message];
}


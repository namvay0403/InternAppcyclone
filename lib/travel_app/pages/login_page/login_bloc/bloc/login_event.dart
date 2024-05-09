part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent(this.email, this.password);
  final String email;
  final String password;


  @override
  List<Object> get props => [];
}

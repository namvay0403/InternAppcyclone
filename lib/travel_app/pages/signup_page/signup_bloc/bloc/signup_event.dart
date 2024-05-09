part of 'signup_bloc.dart';

class SignupEvent extends Equatable {
  const SignupEvent(this.email, this.password, this.name, this.country, this.phoneNumber);
  final String email;
  final String password;
  final String name;
  final String country;
  final String phoneNumber;

  @override
  List<Object> get props => [];
}

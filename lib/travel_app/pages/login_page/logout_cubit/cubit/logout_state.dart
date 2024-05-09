part of 'logout_cubit.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutSuccess extends LogoutState {
}

final class LogoutFailed extends LogoutState {
  final String message;

  const LogoutFailed(this.message);

  @override
  List<Object> get props => [message];
}

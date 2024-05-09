import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intern_appcyclone/travel_app/authentication/repository/auth_repository.dart';

import '../../../../authentication/models/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      try {
        emit(LoginLoading());
        var response = await AuthRepository().signInWithEmailAndPassword(
            email: event.email, password: event.password);
        Future.delayed(const Duration(seconds: 1));
        emit(LoginSuccess(response));
      } catch (e) {
        print(e.toString());
        print(e.runtimeType);
        emit(LoginFailed(e.toString()));
      }
    });
  }
}

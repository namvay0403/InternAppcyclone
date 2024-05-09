import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intern_appcyclone/travel_app/authentication/models/user.dart';
import 'package:intern_appcyclone/travel_app/authentication/repository/auth_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>((event, emit) async {
      try {
        emit(SignupLoading());
        var response = await AuthRepository().signUpWithEmailAndPassword(
          email: event.email,
          password: event.password,
          name: event.name,
          country: event.country,
          phoneNumber: event.phoneNumber,
        );
        Future.delayed(const Duration(seconds: 2));
        emit(SignupSuccess(response));
      } catch (e) {
        emit(SignupFailed(e.toString()));
      }
    });
  }
}

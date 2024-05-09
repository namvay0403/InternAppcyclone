import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intern_appcyclone/travel_app/authentication/repository/auth_repository.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  Future<void> logout() async {
    try {
      emit(LogoutLoading());
      await AuthRepository().signOut();
      Future.delayed(const Duration(seconds: 1));
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailed(e.toString()));
    }
  }
}

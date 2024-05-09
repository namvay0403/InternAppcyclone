import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intern_appcyclone/travel_app/authentication/models/user.dart';

import '../../repository/account_page_repository.dart';

part 'change_profile_state.dart';

class ChangeProfileCubit extends Cubit<ChangeProfileState> {
  ChangeProfileCubit() : super(ChangeProfileInitial());

  void updateProfile(UserModel user) {
    emit(ChangeProfileLoading());
    try {
      AccountRepository().updateProfile(user);
      emit(ChangeProfileSuccess(user));
    } catch (e) {
      emit(ChangeProfileFailed(e.toString()));
    }
  }
}

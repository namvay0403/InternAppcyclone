import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user.dart';

class UserCubit extends Cubit<UserModel> {
  UserCubit() : super(UserModel());

  void setUser(UserModel user) {
    emit(user);
  }
}
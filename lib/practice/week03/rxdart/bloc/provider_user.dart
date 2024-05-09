import 'package:flutter/material.dart';
import 'package:intern_appcyclone/practice/week03/rxdart/bloc/user_bloc.dart';

class UserProvider extends InheritedWidget {
  UserProvider({super.key, required this.child})
      : userBloc = UserBloc(),
        super(child: child);

  final Widget child;
  final UserBloc userBloc;


  // static UserProvider? of(BuildContext context) {
  //   return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  // }

  static UserBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<UserProvider>()
            as UserProvider)
        .userBloc;
  }
  
  @override
  bool updateShouldNotify(UserProvider oldWidget) {
    // TODO: implement updateShouldNotify
    return userBloc == oldWidget.userBloc ? true : false;
  }

  // @override
  // bool updateShouldNotify(_) => false;
}

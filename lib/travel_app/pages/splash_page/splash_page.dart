import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/authentication/cubit/user_cubit.dart';
import 'package:intern_appcyclone/travel_app/authentication/models/user.dart';
import 'package:intern_appcyclone/travel_app/authentication/repository/auth_repository.dart';
import 'package:intern_appcyclone/travel_app/pages/home_page/home_page.dart';
import 'package:intern_appcyclone/travel_app/pages/onboarding_page/onboarding_view.dart';
import 'package:intern_appcyclone/travel_app/pages/login_page/login_page.dart';
import 'package:intern_appcyclone/utilities/const/const.dart';

import '../../../utilities/const/app_assets.dart';
import '../../navigation/navigation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.onBoarding});

  final bool onBoarding;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;

  checkLogin() {

    auth.currentUser != null ? isLogin = true : isLogin = false;
    auth.currentUser != null
        ? AuthRepository().readData(email: auth.currentUser!.email!).then((value) {
            context.read<UserCubit>().setUser(value);
          })
        : null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      onInit: () {},
      onEnd: () {},
      childWidget: Image.asset(AppAssets.splash),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: widget.onBoarding
          ? isLogin
              ? NavBar()
              : const LoginPage()
          : const OnboardingView(),
    );
  }
}

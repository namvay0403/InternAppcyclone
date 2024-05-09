import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/authentication/cubit/user_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/login_page/login_bloc/bloc/login_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/login_page/widget/social_button.dart';
import 'package:intern_appcyclone/travel_app/pages/signup_page/signup_page.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/button/linear_button.dart';
import 'package:intern_appcyclone/utilities/const/const.dart';
import 'package:intern_appcyclone/utilities/const/validate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utilities/const/app_assets.dart';
import '../../../utilities/textformfield/text_form_field.dart';
import '../../navigation/navigation.dart';
import '../forgot_password_page/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKeyLogin = GlobalKey<FormState>();
  TextEditingController emailController =
      TextEditingController(text: 'namvay4@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  ValueNotifier<bool> isCheck = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: appbarCustom(context, AppLocalizations.of(context)!.login,
          AppLocalizations.of(context)!.welcomeLogin),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailed) {
            AwesomeDialog(
              context: context,
              dismissOnTouchOutside: false,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: AppLocalizations.of(context)!.loginError,
              desc: state.message,
              btnOkOnPress: () {
                Navigator.pop(context);
              },
            ).show();
          }
          if (state is LoginLoading) {
            showDialog(
              context: context,
              builder: (_) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
          if (state is LoginSuccess) {
            context.read<UserCubit>().setUser(state.user);
            emailController.clear();
            passwordController.clear();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => NavBar()), (route) => false);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: formKeyLogin,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          TextFormFieldCustom(
                            controller: emailController,
                            hintText: AppLocalizations.of(context)!.enterEmail,
                            label: 'Email',
                            validatorFunc: Validate.validateEmail,
                          ),
                          const SizedBox(height: 20),
                          TextFormFieldCustom(
                            controller: passwordController,
                            hintText:
                                AppLocalizations.of(context)!.enterPassword,
                            label: AppLocalizations.of(context)!.password,
                            isObscure: true,
                            iconSuffix: Icons.visibility,
                            validatorFunc: Validate.validatePassword,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: isCheck,
                                    builder: (BuildContext context, bool value,
                                        Widget? child) {
                                      return Checkbox(
                                        value: value,
                                        onChanged: (bool? value) {
                                          isCheck.value = value!;
                                        },
                                      );
                                    },
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.rememberMe,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontApp,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) =>
                                          const ForgotPassWordPage()));
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.forgotPassword,
                                  style: const TextStyle(
                                      fontSize: 14, fontFamily: fontApp),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ButtonGradient(
                            onTap: () {
                              if (formKeyLogin.currentState!.validate()) {
                                context.read<LoginBloc>().add(LoginEvent(
                                      emailController.text,
                                      passwordController.text,
                                    ));
                              } else {
                                return;
                              }
                            },
                            text: AppLocalizations.of(context)!.login,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            fontsize: 16,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(children: <Widget>[
                      const Expanded(child: Divider()),
                      const SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context)!.orLoginWith,
                        style:
                            const TextStyle(fontSize: 14, fontFamily: fontApp),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(child: Divider()),
                    ]),
                    const SizedBox(height: 12),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: SocialButton(
                              text: 'Google',
                              textColor: Colors.black,
                              buttonColor: Colors.white,
                              image: AppAssets.gg,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: SocialButton(
                              text: 'Facebook',
                              textColor: Colors.white,
                              buttonColor: Color(0xFF3C5A9A),
                              image: AppAssets.fb,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const SignUpPage()));
                      },
                      child: Text.rich(
                        TextSpan(
                          text: AppLocalizations.of(context)!.dontHaveAccount,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: fontApp,
                          ),
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.signup,
                              style: const TextStyle(
                                fontFamily: fontBoldApp,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

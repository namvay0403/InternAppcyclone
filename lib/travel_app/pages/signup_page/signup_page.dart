import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/authentication/cubit/user_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/signup_page/signup_bloc/bloc/signup_bloc.dart';
import 'package:intern_appcyclone/travel_app/authentication/repository/auth_repository.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/button/linear_button.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:intern_appcyclone/utilities/textformfield/text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utilities/const/app_assets.dart';
import '../../../utilities/const/const.dart';
import '../../../utilities/const/validate.dart';
import '../../navigation/navigation.dart';
import '../login_page/widget/social_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKeySignUp = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  ValueNotifier<Country> country =
      ValueNotifier(CountryParser.parseCountryCode('VN'));

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    countryController.dispose();
    phoneController.dispose();
    country.dispose();
  }

  @override
  Widget build(BuildContext context) {
    countryController.text = country.value.name;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: appbarCustom(context, AppLocalizations.of(context)!.signup,
          AppLocalizations.of(context)!.signUpContent,
          isBack: true),
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupFailed) {
            AwesomeDialog(
              dismissOnTouchOutside: false,
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: AppLocalizations.of(context)!.error,
              desc: state.message,
              btnOkOnPress: () {
                Navigator.pop(context);
              },
            ).show();
          }
          if (state is SignupLoading) {
            showDialog(
              context: context,
              builder: (_) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
          if (state is SignupSuccess) {
            context.read<UserCubit>().setUser(state.user);
            AwesomeDialog(
              dismissOnTouchOutside: false,
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              title: AppLocalizations.of(context)!.signupSuccess,
              desc: AppLocalizations.of(context)!.welcome,
              btnOkOnPress: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => NavBar()));
              },
            ).show();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formKeySignUp,
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      TextFormFieldCustom(
                        hintText: AppLocalizations.of(context)!.name,
                        label: AppLocalizations.of(context)!.name,
                        controller: nameController,
                        validatorFunc: Validate.validateName,
                      ),
                      const SizedBox(height: 20),
                      ValueListenableBuilder(
                        valueListenable: country,
                        builder: (BuildContext context, dynamic value,
                            Widget? child) {
                          return TextFormFieldCustom(
                            hintText: AppLocalizations.of(context)!.country,
                            label: AppLocalizations.of(context)!.country,
                            controller: countryController,
                            validatorFunc: Validate.validateCountry,
                            readOnly: true,
                            iconPrefix: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                width: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  country.value.flagEmoji,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                favorite: ['VN'],
                                countryListTheme: CountryListThemeData(
                                  bottomSheetHeight: 600,
                                  borderRadius: BorderRadius.circular(20),
                                  inputDecoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.search,
                                        color: AppColor.primaryColor),
                                    hintText:
                                        AppLocalizations.of(context)!.search,
                                    border: InputBorder.none,
                                  ),
                                ),
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  countryController.text = country.name;
                                  this.country.value = country;
                                },
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      ValueListenableBuilder(
                        valueListenable: country,
                        builder: (BuildContext context, dynamic value,
                            Widget? child) {
                          return TextFormFieldCustom(
                            controller: phoneController,
                            hintText: AppLocalizations.of(context)!.phone,
                            label: AppLocalizations.of(context)!.phone,
                            keyboardType: TextInputType.phone,
                            iconPrefix: SizedBox(
                              height: 40,
                              width: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '+${country.value.phoneCode}',
                                    style: const TextStyle(
                                        fontFamily: fontBoldApp, fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            validatorFunc: Validate.validatePhone,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormFieldCustom(
                        controller: emailController,
                        hintText: AppLocalizations.of(context)!.enterEmail,
                        label: 'Email',
                        validatorFunc: Validate.validateEmail,
                      ),
                      const SizedBox(height: 20),
                      TextFormFieldCustom(
                        controller: passwordController,
                        hintText: AppLocalizations.of(context)!.enterPassword,
                        label: AppLocalizations.of(context)!.password,
                        isObscure: true,
                        iconSuffix: Icons.visibility,
                        validatorFunc: Validate.validatePassword,
                      ),
                      const SizedBox(height: 12),
                      contentPolicy(),
                      const SizedBox(height: 20),
                      ButtonGradient(
                        onTap: () {
                          if (formKeySignUp.currentState!.validate()) {
                            context.read<SignupBloc>().add(
                                  SignupEvent(
                                    emailController.text,
                                    passwordController.text,
                                    nameController.text,
                                    countryController.text,
                                    '+${country.value.phoneCode}${phoneController.text}',
                                  ),
                                );
                          }
                        },
                        text: AppLocalizations.of(context)!.signup,
                        fontsize: 16,
                        height: 50,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: <Widget>[
                  const Expanded(child: Divider()),
                  const SizedBox(width: 10),
                  Text(
                    AppLocalizations.of(context)!.orLoginWith,
                    style: const TextStyle(fontSize: 14, fontFamily: fontApp),
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
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget contentPolicy() {
    return const Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: 'By signing up, you agree to our ',
        style: TextStyle(
          fontSize: 14,
          fontFamily: fontApp,
        ),
        children: [
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(
              fontFamily: fontBoldApp,
              color: Colors.blue,
            ),
          ),
          TextSpan(
            text: ' and ',
            style: TextStyle(
              fontSize: 14,
              fontFamily: fontApp,
            ),
          ),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              fontFamily: fontBoldApp,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

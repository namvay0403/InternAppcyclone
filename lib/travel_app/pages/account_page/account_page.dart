import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/account_page/cubit/cubit/change_profile_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/account_page/widgets/avatar.dart';
import 'package:intern_appcyclone/travel_app/pages/login_page/login_bloc/bloc/login_bloc.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../login_page/login_page.dart';
import '../login_page/logout_cubit/cubit/logout_cubit.dart';
import 'widgets/dialog.dart';
import 'widgets/profile.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutCubit(),
      child: const AccountScreen(),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: appbarCustom(context, AppLocalizations.of(context)!.setting, ''),
      body: SingleChildScrollView(
        child: BlocListener<LogoutCubit, LogoutState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BlocProvider(
                            create: (context) => LoginBloc(),
                            child: const LoginPage(),
                          )),
                  (route) => false);
            }
            if (state is LogoutLoading) {
              showDialog(
                context: context,
                builder: (_) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }
            if (state is LogoutFailed) {
              AwesomeDialog(
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
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: BlocProvider(
              create: (context) => ChangeProfileCubit(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Avatar(),
                  const SizedBox(height: 20),
                  const Profile(),
                  const SizedBox(height: 20),
                  const LanguageWidget(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: AppLocalizations.of(context)!.logout,
                        desc: AppLocalizations.of(context)!.logoutConfirm,
                        btnCancelColor: Colors.red.withOpacity(0.5),
                        btnOkOnPress: () {
                          BlocProvider.of<LogoutCubit>(context).logout();
                        },
                        btnCancelOnPress: () {},
                      ).show();
                    },
                    child: Text(AppLocalizations.of(context)!.logout),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

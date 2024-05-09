import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/authentication/cubit/user_cubit.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/const/app_assets.dart';
import 'package:intern_appcyclone/utilities/const/const.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../practice/week02/localization/screen/language_screen.dart';
import '../../../utilities/const/colors.dart';
import 'widgets/appbar_home.dart';
import 'widgets/options.dart';
import 'widgets/places.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var userCubit = context.read<UserCubit>().state;
    print(userCubit.toJson());

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: appBarHome(
        context,
        '${AppLocalizations.of(context)!.hello}!',
        AppLocalizations.of(context)!.welcome,
        userCubit.photoURL!,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppColor.backgroundColor,
            child: Column(
              children: [
                // AppBarHome(
                //   title:
                //       '${AppLocalizations.of(context)!.hello}, ${userCubit.displayName}!',
                //   content: AppLocalizations.of(context)!.welcome,
                //   imageUrl: userCubit.photoURL!,
                // ),
                const SizedBox(height: 20),
                const OptionWidget(),
                const SizedBox(height: 20),
                heading(),
                const SizedBox(height: 20),
                const Places(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget heading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.popularDestination,
            style: AppStyle.heading.copyWith(color: Colors.black, fontSize: 20),
          ),
          Text(
            AppLocalizations.of(context)!.seeMore,
            style: AppStyle.heading.copyWith(color: AppColor.primaryColor),
          ),
        ],
      ),
    );
  }
}

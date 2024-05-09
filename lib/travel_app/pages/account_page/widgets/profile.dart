import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/travel_app/pages/account_page/widgets/change_profile.dart';
import 'package:intern_appcyclone/utilities/const/route.dart';

import '../../../../utilities/const/colors.dart';
import '../../../../utilities/const/page_name.dart';
import '../../../../utilities/const/styles.dart';
import '../../../authentication/cubit/user_cubit.dart';
import '../cubit/cubit/change_profile_cubit.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var userCubit = context.read<UserCubit>().state;
    var changeProfileCubit = context.read<ChangeProfileCubit>();
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed(PageName.ChangeProfile);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: changeProfileCubit,
                  child: const ChangeProfile(),
                )));
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userCubit.email!,
                textAlign: TextAlign.center,
                style: AppStyle.normal.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.change,
                textAlign: TextAlign.center,
                style: AppStyle.heading.copyWith(
                  color: AppColor.primaryColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

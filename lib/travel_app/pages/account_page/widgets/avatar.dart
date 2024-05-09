import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/authentication/cubit/user_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/account_page/cubit/cubit/change_profile_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/account_page/widgets/change_profile.dart';
import 'package:intern_appcyclone/utilities/const/app_assets.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    var userCubit = context.read<UserCubit>().state;
    return BlocBuilder<ChangeProfileCubit, ChangeProfileState>(
      builder: (context, state) {
        if (state is ChangeProfileSuccess) {
          return Column(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: userCubit.photoURL != null ? DecorationImage(
                    image: NetworkImage(userCubit.photoURL!),
                    fit: BoxFit.cover,
                  ) : const DecorationImage(
                    image: AssetImage(AppAssets.avatar),
                    fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                state.user.displayName!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }
        if (state is ChangeProfileInitial) {
          return Column(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: userCubit.photoURL != null
                      ? DecorationImage(
                          image: NetworkImage(userCubit.photoURL!),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage(AppAssets.avatar),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                userCubit.displayName.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

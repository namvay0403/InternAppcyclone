import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/travel_app/authentication/models/user.dart';
import 'package:intern_appcyclone/travel_app/pages/account_page/cubit/cubit/change_profile_cubit.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar_normal.dart';

import '../../../../utilities/button/linear_button.dart';
import '../../../../utilities/const/colors.dart';
import '../../../../utilities/const/const.dart';
import '../../../../utilities/const/styles.dart';
import '../../../../utilities/const/validate.dart';
import '../../../../utilities/textformfield/text_form_field.dart';
import '../../../authentication/cubit/user_cubit.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  final displayNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final countryController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ValueNotifier<Country> country =
      ValueNotifier(CountryParser.parseCountryCode('VN'));

  @override
  void dispose() {
    displayNameController.dispose();
    phoneNumberController.dispose();
    countryController.dispose();
    country.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    var userCubit = context.read<UserCubit>().state;
    displayNameController.text = userCubit.displayName ?? 'User';
    phoneNumberController.text = userCubit.phoneNumber ?? '1234567890';
    countryController.text = userCubit.country ?? 'Vietnam';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
          context, AppLocalizations.of(context)!.changeProfile, '',
          isBack: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: BlocConsumer<ChangeProfileCubit, ChangeProfileState>(
                  listener: (context1, state) {
                    if (state is ChangeProfileFailed) {
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
                    if (state is ChangeProfileLoading) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    }
                    if (state is ChangeProfileSuccess) {
                      context.read<UserCubit>().setUser(state.user);
                      AwesomeDialog(
                        dismissOnTouchOutside: false,
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: AppLocalizations.of(context)!.success,
                        desc: AppLocalizations.of(context)!.success,
                        btnOkOnPress: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ).show();
                    }
                  },
                  builder: (BuildContext context, ChangeProfileState state) {
                    return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        textFormField(
                          text: AppLocalizations.of(context)!.name,
                          controller: displayNameController,
                          hintText: AppLocalizations.of(context)!.name,
                          validateFunc: Validate.validateName,
                        ),
                        const SizedBox(height: 20),
                        textFormField(
                          text: AppLocalizations.of(context)!.phone,
                          controller: phoneNumberController,
                          hintText: AppLocalizations.of(context)!.phone,
                          validateFunc: Validate.validatePhone,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: country,
                            builder: (BuildContext context, dynamic value,
                                Widget? child) {
                              return TextFormField(
                                style: AppStyle.heading
                                    .copyWith(color: Colors.black),
                                controller: countryController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelStyle: AppStyle.heading.copyWith(
                                      color: Colors.grey, fontSize: 16),
                                  contentPadding: const EdgeInsets.all(12),
                                  labelText:
                                      AppLocalizations.of(context)!.country,
                                  hintStyle: AppStyle.normal.copyWith(
                                      color: Colors.grey, fontSize: 14),
                                  hintText:
                                      AppLocalizations.of(context)!.country,
                                  prefixIcon: GestureDetector(
                                    child: Container(
                                      height: 56,
                                      width: 50,
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
                                ),
                                readOnly: true,
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    showPhoneCode: false,
                                    countryListTheme: CountryListThemeData(
                                      bottomSheetHeight: 600,
                                      borderRadius: BorderRadius.circular(20),
                                      inputDecoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.search,
                                            color: AppColor.primaryColor),
                                        hintText: AppLocalizations.of(context)!
                                            .search,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    onSelect: (Country country) {
                                      countryController.text = country.name;
                                      this.country.value = country;
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        ButtonGradient(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              var userCubit = context.read<UserCubit>().state;
                              UserModel user = UserModel(
                                displayName: displayNameController.text.isEmpty
                                    ? userCubit.displayName
                                    : displayNameController.text,
                                phoneNumber: phoneNumberController.text.isEmpty
                                    ? userCubit.phoneNumber
                                    : phoneNumberController.text,
                                country: countryController.text.isEmpty
                                    ? userCubit.country
                                    : countryController.text,
                                email: userCubit.email,
                                photoURL:
                                    'https://th.bing.com/th/id/OIP.fUdURS8RFDOUKFvzrCEe_AHaHa?rs=1&pid=ImgDetMain',
                                id: userCubit.id,
                              );
                              context
                                  .read<ChangeProfileCubit>()
                                  .updateProfile(user);
                            }
                          },
                          text: AppLocalizations.of(context)!.change,
                          fontsize: 16,
                          height: 50,
                          width: double.infinity,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textFormField(
      {required String text,
      required TextEditingController controller,
      String? hintText,
      bool readOnly = false,
      String? Function(String?)? validateFunc,
      Function()? onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: TextFormField(
        style: AppStyle.heading.copyWith(color: Colors.black),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelStyle:
              AppStyle.heading.copyWith(color: Colors.grey, fontSize: 16),
          contentPadding: const EdgeInsets.all(12),
          labelText: text,
          hintStyle: AppStyle.normal.copyWith(color: Colors.grey, fontSize: 14),
          hintText: hintText ?? "",
        ),
        readOnly: readOnly,
        onTap: onTap,
        validator: validateFunc,
      ),
    );
  }
}

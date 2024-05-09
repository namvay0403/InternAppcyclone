import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/travel_app/authentication/models/user.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';

import '../../../../../utilities/appbar/appbar_normal.dart';
import '../../../../../utilities/button/linear_button.dart';
import '../../../../../utilities/const/const.dart';
import '../../../../../utilities/const/styles.dart';
import '../../../../../utilities/const/validate.dart';
import '../../../../../utilities/textformfield/text_form_field.dart';
import '../../../../authentication/cubit/user_cubit.dart';

class ChangeContact extends StatefulWidget {
  ChangeContact({super.key});

  @override
  State<ChangeContact> createState() => _ChangeContactState();
}

class _ChangeContactState extends State<ChangeContact> {
  final formKeySignUp = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var cubit = context.read<UserCubit>().state;
    nameController.text = cubit.displayName!;
    emailController.text = cubit.email!;
    phoneController.text = cubit.phoneNumber!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(context, AppLocalizations.of(context)!.setting, '',
          isBack: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              Form(
                key: formKeySignUp,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    textFormField(
                      text: AppLocalizations.of(context)!.name,
                      controller: nameController,
                      hintText: AppLocalizations.of(context)!.name,
                      validateFunc: Validate.validateName,
                    ),
                    const SizedBox(height: 20),
                    textFormField(
                      text: AppLocalizations.of(context)!.phone,
                      controller: phoneController,
                      hintText: AppLocalizations.of(context)!.phone,
                      keyboardType: true,
                      validateFunc: Validate.validatePhone,
                    ),
                    const SizedBox(height: 20),
                    textFormField(
                      text: 'Email',
                      controller: emailController,
                      hintText: 'Email',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ButtonGradient(
                  onTap: () {
                    if (formKeySignUp.currentState!.validate()) {
                      var cubit = context.read<UserCubit>().state;

                      UserModel user = UserModel(
                          displayName: nameController.text,
                          email: emailController.text,
                          id: cubit.id,
                          photoURL: cubit.photoURL,
                          country: cubit.country,
                          phoneNumber: phoneController.text);
                      context.read<UserCubit>().setUser(user);
                      AwesomeDialog(
                        dismissOnTouchOutside: false,
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: AppLocalizations.of(context)!.success,
                        desc: AppLocalizations.of(context)!.updateSuccess,
                        btnOkOnPress: () {
                          Navigator.pop(context);
                        },
                      ).show();
                      // Navigator.pop(context);
                    }
                  },
                  text: AppLocalizations.of(context)!.confirm),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFormField(
      {required String text,
      required TextEditingController controller,
      String? hintText,
      bool readOnly = false,
      bool keyboardType = false,
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
        keyboardType: keyboardType ? TextInputType.number : TextInputType.text,
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

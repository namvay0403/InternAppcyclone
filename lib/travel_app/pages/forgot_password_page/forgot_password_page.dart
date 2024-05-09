import 'package:flutter/material.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/button/linear_button.dart';
import 'package:intern_appcyclone/utilities/const/const.dart';
import 'package:intern_appcyclone/utilities/const/validate.dart';
import 'package:intern_appcyclone/utilities/textformfield/text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ForgotPassWordPage extends StatefulWidget {
  const ForgotPassWordPage({super.key});

  @override
  State<ForgotPassWordPage> createState() => _ForgotPassWordPageState();
}

class _ForgotPassWordPageState extends State<ForgotPassWordPage> {
  final formKeyForgot = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: appbarCustom(context, AppLocalizations.of(context)!.forgotPassword,
            AppLocalizations.of(context)!.contentForgotPassword,
            isBack: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Form(
            key: formKeyForgot,
            child: Column(
              children: [
                TextFormFieldCustom(
                  hintText: AppLocalizations.of(context)!.enterEmail,
                  label: 'Email',
                  controller: emailController,
                  validatorFunc: Validate.validateEmail,
                ),
                const SizedBox(height: 20),
                ButtonGradient(
                  onTap: () {
                    if (formKeyForgot.currentState!.validate()) {}
                  },
                  text: AppLocalizations.of(context)!.send,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  fontsize: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

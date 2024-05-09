import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/cubit/save_booking_info_cubit.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/const/page_name.dart';
import 'package:intern_appcyclone/utilities/const/route.dart';

import '../../../utilities/appbar/appbar_normal.dart';
import '../../../utilities/button/linear_button.dart';
import 'widgets/step2/payment_method.dart';
import 'widgets/step1/content_appbar.dart';

class CheckOutPageStep2 extends StatelessWidget {
  const CheckOutPageStep2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
          context,
          AppLocalizations.of(context)!.checkOut,
          ContentAppBar(
            step: 2,
            content: AppLocalizations.of(context)!.payment,
          ),
          isBack: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              PaymentMethod(),
              const SizedBox(height: 30),
              ButtonGradient(
                onTap: () {
                  if (context.read<SaveInfoBooking>().state.typePayment == '') {
                    AwesomeDialog(
                      dismissOnTouchOutside: false,
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: AppLocalizations.of(context)!.required,
                      desc:
                          AppLocalizations.of(context)!.pleaseChooseTypePayment,
                      btnOkOnPress: () {},
                    ).show();
                  } else {
                    Navigator.pushNamed(context, PageName.CheckOut3);
                  }
                },
                text: AppLocalizations.of(context)!.done,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

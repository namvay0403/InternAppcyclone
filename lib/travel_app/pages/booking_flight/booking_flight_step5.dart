import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/const/page_name.dart';

import '../../../utilities/button/linear_button.dart';
import '../checkout_page/widgets/step2/payment_method.dart';
import 'cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';
import 'widgets/step5/choose_payment_method.dart';

class BookingFlightStep5 extends StatelessWidget {
  const BookingFlightStep5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(context, AppLocalizations.of(context)!.checkOut, '',
          isBack: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              PaymentMethodBookingFlight(),
              const SizedBox(height: 30),
              ButtonGradient(
                onTap: () {
                  if (context
                          .read<SaveBookingFlightCubit>()
                          .state
                          .typePayment ==
                      '') {
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
                    Navigator.pushNamed(context, PageName.BookingFlightStep6);
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

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/widgets/step4/info_flight.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/widgets/step1/contact_detail.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/widgets/step1/promo_code.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar_normal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/utilities/button/linear_button.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:intern_appcyclone/utilities/const/page_name.dart';
import 'package:intern_appcyclone/utilities/const/route.dart';

import 'widgets/step4/info_passenger.dart';

class BookingFlightStep4 extends StatelessWidget {
  const BookingFlightStep4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(context, AppLocalizations.of(context)!.checkOut, '',
          isBack: true),
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              const InfoFlight(),
              const SizedBox(height: 20),
              const ContactDetail(),
              const SizedBox(height: 20),
              const InfoPassenger(),
              const SizedBox(height: 20),
              PromoCode(),
              const SizedBox(height: 20),
              ButtonGradient(
                onTap: () {
                  if (context
                      .read<SaveBookingFlightCubit>()
                      .state
                      .seat
                      .where((e) => e.id.isEmpty)
                      .isNotEmpty) {
                    AwesomeDialog(
                      dismissOnTouchOutside: false,
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: AppLocalizations.of(context)!.required,
                      desc: AppLocalizations.of(context)!.passportNotEmpty,
                      btnOkOnPress: () {},
                    ).show();
                  } else {
                    Navigator.pushNamed(context, PageName.BookingFlightStep5);
                  }
                },
                text: AppLocalizations.of(context)!.payment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

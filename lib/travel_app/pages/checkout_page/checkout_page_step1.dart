import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/cubit/save_booking_info_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/room_page/models/room_model.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar_normal.dart';
import 'package:intern_appcyclone/utilities/button/linear_button.dart';
import 'package:intern_appcyclone/utilities/const/app_assets.dart';
import 'package:intern_appcyclone/utilities/const/page_name.dart';
import 'package:intern_appcyclone/utilities/const/route.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/step3/info_room.dart';
import 'widgets/step1/contact_detail.dart';
import 'widgets/step1/content_appbar.dart';
import 'widgets/step1/promo_code.dart';
import 'widgets/step1/time_choose.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key, required this.roomModel});

  final RoomModel roomModel;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SaveInfoBooking>().state;
    return Scaffold(
      appBar: appbarCustom(
          context,
          AppLocalizations.of(context)!.checkOut,
          ContentAppBar(
              step: 1, content: AppLocalizations.of(context)!.bookAndReview),
          isBack: true, onTap: () {
        context.read<SaveInfoBooking>().initDataBooking();
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              InfoRoom(room: roomModel),
              const SizedBox(height: 20),
              const ContactDetail(),
              const SizedBox(height: 20),
              PromoCode(),
              const SizedBox(height: 20),
              TimeChoose(),
              const SizedBox(height: 30),
              ButtonGradient(
                  onTap: () {
                    cubit.hotelId = roomModel.hotel;
                    cubit.room = roomModel.name;
                    cubit.roomModel = roomModel;
                    if (cubit.dateStart == null || cubit.dateEnd == null) {
                      AwesomeDialog(
                        dismissOnTouchOutside: false,
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: AppLocalizations.of(context)!.error,
                        desc: AppLocalizations.of(context)!.pleaseChooseTime,
                        btnOkOnPress: () {},
                      ).show();
                    } else if (cubit.dateEnd!
                            .difference(cubit.dateStart!)
                            .inDays <
                        0) {
                      AwesomeDialog(
                        dismissOnTouchOutside: false,
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: AppLocalizations.of(context)!.error,
                        desc: AppLocalizations.of(context)!.errorChooseDate,
                        btnOkOnPress: () {},
                      ).show();
                    } else {
                      Navigator.pushNamed(context, PageName.CheckOut2);
                    }
                  },
                  text: AppLocalizations.of(context)!.payment),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/models/booking.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/widgets/step3/info_booking_price.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/button/linear_button.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';

import '../../../../../utilities/appbar/appbar_normal.dart';
import '../../../../../utilities/const/styles.dart';
import '../../models/booking_flight_model.dart';

class ChangePassengerInfo extends StatefulWidget {
  const ChangePassengerInfo({super.key});

  @override
  State<ChangePassengerInfo> createState() => _ChangePassengerInfoState();
}

class _ChangePassengerInfoState extends State<ChangePassengerInfo> {
  List<TextEditingController> seatControllers = [];
  List<TextEditingController> passportControllers = [];

  @override
  void initState() {
    super.initState();
    var cubit = context.read<SaveBookingFlightCubit>().state;
    for (var i = 0; i < cubit.seat.length; i++) {
      seatControllers.add(TextEditingController(text: cubit.seat[i].name));
      passportControllers.add(TextEditingController(text: cubit.seat[i].id));
    }
  }

  @override
  void dispose() {
    for (var i = 0; i < seatControllers.length; i++) {
      seatControllers[i].dispose();
      passportControllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(context, AppLocalizations.of(context)!.change, '',
          isBack: true),
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: seatControllers.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.seat}: ${seatControllers[index].text}',
                            style: AppStyle.heading
                                .copyWith(color: Colors.black, fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          textFormField(
                            text: AppLocalizations.of(context)!.passportId,
                            controller: passportControllers[index],
                            keyboardType: true,
                            validateFunc: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.required;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                  ButtonGradient(
                    onTap: () {
                      var cubit = context.read<SaveBookingFlightCubit>();
                      List<SeatModel> seats = [];
                      for (var i = 0; i < seatControllers.length; i++) {
                        seats.add(SeatModel(
                            name: seatControllers[i].text,
                            id: passportControllers[i].text,
                            type: cubit.state.seat[i].type));
                      }
                      BookingFlightModel bookingFlightModel =
                          BookingFlightModel(
                              guest: GuestModel(),
                              seat: seats,
                              flightModel: cubit.state.flightModel);

                      context
                          .read<SaveBookingFlightCubit>()
                          .saveInfoBooking(bookingFlightModel);

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: AppLocalizations.of(context)!.success,
                        desc: AppLocalizations.of(context)!.updateSuccess,
                        btnOkOnPress: () {
                          print(bookingFlightModel.toJson().toString());
                          Navigator.pop(context);
                        },
                      ).show();
                    },
                    text: AppLocalizations.of(context)!.confirm,
                  ),
                ],
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

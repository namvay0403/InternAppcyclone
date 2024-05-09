import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/models/filter_info.dart';
import 'package:intern_appcyclone/utilities/button/linear_button.dart';
import 'package:intern_appcyclone/utilities/const/app_assets.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:intern_appcyclone/utilities/const/route.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../global/text_form_field_flight.dart';

class MultipleCity extends StatefulWidget {
  const MultipleCity({super.key});

  @override
  State<MultipleCity> createState() => _MultipleCityState();
}

class _MultipleCityState extends State<MultipleCity>
    with AutomaticKeepAliveClientMixin {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController departController = TextEditingController(
      text:
          DateTime.now().add(const Duration(days: 3)).toString().split(" ")[0]);
  TextEditingController passengerController = TextEditingController();
  TextEditingController classController = TextEditingController();

  ValueNotifier<double> turns = ValueNotifier<double>(0.0);

  bool change = true;

  // 2nd flight

  TextEditingController fromController2 = TextEditingController();
  TextEditingController toController2 = TextEditingController();
  TextEditingController departController2 = TextEditingController(
      text:
          DateTime.now().add(const Duration(days: 3)).toString().split(" ")[0]);
  TextEditingController passengerController2 = TextEditingController();
  TextEditingController classController2 = TextEditingController();

  ValueNotifier<double> turns2 = ValueNotifier<double>(0.0);

  bool change2 = true;

  @override
  void dispose() {
    super.dispose();
    fromController.dispose();
    toController.dispose();
    departController.dispose();
    passengerController.dispose();
    classController.dispose();
    turns.dispose();
    fromController2.dispose();
    toController2.dispose();
    departController2.dispose();
    passengerController2.dispose();
    classController2.dispose();
    turns2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    passengerController.text = AppLocalizations.of(context)!.adult;
    classController.text = AppLocalizations.of(context)!.economy;
    passengerController2.text = AppLocalizations.of(context)!.adult;
    classController2.text = AppLocalizations.of(context)!.economy;
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${AppLocalizations.of(context)!.flight} 1',
              style:
                  AppStyle.heading.copyWith(color: Colors.black, fontSize: 20),
            ),
          ),
          flightGroupItem(
            turn: turns,
            fromController: fromController,
            toController: toController,
            departureController: departController,
            passengerController: passengerController,
            classController: classController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${AppLocalizations.of(context)!.flight} 2',
              style:
                  AppStyle.heading.copyWith(color: Colors.black, fontSize: 20),
            ),
          ),
          flightGroupItem(
            turn: turns2,
            fromController: fromController2,
            toController: toController2,
            departureController: departController2,
            passengerController: passengerController2,
            classController: classController2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ButtonGradient(
                onTap: () {
                  // if (fromController.text.isEmpty ||
                  //     toController.text.isEmpty ||
                  //     departController.text.isEmpty ||
                  //     passengerController.text.isEmpty ||
                  //     classController.text.isEmpty) {
                  //   AwesomeDialog(
                  //     context: context,
                  //     dialogType: DialogType.warning,
                  //     animType: AnimType.rightSlide,
                  //     title: AppLocalizations.of(context)!.required,
                  //     desc: AppLocalizations.of(context)!
                  //         .pleaseEnterFullInformation,
                  //     btnOkOnPress: () {},
                  //   ).show();
                  // } else {
                  //   FilterInfo filterInfo = FilterInfo(
                  //     from: fromController.text,
                  //     to: toController.text,
                  //     departureDate: DateTime.now(),
                  //     cls: classController.text,
                  //   );
                  //   Navigator.pushNamed(context, PageName.BookingFlightStep2,
                  //       arguments: filterInfo);
                  // }
                },
                text: AppLocalizations.of(context)!.search),
          ),
          const SizedBox(height: 40),
        ],
      )),
    );
  }

  Widget flightGroupItem({
    required ValueNotifier<double> turn,
    required fromController,
    required toController,
    required departureController,
    required passengerController,
    required classController,
  }) {
    return ValueListenableBuilder(
      valueListenable: turn,
      builder: (BuildContext context, double value, Widget? child) {
        return Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    TextFormFieldFlight(
                      label: AppLocalizations.of(context)!.from,
                      controller: fromController,
                      prefixImage: AppAssets.from,
                    ),
                    TextFormFieldFlight(
                      label: AppLocalizations.of(context)!.to,
                      controller: toController,
                      prefixImage: AppAssets.to,
                    ),
                  ],
                ),
                Positioned(
                  top: 58,
                  right: 50,
                  child: AnimatedRotation(
                    turns: turn.value,
                    duration: const Duration(milliseconds: 300),
                    child: InkWell(
                      onTap: () {
                        turn.value += 1 / 2;
                        var temp = fromController.text;
                        Future.delayed(const Duration(milliseconds: 250), () {
                          fromController.text = toController.text;
                          toController.text = temp;
                        });
                      },
                      customBorder: const CircleBorder(),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: AppColor.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.swap_vert,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextFormFieldFlight(
              label: AppLocalizations.of(context)!.departure,
              controller: departController,
              prefixImage: AppAssets.departure,
              readOnly: true,
              onTap: () {
                _selectDate(context, departController);
              },
            ),
            TextFormFieldFlight(
              label: AppLocalizations.of(context)!.passenger,
              controller: passengerController,
              prefixImage: AppAssets.passenger,
            ),
            TextFormFieldFlight(
              label: AppLocalizations.of(context)!.cls,
              controller: classController,
              prefixImage: AppAssets.cls,
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      controller.text = picked.toString().split(" ")[0];
      // if (controller == _checkInController) {
      //   context.read<SaveInfoBooking>().state.dateStart = picked;
      // } else {
      //   context.read<SaveInfoBooking>().state.dateEnd = picked;
      // }
    }
  }

  @override
  bool get wantKeepAlive => true;
}

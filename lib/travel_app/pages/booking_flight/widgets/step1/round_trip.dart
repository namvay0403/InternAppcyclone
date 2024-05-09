import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intern_appcyclone/utilities/button/linear_button.dart';
import 'package:intern_appcyclone/utilities/const/app_assets.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:intern_appcyclone/utilities/const/page_name.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../utilities/const/route.dart';
import '../../models/filter_info.dart';
import '../global/text_form_field_flight.dart';

class RoundTrip extends StatefulWidget {
  const RoundTrip({super.key});

  @override
  State<RoundTrip> createState() => _RoundTripState();
}

class _RoundTripState extends State<RoundTrip>
    with AutomaticKeepAliveClientMixin {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController departController = TextEditingController(
      text:
          DateTime.now().add(const Duration(days: 3)).toString().split(" ")[0]);
  TextEditingController returnController = TextEditingController(
      text:
          DateTime.now().add(const Duration(days: 5)).toString().split(" ")[0]);
  TextEditingController passengerController = TextEditingController();
  TextEditingController classController = TextEditingController();

  ValueNotifier<double> turns = ValueNotifier<double>(0.0);

  bool change = true;

  @override
  void dispose() {
    super.dispose();
    fromController.dispose();
    toController.dispose();
    departController.dispose();
    passengerController.dispose();
    classController.dispose();
    turns.dispose();
  }

  @override
  Widget build(BuildContext context) {
    passengerController.text = AppLocalizations.of(context)!.adult;
    classController.text = AppLocalizations.of(context)!.economy;
    super.build(context);
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: turns,
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
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
                        turns: turns.value,
                        duration: const Duration(milliseconds: 300),
                        child: InkWell(
                          onTap: () {
                            turns.value += 1 / 2;
                            var temp = fromController.text;
                            Future.delayed(const Duration(milliseconds: 250),
                                () {
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
                  label: AppLocalizations.of(context)!.returnDate,
                  controller: returnController,
                  prefixImage: AppAssets.departure,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context, returnController);
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ButtonGradient(
                      onTap: () {
                        if (fromController.text.isEmpty ||
                            toController.text.isEmpty ||
                            returnController.text.isEmpty ||
                            departController.text.isEmpty ||
                            passengerController.text.isEmpty ||
                            classController.text.isEmpty) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: AppLocalizations.of(context)!.required,
                            desc: AppLocalizations.of(context)!
                                .pleaseEnterFullInformation,
                            btnOkOnPress: () {},
                          ).show();
                        } else {
                          FilterInfo filterInfo = FilterInfo(
                            from: fromController.text,
                            to: toController.text,
                            departureDate: departController.text,
                            cls: 'Economy' == classController.text
                                ? ['Economy']
                                : ['Business'], seats: [],
                          );
                          Navigator.pushNamed(
                              context, PageName.BookingFlightStep2,
                              arguments: filterInfo);
                        }
                      },
                      text: AppLocalizations.of(context)!.search),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
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

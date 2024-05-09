import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/cubit/save_booking_info_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/models/booking.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/models/hotel.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';

import '../../../../../utilities/appbar/appbar_normal.dart';
import '../../../../../utilities/button/linear_button.dart';
import '../../../../../utilities/const/validate.dart';
import '../../../../../utilities/textformfield/text_form_field.dart';
import '../../../../authentication/cubit/user_cubit.dart';

class AddCard extends StatefulWidget {
  AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final formKeyCard = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    countryController.dispose();
    cardNumberController.dispose();
    dateController.dispose();
    cvvController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var cubit = context.read<SaveInfoBooking>().state;
    nameController.text = cubit.card.name;
    cardNumberController.text = cubit.card.cardNumber;
    dateController.text = cubit.card.expiredDate;
    cvvController.text = cubit.card.cvv;
    countryController.text = cubit.card.country;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: appbarCustom(context, AppLocalizations.of(context)!.addCard, '',
          isBack: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Form(
                    key: formKeyCard,
                    child: Column(
                      children: [
                        textFormField(
                            text: AppLocalizations.of(context)!.name,
                            validateFunc: Validate.validateName,
                            controller: nameController),
                        const SizedBox(height: 20),
                        textFormField(
                            text: AppLocalizations.of(context)!.cardNumber,
                            checkKeyboard: true,
                            validateFunc: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.required;
                              }
                              return null;
                            },
                            controller: cardNumberController),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: textFormField(
                                  text: AppLocalizations.of(context)!.date,
                                  controller: dateController,
                                  checkKeyboard: true,
                                  validateFunc: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .required;
                                    }
                                    return null;
                                  },
                                  hintText: "MM/YY"),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: textFormField(
                                  checkKeyboard: true,
                                  text: 'CVV',
                                  validateFunc: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .required;
                                    }
                                    return null;
                                  },
                                  controller: cvvController),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        textFormField(
                          text: AppLocalizations.of(context)!.country,
                          controller: countryController,
                          readOnly: true,
                          validateFunc: Validate.validateCountry,
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: false,
                              onSelect: (Country country) {
                                countryController.text = country.name;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ButtonGradient(
                onTap: () {
                  if (formKeyCard.currentState!.validate()) {
                    CardModel cardModel = CardModel(
                      name: nameController.text,
                      cardNumber: cardNumberController.text,
                      expiredDate: dateController.text,
                      cvv: cvvController.text,
                      country: countryController.text,
                    );

                    context.read<SaveInfoBooking>().state.card = cardModel;

                    print(context
                        .read<SaveInfoBooking>()
                        .state
                        .toJson()
                        .toString());

                    context.read<SaveBookingFlightCubit>().state.card =
                        cardModel;

                    context
                        .read<SaveInfoBooking>()
                        .saveInfoBooking(context.read<SaveInfoBooking>().state);
                    AwesomeDialog(
                      dismissOnTouchOutside: false,
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.rightSlide,
                      title: AppLocalizations.of(context)!.success,
                      desc: AppLocalizations.of(context)!.updateSuccess,
                      btnOkOnPress: () {
                        print(context
                            .read<SaveInfoBooking>()
                            .state
                            .toJson()
                            .toString());
                        Navigator.pop(context);
                      },
                    ).show();
                  }
                },
                text: AppLocalizations.of(context)!.confirm,
              ),
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
      bool checkKeyboard = false,
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
        keyboardType: checkKeyboard ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}

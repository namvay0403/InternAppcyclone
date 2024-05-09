import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/models/booking_flight_model.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/models/filter_info.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/widgets/global/text_form_field_flight.dart';
import 'package:intern_appcyclone/utilities/button/linear_button.dart';
import 'package:intern_appcyclone/utilities/const/app_assets.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:intern_appcyclone/utilities/const/page_name.dart';
import 'package:intern_appcyclone/utilities/const/route.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OneWay extends StatefulWidget {
  const OneWay({super.key});

  @override
  State<OneWay> createState() => _OneWayState();
}

class _OneWayState extends State<OneWay> with AutomaticKeepAliveClientMixin {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController departController = TextEditingController(
      text: DateTime(2023, 10, 22).toString().split(" ")[0]);
  TextEditingController passengerController = TextEditingController();

  ValueNotifier<double> turns = ValueNotifier<double>(0.0);
  ValueNotifier<int> numberOfPassenger = ValueNotifier<int>(1);

  bool change = true;

  List<TextEditingController> textEditingControllers = [];
  var stringListReturnedFromApiCall = ["", "", "", ""];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      textEditingControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    super.dispose();
    fromController.dispose();
    toController.dispose();
    departController.dispose();
    passengerController.dispose();
    turns.dispose();
    for (TextEditingController textEditingController
        in textEditingControllers) {
      textEditingController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    passengerController.text =
        '${numberOfPassenger.value} ${AppLocalizations.of(context)!.adult}';
    fromController.text = 'USA';
    toController.text = 'Australia';
    // var items = [
    //   AppLocalizations.of(context)!.economy,
    //   AppLocalizations.of(context)!.business,
    // ];
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
                          readOnly: true,
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: false,
                              countryListTheme: CountryListThemeData(
                                bottomSheetHeight: 600,
                                borderRadius: BorderRadius.circular(20),
                                inputDecoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search,
                                      color: AppColor.primaryColor),
                                  hintText:
                                      AppLocalizations.of(context)!.search,
                                  border: InputBorder.none,
                                ),
                              ),
                              onSelect: (Country country) {
                                fromController.text = country.name;
                              },
                            );
                          },
                        ),
                        TextFormFieldFlight(
                          label: AppLocalizations.of(context)!.to,
                          controller: toController,
                          prefixImage: AppAssets.to,
                          readOnly: true,
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: false,
                              countryListTheme: CountryListThemeData(
                                bottomSheetHeight: 600,
                                borderRadius: BorderRadius.circular(20),
                                inputDecoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search,
                                      color: AppColor.primaryColor),
                                  hintText:
                                      AppLocalizations.of(context)!.search,
                                  border: InputBorder.none,
                                ),
                              ),
                              onSelect: (Country country) {
                                toController.text = country.name;
                              },
                            );
                          },
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
                  label: AppLocalizations.of(context)!.passenger,
                  controller: passengerController,
                  prefixImage: AppAssets.passenger,
                  readOnly: true,
                  suffix: SizedBox(
                    width: 120,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              if (numberOfPassenger.value > 1) {
                                numberOfPassenger.value--;
                                passengerController.text =
                                    '${numberOfPassenger.value} ${AppLocalizations.of(context)!.adult}';
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.remove,
                                color: Colors.black,
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ValueListenableBuilder(
                              valueListenable: numberOfPassenger,
                              builder: (context, value, child) => Text(
                                    '$value',
                                    style: AppStyle.heading.copyWith(
                                        fontSize: 16, color: Colors.black),
                                  )),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              if (numberOfPassenger.value < 4) {
                                numberOfPassenger.value++;
                                passengerController.text =
                                    '${numberOfPassenger.value} ${AppLocalizations.of(context)!.adult}';
                                textEditingControllers[numberOfPassenger.value - 1]
                                    .text = '';
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // TextFormFieldFlight(
                //   label: AppLocalizations.of(context)!.cls,
                //   controller: classController,
                //   prefixImage: AppAssets.cls,
                // ),
                ValueListenableBuilder(
                    valueListenable: numberOfPassenger,
                    builder: ((context, value, child) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 30,
                                  elevation: 16,
                                  style: AppStyle.heading.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  menuMaxHeight: 150,
                                  decoration: InputDecoration(
                                    prefixIcon: Image.asset(AppAssets.cls),
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.only(left: 10),
                                    label: Text(
                                        '${AppLocalizations.of(context)!.cls} ${index + 1}'),
                                    labelStyle: AppStyle.normal.copyWith(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                  onChanged: (String? newValue) {
                                    textEditingControllers[index].text =
                                        newValue!;
                                  },
                                  items: [
                                    AppLocalizations.of(context)!.economy,
                                    AppLocalizations.of(context)!.business,
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          });
                    })),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: ButtonGradient(
                      onTap: () {
                        if (fromController.text.isEmpty ||
                            toController.text.isEmpty ||
                            departController.text.isEmpty ||
                            passengerController.text.isEmpty ||
                            !checkNotEmpty()) {
                          AwesomeDialog(
                            dismissOnTouchOutside: false,
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: AppLocalizations.of(context)!.required,
                            desc: AppLocalizations.of(context)!
                                .pleaseEnterFullInformation,
                            btnOkOnPress: () {},
                          ).show();
                        } else {
                          List<String> cls = [];
                          List<SeatModel> seatModel = [];
                          for (int i = 0; i < numberOfPassenger.value; i++) {
                            cls.add(textEditingControllers[i].text);
                            textEditingControllers[i].text.isNotEmpty
                                ? seatModel.add(SeatModel(
                                    name: '',
                                    type: textEditingControllers[i].text))
                                : null;
                          }
                          FilterInfo filterInfo = FilterInfo(
                            from: fromController.text,
                            to: toController.text,
                            departureDate: departController.text,
                            cls: cls,
                            seats: [],
                          );

                          context.read<SaveBookingFlightCubit>().state.seat =
                              seatModel;

                          Navigator.pushNamed(
                              context, PageName.BookingFlightStep2,
                              arguments: filterInfo);
                        }
                      },
                      text: AppLocalizations.of(context)!.search),
                ),
                const SizedBox(height: 50),
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
      initialDate: DateTime(2023, 10, 22),
      firstDate: DateTime(2023),
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

  bool checkNotEmpty() {
    for (int i = 0; i < numberOfPassenger.value; i++) {
      if (textEditingControllers[i].text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  bool get wantKeepAlive => true;
}

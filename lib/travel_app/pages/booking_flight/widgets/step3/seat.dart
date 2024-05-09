import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/models/booking_flight_model.dart';
import 'package:intern_appcyclone/utilities/button/linear_button.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:intern_appcyclone/utilities/const/page_name.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';

class Seats extends StatefulWidget {
  const Seats({super.key, required this.seats});

  final List<dynamic> seats;

  @override
  State<Seats> createState() => _SeatsState();
}

class _SeatsState extends State<Seats> {
  List<SeatModel> listSeat = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 2; i++) {
      for (var j = 1; j <= widget.seats[i].length; j++) {
        for (var k = 0; k < widget.seats[i]['$j'].length; k++) {
          listSeat.add(SeatModel(
              name: '',
              type: i == 0 ? 'B' : 'E',
              isSelected: widget.seats[i]['$j'][k]));
        }
      }
    }

    for (var i = 0; i < listSeat.length; i++) {
      listSeat[i].name = listSeat[i].type == 'B' ? 'B${i + 1}' : 'E$i';
    }
    // listChooseSeat = context.read<SaveBookingFlightCubit>().state.seat;
    print(context
        .read<SaveBookingFlightCubit>()
        .state
        .seat
        .map((e) => e.toJson())
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  ...[
                    {
                      'color': AppColor.primaryColor.withOpacity(0.2),
                      'text': AppLocalizations.of(context)!.available
                    },
                    {
                      'color': Colors.red,
                      'text': AppLocalizations.of(context)!.booked
                    },
                    {
                      'color': AppColor.primaryColor,
                      'text': AppLocalizations.of(context)!.selected
                    },
                  ].map((e) => Expanded(
                          child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: e['color'] as Color,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(e['text'] as String,
                              style: AppStyle.normal
                                  .copyWith(color: Colors.black)),
                        ],
                      ))),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  // Text(
                  //   AppLocalizations.of(context)!.business,
                  //   style: AppStyle.heading.copyWith(color: Colors.black),
                  // ),
                  const SizedBox(height: 20),
                  BlocBuilder<SaveBookingFlightCubit, BookingFlightModel>(
                    builder: (context, state) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 20,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listSeat.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: !listSeat[index].isSelected
                                ? () {
                                    context
                                        .read<SaveBookingFlightCubit>()
                                        .saveSeat(
                                            context, listSeat[index].name);
                                  }
                                : null,
                            child: Container(
                              decoration: BoxDecoration(
                                color: listSeat[index].isSelected
                                    ? Colors.red
                                    : state.seat
                                            .where((element) =>
                                                element.name ==
                                                listSeat[index].name)
                                            .isNotEmpty
                                        ? AppColor.primaryColor
                                        : AppColor.primaryColor
                                            .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                listSeat[index].name,
                                style: AppStyle.normal.copyWith(
                                  color: listSeat[index].isSelected
                                      ? Colors.white
                                      : state.seat
                                              .where((element) =>
                                                  element.name ==
                                                  listSeat[index].name)
                                              .isNotEmpty
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child: Column(
            //     children: [
            //       Text(
            //         AppLocalizations.of(context)!.economy,
            //         style: AppStyle.heading.copyWith(color: Colors.black),
            //       ),
            //       const SizedBox(height: 20),
            //       SizedBox(
            //         height: 350,
            //         child: GridView.builder(
            //           gridDelegate:
            //               const SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 5,
            //             crossAxisSpacing: 30,
            //             mainAxisSpacing: 20,
            //           ),
            //           shrinkWrap: true,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemCount: 30,
            //           itemBuilder: (context, index) {
            //             return InkWell(
            //               onTap: !listSeat[index].isSelected
            //                   ? () {
            //                       selectedSeat2.value = index;
            //                       selectedSeat.value = -1;
            //                       // context
            //                       //     .read<SaveBookingFlightCubit>()
            //                       //     .state
            //                       //     .seat
            //                       //     .name = getSeatEconomy(index);
            //                       // print(context
            //                       //     .read<SaveBookingFlightCubit>()
            //                       //     .state
            //                       //     .seat
            //                       //     .name);
            //                     }
            //                   : null,
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   color: listSeat[index].isSelected
            //                       ? Colors.red
            //                       : selectedSeat2.value == index
            //                           ? AppColor.primaryColor
            //                           : AppColor.primaryColor.withOpacity(0.2),
            //                   borderRadius: BorderRadius.circular(5),
            //                 ),
            //                 alignment: Alignment.bottomCenter,
            //                 child: Text(
            //                   listSeat[index].name,
            //                   style: AppStyle.normal.copyWith(
            //                     color: listSeat[index].isSelected
            //                         ? Colors.white
            //                         : selectedSeat.value == index
            //                             ? Colors.white
            //                             : Colors.black,
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ButtonGradient(
            onTap: () {
              var bookingFlightData =
                  context.read<SaveBookingFlightCubit>().state;
              int businessTicket = bookingFlightData.seat
                  .where((element) => element.type
                      .contains(AppLocalizations.of(context)!.business))
                  .length;
              int economyTicket = bookingFlightData.seat
                  .where((element) => element.type
                      .contains(AppLocalizations.of(context)!.economy))
                  .length;
              if (context
                  .read<SaveBookingFlightCubit>()
                  .state
                  .seat
                  .where((e) => e.name.isEmpty)
                  .isNotEmpty) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.rightSlide,
                  title: AppLocalizations.of(context)!.error,
                  desc:
                      '${AppLocalizations.of(context)!.pleaseSelectSeat}: \n${AppLocalizations.of(context)!.business}: $businessTicket  \n${AppLocalizations.of(context)!.economy}: $economyTicket',
                  btnOkOnPress: () {},
                ).show();
              } else {
                Navigator.pushNamed(context, PageName.BookingFlightStep4);
              }
            },
            text: AppLocalizations.of(context)!.confirm,
          ),
        ),
      ],
    );
  }
}

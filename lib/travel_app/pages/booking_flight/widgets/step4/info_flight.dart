import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/authentication/cubit/user_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../global/seperator.dart';

class InfoFlight extends StatelessWidget {
  const InfoFlight({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SaveBookingFlightCubit>();
    var infoBookingFlight = context.read<SaveBookingFlightCubit>().state;
    var userCubit = context.read<UserCubit>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cubit.state.flightModel!.fromPlace!,
                  style: AppStyle.heading
                      .copyWith(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(width: 15),
                Container(
                  height: 1,
                  width: 30,
                  color: Colors.black,
                ),
                const RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.flight,
                    size: 35,
                  ),
                ),
                Container(
                  height: 1,
                  width: 30,
                  color: Colors.black,
                ),
                const SizedBox(width: 15),
                Text(
                  cubit.state.flightModel!.toPlace!,
                  style: AppStyle.heading
                      .copyWith(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const MySeparator(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primaryColor,
                    ),
                    child: const Icon(
                      Icons.flight,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Airline',
                        style: AppStyle.normal.copyWith(color: Colors.grey),
                      ),
                      Text(
                        cubit.state.flightModel!.airLine!,
                        style: AppStyle.heading.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.passenger,
                        style: AppStyle.normal.copyWith(color: Colors.grey),
                      ),
                      Text(
                        userCubit.state.displayName!,
                        style: AppStyle.heading.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.date,
                        style: AppStyle.normal.copyWith(color: Colors.grey),
                      ),
                      Text(
                        cubit.state.flightModel!.departureTime!
                            .toString()
                            .split(' ')[0],
                        style: AppStyle.heading.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gate',
                        style: AppStyle.normal.copyWith(color: Colors.grey),
                      ),
                      Text(
                        '24A',
                        style: AppStyle.heading.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.flightNumber,
                        style: AppStyle.normal.copyWith(color: Colors.grey),
                      ),
                      Text(
                        cubit.state.flightModel!.no!,
                        style: AppStyle.heading.copyWith(color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.arrivalTime,
                        style: AppStyle.normal.copyWith(color: Colors.grey),
                      ),
                      Text(
                        DateFormat.jm()
                            .format(cubit.state.flightModel!.arriveTime!),
                        style: AppStyle.heading.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: infoBookingFlight.seat.length,
                      itemBuilder: (context, index) {
                        var item = infoBookingFlight.seat[index];
                        return Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.seat,
                                  style: AppStyle.normal
                                      .copyWith(color: Colors.grey),
                                ),
                                Text(
                                  item.name,
                                  style: AppStyle.heading
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.cls,
                                    style: AppStyle.normal
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    item.type,
                                    style: AppStyle.heading
                                        .copyWith(color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      }),
                )
              ],
            ),
            const SizedBox(height: 20),
            const MySeparator(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text.rich(
                  TextSpan(
                    text: '\$${cubit.state.flightModel!.price}',
                    style: AppStyle.heading
                        .copyWith(color: Colors.black, fontSize: 20),
                    children: [
                      TextSpan(
                        text: '/${AppLocalizations.of(context)!.passenger}',
                        style: AppStyle.normal.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

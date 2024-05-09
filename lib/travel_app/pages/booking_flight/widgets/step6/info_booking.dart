import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/widgets/global/seperator.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';

class InfoBooking extends StatelessWidget {
  const InfoBooking({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SaveBookingFlightCubit>();
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '${cubit.state.seat.length} ${AppLocalizations.of(context)!.passenger}',
                    style: const TextStyle(fontSize: 17)),
                Text(
                  '\$ ${cubit.state.seat.length}x${cubit.state.flightModel!.price}',
                  style: const TextStyle(fontSize: 17),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Insurance', style: TextStyle(fontSize: 17)),
                Text(
                  '-',
                  style: TextStyle(fontSize: 17),
                )
              ],
            ),
            const SizedBox(height: 10),
            const MySeparator(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.total,
                    style: AppStyle.heading
                        .copyWith(fontSize: 17, color: Colors.black)),
                Text(
                  '\$${cubit.state.flightModel!.price! * cubit.state.seat.length}',
                  style: AppStyle.heading
                      .copyWith(fontSize: 17, color: Colors.black),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

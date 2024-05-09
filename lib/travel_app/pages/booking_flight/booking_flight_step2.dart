import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/cubit/get_data_flight_cubit.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/filter_info.dart';
import 'widgets/step2/ticket.dart';

class BookingFlightStep2 extends StatelessWidget {
  const BookingFlightStep2({
    super.key,
    required this.filterInfo,
  });

  final FilterInfo filterInfo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDataFlightCubit(),
      child: Scaffold(
        appBar: appbarCustom(
          context,
          '${filterInfo.from} --- ${filterInfo.to}',
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       filterInfo.departureDate,
          //       style: AppStyle.normal,
          //     ),
          //     const SizedBox(width: 10),
          //     Container(
          //       height: 10,
          //       width: 10,
          //       decoration: const BoxDecoration(
          //         color: Colors.white,
          //         shape: BoxShape.circle,
          //       ),
          //     ),
          //     const SizedBox(width: 10),
          //     Text(
          //       AppLocalizations.of(context)!.adult,
          //       style: AppStyle.normal,
          //     ),
          //     const SizedBox(width: 10),
          //     Container(
          //       height: 10,
          //       width: 10,
          //       decoration: const BoxDecoration(
          //         color: Colors.white,
          //         shape: BoxShape.circle,
          //       ),
          //     ),
          //     const SizedBox(width: 10),
          //     Text(
          //       filterInfo.cls[0],
          //       style: AppStyle.normal,
          //     ),
          //   ],
          // ),
          '${filterInfo.departureDate} - ${AppLocalizations.of(context)!.adult} - ${filterInfo.cls[0]}',
          isBack: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // const SizedBox(height: 150),
              Ticket(filterInfo: filterInfo),
            ],
          ),
        ),
      ),
    );
  }
}

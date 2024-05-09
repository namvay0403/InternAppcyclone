import 'package:flutter/material.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/models/filter_info.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/models/flight.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/widgets/step3/seat.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar_normal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingFlightStep3 extends StatelessWidget {
  const BookingFlightStep3({super.key, required this.filterInfo});

  final FilterInfo filterInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
          context, AppLocalizations.of(context)!.selectSeat, '',
          isBack: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Seats(
              seats: filterInfo.seats,
            ),
          ],
        ),
      ),
    );
  }
}

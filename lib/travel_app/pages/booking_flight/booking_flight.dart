import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/cubit/get_data_flight_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/global/global.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar_normal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/utilities/const/app_assets.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';

import 'widgets/step1/flight_type.dart';

class BookingFlight extends StatelessWidget {
  BookingFlight({super.key});

  HelperPage helperPage = HelperPage(FlightType.One_Way);

  @override
  Widget build(BuildContext context) {
    print(context.read<SaveBookingFlightCubit>().state.toJson());
    return BlocProvider(
      create: (context) => GetDataFlightCubit(),
      child: Scaffold(
        appBar: appbarCustom(
            context, AppLocalizations.of(context)!.bookingYourFlight, '',
            isBack: true, onTap: () {
          context.read<SaveBookingFlightCubit>().initDataBookingFlight();
          Navigator.pop(context);
        }),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FlightTypeWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

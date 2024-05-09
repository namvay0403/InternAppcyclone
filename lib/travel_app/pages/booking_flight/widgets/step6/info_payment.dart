import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../utilities/const/styles.dart';

class InfoPaymentMethodFlight extends StatelessWidget {
  const InfoPaymentMethodFlight({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SaveBookingFlightCubit>().state;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Row(
          children: [
            const Expanded(
              child: Icon(
                Icons.payment,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.paymentMethod,
                    style: AppStyle.normal
                        .copyWith(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    cubit.typePayment!,
                    style: AppStyle.heading
                        .copyWith(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: TextButton(
                onPressed: () {
                  context.read<SaveBookingFlightCubit>().state.typePayment = '';
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.change,
                  style:
                      AppStyle.heading.copyWith(color: AppColor.primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

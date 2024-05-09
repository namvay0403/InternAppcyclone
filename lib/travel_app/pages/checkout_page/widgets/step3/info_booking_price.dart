import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/cubit/save_booking_info_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';

class InfoBookingPrice extends StatelessWidget {
  const InfoBookingPrice({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SaveInfoBooking>().state;
    print(
        '${cubit.dateEnd} - ${cubit.dateStart} ${cubit.dateEnd!.difference(cubit.dateStart!).inDays}');

    int totalNight = cubit.dateEnd!.difference(cubit.dateStart!).inDays == 0
        ? 1
        : cubit.dateEnd!.difference(cubit.dateStart!).inDays;
    var totalPrice = totalNight * cubit.roomModel!.price;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$totalNight ${AppLocalizations.of(context)!.night}',
                  style: AppStyle.normal
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
                Text(
                  '\$${cubit.roomModel!.price} x $totalNight',
                  style: AppStyle.normal
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Taxies & Fees',
                  style: AppStyle.normal
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
                Text(
                  'Free',
                  style: AppStyle.normal
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 10),
            cubit.promoCode.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.promoCode,
                        style: AppStyle.normal
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                      Text(
                        cubit.promoCode,
                        style: AppStyle.normal
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(height: 10),
            Divider(
              color: Colors.grey.withOpacity(0.3),
              height: 1,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.total,
                  style: AppStyle.heading
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
                Text(
                  '\$${totalPrice.toString()}',
                  style: AppStyle.heading
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/cubit/save_booking_info_cubit.dart';

import '../../../../../utilities/const/styles.dart';

class InfoBookingRoom extends StatelessWidget {
  const InfoBookingRoom({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SaveInfoBooking>().state;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        cubit.roomModel!.name,
                        style: AppStyle.heading
                            .copyWith(color: Colors.black, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        cubit.roomModel!.typePrice,
                        style: AppStyle.normal.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.bed,
                            color: Colors.orangeAccent,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            cubit.roomModel!.maxGuests.toString(),
                            style: AppStyle.normal.copyWith(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                          cubit.roomModel!.image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: infoTime(
                    title: AppLocalizations.of(context)!.checkIn,
                    time: cubit.dateStart.toString().split(" ")[0],
                  ),
                ),
                Expanded(
                  child: infoTime(
                    title: AppLocalizations.of(context)!.checkOut,
                    time: cubit.dateEnd.toString().split(" ")[0],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget infoTime({required String title, required String time}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.3),
          ),
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: Icon(
              Icons.calendar_month,
              color: Colors.deepOrange,
            ),
          ),
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyle.normal.copyWith(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              time,
              style:
                  AppStyle.heading.copyWith(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}

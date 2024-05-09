import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';

import '../../../../../utilities/const/colors.dart';
import '../../../../../utilities/const/page_name.dart';
import '../../../../../utilities/const/styles.dart';
import '../../models/booking_flight_model.dart';

class InfoPassenger extends StatelessWidget {
  const InfoPassenger({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.person,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context)!.passenger,
                  style: AppStyle.heading.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey.withOpacity(0.3)),
            BlocBuilder<SaveBookingFlightCubit, BookingFlightModel>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.seat.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var item = state.seat[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${AppLocalizations.of(context)!.seat}: ${item.name}',
                            style: AppStyle.heading
                                .copyWith(fontSize: 16, color: Colors.black)),
                        const SizedBox(height: 5),
                        Text(
                            '${AppLocalizations.of(context)!.passportId}: ${item.id}',
                            style: AppStyle.heading
                                .copyWith(fontSize: 16, color: Colors.black)),
                        Divider(color: Colors.grey.withOpacity(0.3)),
                      ],
                    );
                  },
                );
              },
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, PageName.ChangePassengerInfo);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.change_circle,
                          color: AppColor.primaryColor),
                      const SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context)!.change,
                        style: AppStyle.heading.copyWith(
                          color: AppColor.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

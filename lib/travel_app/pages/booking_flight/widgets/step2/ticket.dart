import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/cubit/get_data_flight_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/models/filter_info.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/models/flight.dart';
import 'package:intern_appcyclone/utilities/const/app_assets.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:intern_appcyclone/utilities/const/page_name.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../../utilities/const/route.dart';
import '../../cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';

class Ticket extends StatefulWidget {
  const Ticket({
    super.key,
    required this.filterInfo,
  });

  final FilterInfo filterInfo;

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  void initState() {
    super.initState();
    context.read<GetDataFlightCubit>().filterFlightData(widget.filterInfo.from,
        widget.filterInfo.to, widget.filterInfo.departureDate);

    print(context
        .read<SaveBookingFlightCubit>()
        .state
        .seat
        .map((e) => e.toJson())
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDataFlightCubit, GetDataFlightState>(
      builder: (context, state) {
        if (state is GetDataFlightLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetDataFlightFailed) {
          return Center(
            child: Text(state.message),
          );
        }
        return state.flightData.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.flightData.length,
                  itemBuilder: (context, index) {
                    var item = state.flightData[index];
                    widget.filterInfo.seats = item.seat!;
                    return InkWell(
                      onTap: () {
                        context
                            .read<SaveBookingFlightCubit>()
                            .state
                            .flightModel = item;
                        Navigator.pushNamed(
                            context, PageName.BookingFlightStep3,
                            arguments: widget.filterInfo);
                      },
                      child: ticketItem(
                          context,
                          DateFormat.jm().format(item.departureTime!),
                          DateFormat.jm().format(item.arriveTime!),
                          item.no!,
                          item.price!),
                    );
                  },
                ),
              )
            : Center(
                child: Text(
                  AppLocalizations.of(context)!.noFlight,
                  style: AppStyle.heading.copyWith(color: Colors.black),
                ),
              );
      },
    );
  }

  Widget ticketItem(context, String departTime, String arriveTime,
      String flightNo, int price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: IntrinsicHeight(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const RotationTransition(
                    turns: AlwaysStoppedAnimation(1 / 6),
                    child: Icon(
                      Icons.airplanemode_active,
                      size: 50,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey.withOpacity(0.4),
                  thickness: 1,
                  indent: 3,
                  endIndent: 3,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: AppLocalizations.of(context)!.departure,
                              style:
                                  AppStyle.normal.copyWith(color: Colors.grey),
                              children: [
                                TextSpan(
                                  text: '\n$departTime',
                                  style: AppStyle.heading
                                      .copyWith(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: AppLocalizations.of(context)!.arrival,
                              style:
                                  AppStyle.normal.copyWith(color: Colors.grey),
                              children: [
                                TextSpan(
                                  text: '\n$arriveTime',
                                  style: AppStyle.heading
                                      .copyWith(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: AppLocalizations.of(context)!.flightNumber,
                              style:
                                  AppStyle.normal.copyWith(color: Colors.grey),
                              children: [
                                TextSpan(
                                  text: '\n$flightNo',
                                  style: AppStyle.heading
                                      .copyWith(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          Text(
                            '\$$price',
                            style: AppStyle.heading
                                .copyWith(color: Colors.black, fontSize: 30),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

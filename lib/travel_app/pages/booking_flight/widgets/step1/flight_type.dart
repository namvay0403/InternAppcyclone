import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/widgets/step1/one_way.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../global/global.dart';
import 'multiple_city.dart';
import 'round_trip.dart';

class FlightTypeWidget extends StatefulWidget {
  FlightTypeWidget({super.key});

  @override
  State<FlightTypeWidget> createState() => _FlightTypeWidgetState();
}

class _FlightTypeWidgetState extends State<FlightTypeWidget> {
  HelperPage helperPage = HelperPage(FlightType.One_Way);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<GetDataFlightCubit>().fetchFlightData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      OneWay(),
      RoundTrip(),
      MultipleCity(),
    ];

    PageController pageController = PageController();

    return ValueListenableBuilder(
      valueListenable: helperPage,
      builder: (context, value, child) {
        return Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                ...[
                  FlightType.One_Way,
                  FlightType.Round_Trip,
                  FlightType.Multi_City
                ].map(
                  (e) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        onTap: () {
                          helperPage.changeFlightType(e);
                          pageController.animateToPage(
                            e.index,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: value == e
                                ? AppColor.backgroundButton
                                : AppColor.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              (e.toString().split('.').last)
                                          .replaceAll('_', ' ') ==
                                      'One Way'
                                  ? AppLocalizations.of(context)!.oneWay
                                  : (e.toString().split('.').last)
                                              .replaceAll('_', ' ') ==
                                          'Round Trip'
                                      ? AppLocalizations.of(context)!.roundTrip
                                      : AppLocalizations.of(context)!.multiCity,
                              style: AppStyle.normal.copyWith(
                                color: value == e
                                    ? Colors.white
                                    : AppColor.primaryColor,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 600,
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: pages,
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/cubit/save_booking_info_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/models/booking.dart';
import 'package:intern_appcyclone/utilities/const/app_assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/utilities/const/page_name.dart';
import 'package:intern_appcyclone/utilities/const/route.dart';

import '../../../../../utilities/const/colors.dart';
import '../../../../../utilities/const/styles.dart';

class PaymentMethodBookingFlight extends StatefulWidget {
  PaymentMethodBookingFlight({super.key});

  @override
  State<PaymentMethodBookingFlight> createState() =>
      _PaymentMethodBookingFlightState();
}

class _PaymentMethodBookingFlightState
    extends State<PaymentMethodBookingFlight> {
  ValueNotifier<String> choose = ValueNotifier<String>('');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (context.read<SaveBookingFlightCubit>().state.typePayment!.isNotEmpty) {
      choose.value = context.read<SaveBookingFlightCubit>().state.typePayment!;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> paymentMethod = [
      'Mini Market',
      'Credit/Debit Card',
      'Bank Transfer',
      'Paypal'
    ];
    List<String> paymentImage = [
      AppAssets.miniMarket,
      AppAssets.credit,
      AppAssets.bank,
      AppAssets.paypal,
    ];

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
      child: BlocBuilder<SaveInfoBooking, BookingModel>(
        builder: (context, state) {
          return ValueListenableBuilder(
            valueListenable: choose,
            builder: (context, value, child) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: paymentMethod.length,
                itemBuilder: (context, index) {
                  var item = paymentMethod[index];
                  return RadioListTile(
                    value: item,
                    secondary: Image.asset(
                      paymentImage[index],
                      width: 30,
                      height: 30,
                    ),
                    groupValue: choose.value,
                    title: Text(item),
                    subtitle: item == 'Credit/Debit Card'
                        ? state.card.cardNumber.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.card.cardNumber),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, PageName.AddCard);
                                    },
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                                Icons.change_circle_rounded,
                                                color: AppColor.primaryColor),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .change,
                                              style: AppStyle.heading.copyWith(
                                                color: AppColor.primaryColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, PageName.AddCard);
                                    },
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                                Icons
                                                    .add_circle_outline_rounded,
                                                color: AppColor.primaryColor),
                                            Text(
                                              AppLocalizations.of(context)!.add,
                                              style: AppStyle.heading.copyWith(
                                                color: AppColor.primaryColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                        : null,
                    onChanged: (value) {
                      context.read<SaveBookingFlightCubit>().state.typePayment =
                          value.toString();
                      choose.value = value.toString();
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

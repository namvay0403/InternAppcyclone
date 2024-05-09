import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/travel_app/authentication/cubit/user_cubit.dart';
import 'package:intern_appcyclone/travel_app/authentication/models/user.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/booking_flight.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/create_booking_cubit/cubit/create_booking_flight_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/widgets/step6/info_booking.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/cubit/save_booking_info_cubit.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';

import '../../../utilities/button/linear_button.dart';
import '../../../utilities/const/page_name.dart';
import '../checkout_page/models/booking.dart';
import 'models/booking_flight_model.dart';
import 'widgets/step4/info_flight.dart';
import 'widgets/step6/info_payment.dart';

class BookingFlightStep6 extends StatefulWidget {
  const BookingFlightStep6({super.key});

  @override
  State<BookingFlightStep6> createState() => _BookingFlightStep6State();
}

class _BookingFlightStep6State extends State<BookingFlightStep6> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SaveBookingFlightCubit>();
    return BlocProvider(
      create: (context) => CreateBookingFlightCubit(),
      child: BookingFlightStep6Screen(user: cubit.state),
    );
  }
}

class BookingFlightStep6Screen extends StatelessWidget {
  const BookingFlightStep6Screen({super.key, required this.user});

  final user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(context, AppLocalizations.of(context)!.checkOut, '',
          isBack: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              const InfoFlight(),
              const SizedBox(height: 20),
              const InfoBooking(),
              const SizedBox(height: 20),
              const InfoPaymentMethodFlight(),
              const SizedBox(height: 20),
              BlocListener<CreateBookingFlightCubit, CreateBookingFlightState>(
                listener: (context, state) {
                  if (state is CreateBookingFlightFailed) {
                    AwesomeDialog(
                      dismissOnTouchOutside: false,
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: AppLocalizations.of(context)!.error,
                      desc: state.message,
                      btnOkOnPress: () {
                        Navigator.pop(context);
                      },
                    ).show();
                  }
                  if (state is CreateBookingFlightLoading) {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  }
                  if (state is CreateBookingFlightSuccess) {
                    AwesomeDialog(
                      dismissOnTouchOutside: false,
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.rightSlide,
                      title: AppLocalizations.of(context)!.success,
                      desc: AppLocalizations.of(context)!.success,
                      btnOkOnPress: () {
                        context
                            .read<SaveBookingFlightCubit>()
                            .initDataBookingFlight();
                        Navigator.pushNamedAndRemoveUntil(
                            context, PageName.NavBar, (route) => false);
                      },
                    ).show();
                  }
                },
                child: ButtonGradient(
                  onTap: () {
                    var userCubit = context.read<UserCubit>().state;
                    GuestModel guest = GuestModel(
                      name: userCubit.displayName!,
                      email: userCubit.email!,
                      phoneNumber: userCubit.phoneNumber!,
                    );
                    CardModel card = CardModel();
                    BookingFlightModel booking = BookingFlightModel(
                      guest: guest,
                      flight: user.flightModel!.no,
                      card: card,
                      typePayment: user.typePayment!,
                      seat: user.seat,
                      email: guest.email,
                    );

                    context
                        .read<CreateBookingFlightCubit>()
                        .createBooking(booking);
                  },
                  text: AppLocalizations.of(context)!.done,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

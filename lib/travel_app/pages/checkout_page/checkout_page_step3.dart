import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/cubit/create_booking_cubit/cubit/create_booking_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/cubit/save_booking_info_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/models/booking.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/widgets/step3/info_payment_method.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/const/page_name.dart';
import 'package:intern_appcyclone/utilities/const/route.dart';
import '../../../utilities/appbar/appbar_normal.dart';
import '../../../utilities/button/linear_button.dart';
import '../../authentication/cubit/user_cubit.dart';
import 'widgets/step1/contact_detail.dart';
import 'widgets/step1/content_appbar.dart';
import 'widgets/step3/info_booking_price.dart';
import 'widgets/step3/info_booking_room.dart';

class CheckOutStep3 extends StatelessWidget {
  const CheckOutStep3({super.key});

  @override
  Widget build(BuildContext context) {
    var userCubit = context.read<UserCubit>().state;
    var bookingInfoCubit = context.read<SaveInfoBooking>().state;
    return BlocProvider(
      create: (context) => CreateBookingCubit(),
      child:
          CheckOutStep3Screen(user: userCubit, bookingInfo: bookingInfoCubit),
    );
  }
}

class CheckOutStep3Screen extends StatelessWidget {
  const CheckOutStep3Screen({super.key, this.user, this.bookingInfo});

  final user;
  final bookingInfo;

  @override
  Widget build(BuildContext context) {
    print('check: ${context
                        .read<SaveInfoBooking>()
                        .state
                        .toJson()
                        .toString()}');
    return Scaffold(
      appBar: appbarCustom(
          context,
          AppLocalizations.of(context)!.checkOut,
          ContentAppBar(
            step: 3,
            content: AppLocalizations.of(context)!.confirm,
          ),
          isBack: true),
      body: BlocListener<CreateBookingCubit, CreateBookingState>(
        listener: (context, state) {
          if (state is CreateBookingFailed) {
            AwesomeDialog(
              dismissOnTouchOutside: false,
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: AppLocalizations.of(context)!.loginError,
              desc: state.message,
              btnOkOnPress: () {
                Navigator.pop(context);
              },
            ).show();
          }
          if (state is CreateBookingLoading) {
            showDialog(
              context: context,
              builder: (_) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
          if (state is CreateBookingSuccess) {
            AwesomeDialog(
              dismissOnTouchOutside: false,
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              title: AppLocalizations.of(context)!.bookingSuccess,
              desc: AppLocalizations.of(context)!.success,
              btnOkOnPress: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, PageName.NavBar, (route) => false);
              },
            ).show();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                const InfoBookingRoom(),
                const SizedBox(height: 20),
                const InfoBookingPrice(),
                const SizedBox(height: 20),
                InfoPaymentMethod(
                  typePayment: bookingInfo.typePayment,
                ),
                const SizedBox(height: 20),
                const ContactDetail(),
                const SizedBox(height: 30),
                ButtonGradient(
                  onTap: () {
                    var bookingInfoCubit =
                        context.read<SaveInfoBooking>().state;
                    GuestModel guest = GuestModel(
                      name: user.displayName!,
                      email: user.email!,
                      phoneNumber: user.phoneNumber!,
                    );
                    CardModel card = context
                        .read<SaveInfoBooking>()
                        .state
                        .card;
                    BookingModel bookingModel = BookingModel(
                      userId: user.id,
                      hotelId: bookingInfoCubit.hotelId,
                      room: bookingInfoCubit.roomModel!.name,
                      dateStart: bookingInfoCubit.dateStart,
                      dateEnd: bookingInfoCubit.dateEnd,
                      guest: guest,
                      card: card,
                      typePayment: bookingInfoCubit.typePayment,
                      email: user.email!,
                      promoCode: bookingInfoCubit.promoCode,
                    );

                    context
                        .read<CreateBookingCubit>()
                        .createBooking(booking: bookingModel);
                  },
                  text: AppLocalizations.of(context)!.done,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

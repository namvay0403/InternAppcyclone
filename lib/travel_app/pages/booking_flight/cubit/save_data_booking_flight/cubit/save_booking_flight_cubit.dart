import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/models/booking_flight_model.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/models/booking.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaveBookingFlightCubit extends Cubit<BookingFlightModel> {
  SaveBookingFlightCubit()
      : super(BookingFlightModel(
          guest: GuestModel(),
          seat: [],
        ));

  void saveInfoBooking(BookingFlightModel bookingFlightModel) {
    emit(bookingFlightModel);
  }

  void initDataBookingFlight(){
    emit(BookingFlightModel(
      guest: GuestModel(),
      seat: [],
    ));
  }

  void saveSeat(BuildContext context, String name) {
    var listChooseSeat = state.seat;
    if (!checkSeat(name)) {
      for (var i = 0; i < listChooseSeat.length; i++) {
        if (name.contains('B')) {
          if (listChooseSeat[i].type ==
                  AppLocalizations.of(context)!.business &&
              listChooseSeat[i].name == '') {
            listChooseSeat[i].name = name;
            break;
          }
        } else if (name.contains('E')) {
          if (listChooseSeat[i].type == AppLocalizations.of(context)!.economy &&
              listChooseSeat[i].name == '') {
            listChooseSeat[i].name = name;
            break;
          }
        }
      }
    } else {
      removeSeat(name);
    }
    BookingFlightModel bookingFlightModel = BookingFlightModel(
      guest: state.guest,
      seat: listChooseSeat,
      flightModel: state.flightModel,
      
    );
    emit(bookingFlightModel);
  }

  void removeSeat(String name) {
    var listChooseSeat = state.seat;
    for (var i = 0; i < listChooseSeat.length; i++) {
      if (listChooseSeat[i].name == name) {
        listChooseSeat[i].name = '';
      }
    }
  }

  bool checkSeat(String name) {
    var listChooseSeat = state.seat;
    for (var i = 0; i < listChooseSeat.length; i++) {
      if (listChooseSeat[i].name == name) {
        return true;
      }
    }
    return false;
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/repository/flight_repository.dart';

import '../../../models/booking_flight_model.dart';

part 'create_booking_flight_state.dart';

class CreateBookingFlightCubit extends Cubit<CreateBookingFlightState> {
  CreateBookingFlightCubit() : super(CreateBookingFlightInitial());

  void createBooking(BookingFlightModel booking) {
    emit(CreateBookingFlightLoading());
    try {
      FlightRepository().createBooking(booking: booking);
      emit(CreateBookingFlightSuccess());
    } catch (e) {
      emit(CreateBookingFlightFailed(e.toString()));
    }
  }
}

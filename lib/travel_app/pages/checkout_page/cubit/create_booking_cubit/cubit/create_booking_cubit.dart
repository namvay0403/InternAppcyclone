import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/models/booking.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/repository/checkout_repository.dart';

part 'create_booking_state.dart';

class CreateBookingCubit extends Cubit<CreateBookingState> {
  CreateBookingCubit() : super(CreateBookingInitial());

  void createBooking({required BookingModel booking}) {
    emit(CreateBookingLoading());
    try {
      Future.delayed(const Duration(seconds: 1), () async {
      await BookingRepository().createBooking(booking: booking);
      emit(CreateBookingSuccess());
    });
    } catch (e) {
      emit(CreateBookingFailed(e.toString()));
    }
  }
}

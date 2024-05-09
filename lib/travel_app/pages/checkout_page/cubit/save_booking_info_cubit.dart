import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/models/booking.dart';

class SaveInfoBooking extends Cubit<BookingModel> {
  SaveInfoBooking()
      : super(BookingModel(
            guest: GuestModel(),
            card: CardModel(),
            dateStart: DateTime.now(),
            dateEnd: DateTime.now()));

  void saveInfoBooking(BookingModel bookingModel) {
    emit(bookingModel);
  }

  void initDataBooking() {
    emit(BookingModel(
        guest: GuestModel(),
        card: CardModel(),
        dateStart: DateTime.now(),
        dateEnd: DateTime.now()));
  }
}

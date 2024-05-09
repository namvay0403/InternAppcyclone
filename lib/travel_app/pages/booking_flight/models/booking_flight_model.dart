import 'package:intern_appcyclone/travel_app/pages/booking_flight/models/flight.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/models/booking.dart';

class BookingFlightModel {
  GuestModel guest;
  String? email;
  String? flight;
  String promoCode;
  String? typePayment;
  List<SeatModel> seat;
  CardModel? card;
  FlightModel? flightModel;

  BookingFlightModel(
      {required this.guest,
      this.email,
      this.flight,
      this.promoCode = '',
      this.card,
      this.flightModel,
      this.typePayment = '',
      required this.seat});

  Map<String, dynamic> toJson() {
    return {
      'guest': guest.toJson(),
      'email': email,
      'flight': flight,
      'promo_code': promoCode,
      'type_payment': typePayment,
      'seat': seat.map((e) => e.toJson()).toList(),
      'card': card?.toJson(),
    };
  }
}

class SeatModel {
  String name;
  String type;
  bool isSelected = false;
  String id;

  SeatModel({required this.name, required this.type, this.isSelected = false, this.id = ''});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'id': id,
    };
  }
}

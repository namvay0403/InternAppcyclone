import 'package:intern_appcyclone/travel_app/pages/room_page/models/room_model.dart';

class BookingModel {
  DateTime? dateEnd;
  DateTime? dateStart;
  String? email;
  GuestModel guest;
  String? hotelId;
  String? room;
  CardModel card;
  String promoCode = '';
  String typePayment = '';
  String? userId;
  RoomModel? roomModel;

  BookingModel(
      {this.dateEnd,
      this.dateStart,
      this.email = '',
      required this.guest,
      this.hotelId = '',
      required this.card,
      this.promoCode = '',
      this.typePayment = '',
      this.room = '',
      this.roomModel,
      this.userId = ''});

  Map<String, dynamic> toJson() {
    return {
      'date_end': dateEnd,
      'date_start': dateStart,
      'email': email,
      'guest': guest.toJson(),
      'hotelId': hotelId,
      'roomId': room,
      'payment_card_info': card.toJson(),
      'promo_code': promoCode,
      'type_payment': typePayment,
      'userId': userId
    };
  }

  BookingModel copyWith({required CardModel card}) {
    return BookingModel(
        dateEnd: dateEnd,
        dateStart: dateStart,
        email: email,
        guest: guest,
        hotelId: hotelId,
        room: room,
        card: card,
        promoCode: promoCode,
        typePayment: typePayment,
        userId: userId,
        roomModel: roomModel);
  }
}

class GuestModel {
  String name = ' ';
  String phoneNumber = ' ';
  String email = ' ';
  GuestModel({this.name = ' ', this.phoneNumber = ' ', this.email = ' '});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
    };
  }
}

class CardModel {
  String cardNumber = ' ';
  String country = ' ';
  String cvv = ' ';
  String expiredDate = ' ';
  String name = ' ';
  CardModel(
      {this.cardNumber = '',
      this.country = '',
      this.cvv = '',
      this.expiredDate = '',
      this.name = ''});

  Map<String, dynamic> toJson() {
    return {
      'card_number': cardNumber,
      'country': country,
      'cvv': cvv,
      'expired_date': expiredDate,
      'name': name,
    };
  }
}

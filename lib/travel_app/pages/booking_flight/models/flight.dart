import 'package:cloud_firestore/cloud_firestore.dart';

class FlightModel {
  String? airLine;
  DateTime? arriveTime;
  DateTime? departureTime;
  String? fromPlace;
  String? no;
  int? price;
  String? toPlace;
  List<dynamic>? seat;

  FlightModel({
    this.airLine,
    this.arriveTime,
    this.departureTime,
    this.fromPlace,
    this.no,
    this.price,
    this.toPlace,
    this.seat,
  });

  static FlightModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return FlightModel(
      airLine: snapshot['airline'],
      arriveTime: snapshot['arrive_time'].toDate(),
      departureTime: snapshot['departure_time'].toDate(),
      fromPlace: snapshot['from_place'],
      no: snapshot['no'],
      price: snapshot['price'],
      toPlace: snapshot['to_place'],
      seat: snapshot['seat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'airline': airLine,
      'arrive_time': arriveTime,
      'departure_time': departureTime,
      'from_place': fromPlace,
      'no': no,
      'price': price,
      'to_place': toPlace,
      'seat': seat,
    };
  }


}

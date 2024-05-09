import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  final String hotel;
  final String image;
  final int maxGuests;
  final String name;
  final int price;
  final List<String> services;
  final int total;
  final String typePrice;

  RoomModel({
    required this.hotel,
    required this.image,
    required this.maxGuests,
    required this.name,
    required this.price,
    required this.services,
    required this.total,
    required this.typePrice,
  });

  static RoomModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return RoomModel(
      hotel: snapshot['hotel'],
      image: snapshot['image'],
      maxGuests: snapshot['max_guest'] as int,
      name: snapshot['name'],
      price: snapshot['price'] as int,
      services: List<String>.from(snapshot['services']),
      total: snapshot['total'] as int,
      typePrice: snapshot['type_price'],
    );
  }
}

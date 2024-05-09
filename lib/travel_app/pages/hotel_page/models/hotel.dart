import 'package:cloud_firestore/cloud_firestore.dart';

class HotelModel {
  final String image;
  final String information;
  final String location;
  final String locationDescription;
  final String name;
  final int price;
  final double rating;
  final int totalReview;
  final String hotelId;

  HotelModel({
    required this.image,
    required this.information,
    required this.location,
    required this.locationDescription,
    required this.name,
    required this.price,
    required this.rating,
    required this.totalReview,
    required this.hotelId,
  });

  static HotelModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return HotelModel(
      image: snapshot['image'] as String,
      information: snapshot['information'] as String,
      location: snapshot['location'] as String,
      locationDescription: snapshot['location_description'] as String,
      name: snapshot['name'] as String,
      price: snapshot['price'] as int,
      rating: snapshot['rating'] as double,
      totalReview: snapshot['total_review'] as int,
      hotelId: snapshot.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'information': information,
      'location': location,
      'location_description': locationDescription,
      'name': name,
      'price': price,
      'rating': rating,
      'total_review': totalReview,
      'hotel_id': hotelId,
    };
  }

  factory HotelModel.fromJson(Map<dynamic, dynamic> json) {
    return HotelModel(
      image: json['image'] ?? 'https://th.bing.com/th/id/OIP.KGs0xdGXGSk4qiX2CeAYHAHaHa?rs=1&pid=ImgDetMain',
      information: json['information'] ?? 'No information',
      location: json['location'] ?? 'No location',
      locationDescription: json['location_description'] ?? 'No location description',
      name: json['name'] ?? 'No name',
      price: json['price'] ?? 0,
      rating: json['rating'],
      totalReview: json['total_review'] ?? 0,
      hotelId: json['hotel_id'] ?? 'No hotel id',
    );
  }
}

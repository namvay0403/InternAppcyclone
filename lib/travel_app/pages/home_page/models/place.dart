import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceModel {
  final String image;
  final String name;
  final dynamic rating;

  PlaceModel({
    required this.image,
    required this.name,
    required this.rating,
  });

  static PlaceModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return PlaceModel(
      image: snapshot.data()!['image'] ?? 'https://th.bing.com/th/id/OIP.KGs0xdGXGSk4qiX2CeAYHAHaHa?rs=1&pid=ImgDetMain',
      name: snapshot.data()!['name'] ?? 'No name',
      rating: snapshot.data()!['rating'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'rating': rating,
    };
  }
}

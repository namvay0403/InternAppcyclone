import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern_appcyclone/travel_app/pages/global/repository/repository.dart';

import '../models/booking.dart';

class BookingRepository implements GlobalRepository {
  // Future<void> createBooking({required BookingModel booking}) async {
  //   final bookingCollection = FirebaseFirestore.instance.collection("booking");
  //   final String id = bookingCollection.doc().id;
  //   print('doc id: $id');
  //   await bookingCollection.doc(id).set(booking.toJson());
  // }
  
  @override
  Future fetchData() {
    // TODO: implement fetchData
    throw UnimplementedError();
  }
  
  @override
  Future<void> createBooking({required booking}) async {
    final bookingCollection = FirebaseFirestore.instance.collection("booking");
    final String id = bookingCollection.doc().id;
    print('doc id: $id');
    await bookingCollection.doc(id).set(booking.toJson());
  }
}

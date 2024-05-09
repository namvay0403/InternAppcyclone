import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/booking.dart';

class BookingRepository {
  Future<void> createBooking({required BookingModel booking}) async {
    final bookingCollection = FirebaseFirestore.instance.collection("booking");
    final String id = bookingCollection.doc().id;
    print('doc id: $id');
    await bookingCollection.doc(id).set(booking.toJson());
  }
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/models/flight.dart';
import 'package:intern_appcyclone/travel_app/pages/global/repository/repository.dart';

import '../models/booking_flight_model.dart';

class FlightRepository implements GlobalRepository {
  // Future<List<FlightModel>> fetchFlightData() async {
  //   try {
  //     final userCollection = FirebaseFirestore.instance.collection("flight");
  //     List<FlightModel> flightData = [];
  //     await userCollection.get().then((value) {
  //       value.docs.forEach((element) {
  //         FlightModel flight = FlightModel.fromSnapshot(element);
  //         print(flight.seat![1]['1']);
  //         flightData.add(flight);
  //       });
  //     });
  //     return flightData;
  //     // return  userCollection.get().then((value) =>
  //     //     value.docs.map((e) => FlightModel.fromSnapshot(e)).toList());
  //   } catch (e) {
  //     print(e.toString());
  //     throw e.toString();
  //   }
  // }

  // Future<void> createBooking({required BookingFlightModel booking}) async {
  //   final bookingCollection = FirebaseFirestore.instance.collection("booking_flight");
  //   final String id = bookingCollection.doc().id;
  //   print('doc id: $id');
  //   await bookingCollection.doc(id).set(booking.toJson());
  // }
  
  @override
  Future<List<FlightModel>> fetchData() async {
    try {
      final userCollection = FirebaseFirestore.instance.collection("flight");
      List<FlightModel> flightData = [];
      await userCollection.get().then((value) {
        value.docs.forEach((element) {
          FlightModel flight = FlightModel.fromSnapshot(element);
          print(flight.seat![1]['1']);
          flightData.add(flight);
        });
      });
      return flightData;
      // return  userCollection.get().then((value) =>
      //     value.docs.map((e) => FlightModel.fromSnapshot(e)).toList());
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
  
  @override
  Future<void> createBooking({required booking}) async {
    final bookingCollection = FirebaseFirestore.instance.collection("booking_flight");
    final String id = bookingCollection.doc().id;
    print('doc id: $id');
    await bookingCollection.doc(id).set(booking.toJson());
  }
}

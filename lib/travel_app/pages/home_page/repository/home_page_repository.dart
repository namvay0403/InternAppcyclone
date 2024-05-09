import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern_appcyclone/travel_app/pages/home_page/models/place.dart';

class HomePageRepository {
  Stream<List<PlaceModel>> fetchHomePageData() {
    // final userCollection = FirebaseFirestore.instance.collection("place");

    // try {
    //   QuerySnapshot querySnapshot = await userCollection.get();
    //   // Get data from docs and convert map to List
    //   final allData =
    //       querySnapshot.docs.map((doc) => (doc.data())).toList() as List<dynamic>;

    //   print('length of data: ${allData.length}');
    //   return allData;
    // } catch (e) {
    //   throw e.toString();
    // }
    try {
      final userCollection = FirebaseFirestore.instance.collection("place");
      return userCollection
          .snapshots()
          .map((qureySnapshot) => qureySnapshot.docs.map(
                (e) {
                  return PlaceModel.fromSnapshot(e);
                },
              ).toList());
    } catch (e) {
      throw e.toString();
    }
  }
}

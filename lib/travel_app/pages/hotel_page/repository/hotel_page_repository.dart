import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/models/hotel.dart';

class HotelPageRepository {
  Future<List<HotelModel>> fetchHotelPageData() async {
    try {
      final userCollection = FirebaseFirestore.instance.collection("hotel");
      // return userCollection
      //     .snapshots()
      //     .map((qureySnapshot) => qureySnapshot.docs.map(
      //           (e) {
      //             return HotelModel.fromSnapshot(e);
      //           },
      //         ).toList());
      return userCollection.get().then((querySnapshot) {
        return querySnapshot.docs.map((e) {
          return HotelModel.fromSnapshot(e);
        }).toList();
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<HotelModel>> fetchHotelPageDataWithCondition(
      {String searchText = '',
      int fromPrice = 1,
      int toPrice = 100000000}) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection("hotel");
      // print(userCollection.snapshots().length.toString());
      // print(searchText);
      // return userCollection
      //     .where(
      //       'name',
      //       isGreaterThanOrEqualTo: searchText.isEmpty ? 0 : searchText,
      //       isLessThan: searchText.isEmpty
      //           ? null
      //           : searchText.substring(0, searchText.length - 1) +
      //               String.fromCharCode(
      //                 searchText.codeUnitAt(searchText.length - 1) + 1,
      //               ),
      //     )
      //     .snapshots()
      //     .map((qureySnapshot) => qureySnapshot.docs
      //         .map(
      //           (e) => HotelModel.fromSnapshot(e),
      //         )
      //         .toList());
      // return userCollection
      //     .snapshots()
      //     .map((qureySnapshot) => qureySnapshot.docs
      //         .map(
      //           (e) => HotelModel.fromSnapshot(e),
      //         )
      //         .where(
      //           (element) => element.name
      //               .toLowerCase()
      //               .contains(searchText.toLowerCase()),
      //         )
      //         .toList());
      return userCollection.get().then((querySnapshot) {
        return querySnapshot.docs
            .map((e) => HotelModel.fromSnapshot(e))
            .where(
              (element) =>
                  element.name
                      .toLowerCase()
                      .contains(searchText.toLowerCase()) &&
                  element.price >= fromPrice &&
                  element.price <= toPrice,
            )
            .toList();
      });
    } catch (e) {
      throw e.toString();
    }
  }
}

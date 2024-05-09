import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern_appcyclone/travel_app/pages/room_page/models/room_model.dart';

class RoomRepository {
  Stream<List<RoomModel>> fetchRoomPageDataWithHotelId(String hotelId) {
    print(hotelId);

    try {
      final userCollection = FirebaseFirestore.instance.collection("room");
      return userCollection
          .where(
            'hotel',
            isGreaterThanOrEqualTo: hotelId.isEmpty ? 0 : hotelId,
            isLessThan: hotelId.isEmpty
                ? null
                : hotelId.substring(0, hotelId.length - 1) +
                    String.fromCharCode(
                      hotelId.codeUnitAt(hotelId.length - 1) + 1,
                    ),
          )
          .snapshots()
          .map((qureySnapshot) => qureySnapshot.docs
              .map(
                (e) => RoomModel.fromSnapshot(e),
              )
              .toList());
    } catch (e) {
      throw e.toString();
    }
  }
}

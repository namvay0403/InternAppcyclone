import 'dart:convert';


import '../../../../main.dart';
import '../../hotel_page/models/hotel.dart';

const List<String> wishListKey = ['onboarding', 'language'];

class Helper {
  // late SharedPreferences prefs;


  void addWishList(HotelModel hotelModel) {
    try {
      // prefs = await SharedPreferences.getInstance();
      var result = jsonEncode(hotelModel.toJson());
      prefs.setString(hotelModel.hotelId, result);
    } catch (e) {
      throw e.toString();
    }
  }

  List<HotelModel> removeWishList(String hotelId) {
    try {
      // prefs = await SharedPreferences.getInstance();
      prefs.remove(hotelId);
      return readWishList();
    } catch (e) {
      throw e.toString();
    }
  }

  // Stream<List<HotelModel>> readWishList() async* {
  //   prefs = await SharedPreferences.getInstance();
  //   List<String> wishListString = prefs.getKeys().toList();
  //   List<HotelModel> wishList = [];
  //   try {
  //     wishListString.forEach((element) {
  //       var result = prefs.getString(element);
  //       print(result);
  //       wishList.add(HotelModel.fromJson(jsonDecode(result!)));
  //     });
  //     print('wishList lenght: ${wishList.length}');
  //     yield wishList;
  //   } catch (e) {
  //     yield [];
  //   }
  // }

  List<HotelModel> readWishList() {
    // prefs = await SharedPreferences.getInstance();
    var wishListString = prefs.getKeys();
    List<HotelModel> wishList = [];
    try {
      // print('lenght item : ${wishListString}');
      wishListString.forEach((element) {
        if (wishListKey.contains(element) == false) {
          var result = prefs.getString(element);
          var decode = jsonDecode(result!);

          wishList.add(HotelModel.fromJson(decode));
        }
      });
      // print('wishList lenght: ${wishList.length}');
      return wishList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  bool checkIndex(String hotelId, List<HotelModel> hotels) {
    for (var element in hotels) {
      if (element.hotelId == hotelId) {
        return true;
      }
    }
    return false;
  }
}

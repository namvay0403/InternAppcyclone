import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/models/hotel.dart';

import '../../helper/helper.dart';

part 'remove_wishlist_state.dart';

class RemoveWishlistCubit extends Cubit<RemoveWishlistState> {
  RemoveWishlistCubit() : super(RemoveWishlistInitial());

  Future<void> removeWishlist(String hotelId) async {
    try {
      emit(RemoveWishlistLoading());
      Future.delayed(const Duration(seconds: 1));
      var response = await Helper().removeWishList(hotelId);
      emit(RemoveWishlistSuccess(response));
    } catch (e) {
      emit(RemoveWishlistFailed(e.toString()));
    }
  }
}

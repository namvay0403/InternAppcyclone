part of 'remove_wishlist_cubit.dart';

sealed class RemoveWishlistState extends Equatable {
  const RemoveWishlistState();

  @override
  List<Object> get props => [];
}

final class RemoveWishlistInitial extends RemoveWishlistState {

}

final class RemoveWishlistLoading extends RemoveWishlistState {}

final class RemoveWishlistSuccess extends RemoveWishlistState {
  final List<HotelModel> wishListHotels;

  RemoveWishlistSuccess(this.wishListHotels);

  @override
  List<Object> get props => [wishListHotels];
}

final class RemoveWishlistFailed extends RemoveWishlistState {
  final String message;

  RemoveWishlistFailed(this.message);

  @override
  List<Object> get props => [message];
}

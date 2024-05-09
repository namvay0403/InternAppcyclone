part of 'get_data_hotel_cubit.dart';

sealed class GetDataHotelState extends Equatable {
  const GetDataHotelState();

  @override
  List<Object> get props => [];
}

final class GetDataHotelInitial extends GetDataHotelState {}

final class GetDataHotelLoading extends GetDataHotelState {}
final class GetDataHotelSuccess extends GetDataHotelState {
  final List<HotelModel> listHotel;

  const GetDataHotelSuccess(this.listHotel);

  @override
  List<Object> get props => [listHotel];
}
final class GetDataHotelFailed extends GetDataHotelState {
  final String message;

  const GetDataHotelFailed(this.message);

  @override
  List<Object> get props => [message];
}


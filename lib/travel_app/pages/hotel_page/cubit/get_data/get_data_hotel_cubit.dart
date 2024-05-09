import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/hotel.dart';
import '../../repository/hotel_page_repository.dart';

part 'get_data_hotel_state.dart';

class GetDataHotelCubit extends Cubit<GetDataHotelState> {
  GetDataHotelCubit() : super(GetDataHotelInitial());

  Future<void> getData() async {
    try {
      emit(GetDataHotelLoading());
      final listHotel = await HotelPageRepository().fetchHotelPageData();
      listHotel.sort((a, b) => a.price.compareTo(b.price));

      emit(GetDataHotelSuccess(listHotel));
    } catch (e) {
      emit(GetDataHotelFailed(e.toString()));
    }
  }

  Future<void> getDataWithCondition(
      {String searchText = '',
      int fromPrice = 1,
      int toPrice = 100000}) async {
    try {
      emit(GetDataHotelLoading());
      final listHotel = await HotelPageRepository()
          .fetchHotelPageDataWithCondition(
              searchText: searchText, fromPrice: fromPrice, toPrice: toPrice);
      listHotel.sort((a, b) => a.price.compareTo(b.price));
      emit(GetDataHotelSuccess(listHotel));
    } catch (e) {
      emit(GetDataHotelFailed(e.toString()));
    }
  }
}

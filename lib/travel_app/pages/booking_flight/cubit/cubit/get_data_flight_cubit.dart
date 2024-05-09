
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/flight.dart';
import '../../repository/flight_repository.dart';

part 'get_data_flight_state.dart';

class GetDataFlightCubit extends Cubit<GetDataFlightState> {
  GetDataFlightCubit() : super(GetDataFlightInitial(flightData: []));

  // void fetchFlightData() async {
  //   emit(GetDataFlightLoading(flightData: state.flightData));
  //   try {
  //     state.flightData = await FlightRepository().fetchFlightData();
  //     print('state.flightData: ${state.flightData}');
  //     emit(GetDataFlightSuccess(flightData: state.flightData));
  //   } catch (e) {
  //     emit(GetDataFlightFailed(
  //         flightData: state.flightData, message: e.toString()));
  //   }
  // }

  void filterFlightData(String from, String to, String departureDate) async {
    emit(GetDataFlightLoading(flightData: state.flightData));
    var departureDateTime = DateTime(
        int.parse(departureDate.split('-')[0]),
        int.parse(departureDate.split('-')[1]),
        int.parse(departureDate.split('-')[2]));
    try {
      state.flightData = await FlightRepository().fetchFlightData();
      List<FlightModel> flightData = [];
      flightData = state.flightData
          .where(
            (element) =>
                element.fromPlace == from &&
                element.toPlace == to &&
                element.departureTime!.difference(departureDateTime).inDays ==
                    0,
          )
          .toList();

      print('flightData: $flightData');
      state.flightData = flightData;
      emit(GetDataFlightSuccess(flightData: state.flightData));
    } catch (e) {
      emit(GetDataFlightFailed(
          flightData: state.flightData, message: e.toString()));
    }
  }
}

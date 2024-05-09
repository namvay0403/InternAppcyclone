part of 'get_data_flight_cubit.dart';

// ignore: must_be_immutable
class GetDataFlightState extends Equatable {
  GetDataFlightState({required this.flightData});

  List<FlightModel> flightData = [];

  @override
  List<Object> get props => [flightData];
}

// ignore: must_be_immutable
class GetDataFlightInitial extends GetDataFlightState {
  GetDataFlightInitial({required super.flightData});
}

// ignore: must_be_immutable
class GetDataFlightLoading extends GetDataFlightState {
  GetDataFlightLoading({required super.flightData});
}

// ignore: must_be_immutable
class GetDataFlightSuccess extends GetDataFlightState {
  GetDataFlightSuccess({required super.flightData});
}

// ignore: must_be_immutable
class GetDataFlightFailed extends GetDataFlightState {
  final String message;
  GetDataFlightFailed({required super.flightData, required this.message});
}

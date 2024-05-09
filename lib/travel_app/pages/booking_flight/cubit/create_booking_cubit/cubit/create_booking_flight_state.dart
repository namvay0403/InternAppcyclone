part of 'create_booking_flight_cubit.dart';

sealed class CreateBookingFlightState extends Equatable {
  const CreateBookingFlightState();

  @override
  List<Object> get props => [];
}

final class CreateBookingFlightInitial extends CreateBookingFlightState {}

final class CreateBookingFlightLoading extends CreateBookingFlightState {}

final class CreateBookingFlightSuccess extends CreateBookingFlightState {}

final class CreateBookingFlightFailed extends CreateBookingFlightState {
  final String message;

  CreateBookingFlightFailed(this.message);

  @override
  List<Object> get props => [message];
}

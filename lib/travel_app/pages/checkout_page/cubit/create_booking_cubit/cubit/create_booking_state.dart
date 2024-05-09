part of 'create_booking_cubit.dart';

sealed class CreateBookingState extends Equatable {
  const CreateBookingState();

  @override
  List<Object> get props => [];
}

final class CreateBookingInitial extends CreateBookingState {}

final class CreateBookingLoading extends CreateBookingState {}

final class CreateBookingSuccess extends CreateBookingState {}

final class CreateBookingFailed extends CreateBookingState {
  final String message;

  const CreateBookingFailed(this.message);

  @override
  List<Object> get props => [message];
}

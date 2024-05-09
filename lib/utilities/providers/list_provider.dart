import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/practice/week02/localization/bloc/localization_bloc/localization_bloc.dart';
import 'package:intern_appcyclone/travel_app/authentication/cubit/user_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/account_page/cubit/cubit/change_profile_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/create_booking_cubit/cubit/create_booking_flight_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/booking_flight/cubit/save_data_booking_flight/cubit/save_booking_flight_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/cubit/create_booking_cubit/cubit/create_booking_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/cubit/save_booking_info_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/cubit/filter_condition/filter_condition_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/cubit/get_data/get_data_hotel_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/login_page/login_bloc/bloc/login_bloc.dart';
import 'package:intern_appcyclone/travel_app/authentication/repository/auth_repository.dart';
import 'package:intern_appcyclone/travel_app/pages/signup_page/signup_bloc/bloc/signup_bloc.dart';

import '../../travel_app/pages/login_page/logout_cubit/cubit/logout_cubit.dart';

final AuthRepository authRepository = AuthRepository();

final listProvider = [
  BlocProvider<LocalizationBloc>(
    create: (context) => LocalizationBloc()..add(LoadSavedLocalization()),
  ),
  // BlocProvider<LoginBloc>(
  //   create: (context) => LoginBloc(),
  // ),
  // BlocProvider<SignupBloc>(
  //   create: (context) => SignupBloc(),
  // ),
  BlocProvider<UserCubit>(
    create: (context) => UserCubit(),
  ),
  // BlocProvider<LogoutCubit>(
  //   create: (context) => LogoutCubit(),
  // ),
  BlocProvider<SaveInfoBooking>(
    create: (context) => SaveInfoBooking(),
  ),
  // BlocProvider<CreateBookingCubit>(
  //   create: (context) => CreateBookingCubit(),
  // ),
  BlocProvider<SaveBookingFlightCubit>(
    create: (context) => SaveBookingFlightCubit(),
  ),

  // BlocProvider<CreateBookingFlightCubit>(
  //   create: (context) => CreateBookingFlightCubit(),
  // ),

  // BlocProvider<ChangeProfileCubit>(
  //   create: (context) => ChangeProfileCubit(),
  // ),

  // BlocProvider<GetDataHotelCubit>(
  //   create: (context) => GetDataHotelCubit(),
  // ),
  // BlocProvider<FilterConditionCubit>(
  //   create: (context) => FilterConditionCubit(),
  // ),
];

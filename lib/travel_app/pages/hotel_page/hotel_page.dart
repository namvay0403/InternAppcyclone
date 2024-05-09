import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/cubit/filter_condition/filter_condition_cubit.dart';

import 'cubit/get_data/get_data_hotel_cubit.dart';
import 'hotel_screen.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterConditionCubit(),
      child: BlocProvider(
        create: (context) => GetDataHotelCubit(),
        child: const HotelScreen(),
      ),
    );
  }
}

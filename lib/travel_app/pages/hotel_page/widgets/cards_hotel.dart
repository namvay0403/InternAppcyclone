import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/cubit/filter_condition/filter_condition_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/cubit/get_data/get_data_hotel_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/widgets/card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/utilities/const/page_name.dart';

import '../../../../utilities/const/const.dart';

class CardsHotel extends StatefulWidget {
  const CardsHotel({super.key});

  @override
  State<CardsHotel> createState() => _CardsHotelState();
}

class _CardsHotelState extends State<CardsHotel> {
  ValueNotifier<String> searchText = ValueNotifier('');
  late FilterConditionCubit filterConditionCubit;

  @override
  void dispose() {
    super.dispose();
    searchText.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<GetDataHotelCubit>().getData();
    filterConditionCubit = context.read<FilterConditionCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: searchText,
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    style: const TextStyle(fontFamily: fontApp),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.search,
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      filterConditionCubit.state.searchText = value;
                      context.read<GetDataHotelCubit>().getDataWithCondition(
                          searchText: filterConditionCubit.state.searchText,
                          fromPrice: filterConditionCubit.state.minPrice,
                          toPrice: filterConditionCubit.state.maxPrice);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // StreamBuilder<List<HotelModel>>(
                //   stream: searchText.value != ''
                //       ? HotelPageRepository()
                //           .fetchHotelPageDataWithCondition(searchText.value)
                //       : HotelPageRepository().fetchHotelPageData(),
                //   builder: ((context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     }

                //     if (snapshot.hasError) {
                //       return Center(
                //         child: Text(AppLocalizations.of(context)!.error),
                //       );
                //     }
                //     if (snapshot.hasData) {
                //       return ListView.builder(
                //         shrinkWrap: true,
                //         physics: const NeverScrollableScrollPhysics(),
                //         itemCount: snapshot.data!.length,
                //         itemBuilder: (context, index) {
                //           var hotel = snapshot.data![index];
                //           return CardCustom(
                //             hotelModel: hotel,
                //             onTap: () {
                //               Navigator.pushNamed(
                //                 context,
                //                 PageName.DetailHotel,
                //                 arguments: hotel,
                //               );
                //             },
                //           );
                //         },
                //       );
                //     } else {
                //       return const Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     }
                //   }),
                // ),
                BlocBuilder<GetDataHotelCubit, GetDataHotelState>(
                  builder: (context, state) {
                    if (state is GetDataHotelLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetDataHotelFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else if (state is GetDataHotelSuccess) {
                      return state.listHotel.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.listHotel.length,
                              itemBuilder: (context, index) {
                                var hotel = state.listHotel[index];
                                return CardCustom(
                                  hotelModel: hotel,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      PageName.DetailHotel,
                                      arguments: hotel,
                                    );
                                  },
                                );
                              },
                            )
                          : const Center(
                              child: Text('No Hotel Found'),
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/cubit/get_data/get_data_hotel_cubit.dart';
import 'package:intern_appcyclone/utilities/const/app_assets.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utilities/button/back_button.dart';
import 'cubit/filter_condition/filter_condition_cubit.dart';
import 'widgets/cards_hotel.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  TextEditingController fromPriceController = TextEditingController();
  TextEditingController toPriceController = TextEditingController();

  late GetDataHotelCubit getDataHotelCubit;
  late FilterConditionCubit filterDataHotelCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getDataHotelCubit = context.read<GetDataHotelCubit>();
    filterDataHotelCubit = context.read<FilterConditionCubit>();
  }

  @override
  void dispose() {
    fromPriceController.dispose();
    toPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          getDataHotelCubit.getData();
          fromPriceController.clear();
          toPriceController.clear();
        },
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: buttonBack(Icons.arrow_back, context, null),
                expandedHeight: 220,
                pinned: true,
                centerTitle: false,
                backgroundColor: AppColor.primaryColor,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    AppLocalizations.of(context)!.hotel,
                    style: AppStyle.heading.copyWith(color: Colors.white),
                  ),
                  expandedTitleScale: 1.5,
                  background: Image.asset(
                    AppAssets.appbar,
                    fit: BoxFit.contain,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            // var getDataHotelgetDataHotelCubit =
                            //     context.read<GetDataHotelgetDataHotelCubit>();
                            showDialogCustom(
                                fromPriceController, toPriceController);
                          },
                          child: const Icon(
                            Icons.filter_list,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const CardsHotel(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showDialogCustom(
    TextEditingController fromPriceController,
    TextEditingController toPriceController,
  ) {
    return showDialog(
        context: context,
        builder: (context) {
          return BlocProvider.value(
            value: filterDataHotelCubit,
            child: BlocProvider.value(
              value: getDataHotelCubit,
              child: SizedBox(
                width: 200,
                height: 100,
                child: AlertDialog(
                    title: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.filter,
                          style: AppStyle.heading.copyWith(color: Colors.black),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    content: SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.price,
                            style:
                                AppStyle.heading.copyWith(color: Colors.black),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.from,
                                style: AppStyle.heading
                                    .copyWith(color: Colors.black),
                              ),
                              Text(
                                AppLocalizations.of(context)!.to,
                                style: AppStyle.heading
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: fromPriceController,
                                  style: AppStyle.heading.copyWith(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixText: '\$',
                                    prefixStyle: AppStyle.heading.copyWith(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: toPriceController,
                                  style: AppStyle.heading.copyWith(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixText: '\$',
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixStyle: AppStyle.heading.copyWith(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  fromPriceController.clear();
                                  toPriceController.clear();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.grey),
                                ),
                                child: Text(
                                  'Clear',
                                  style: AppStyle.heading
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  filterDataHotelCubit.state.maxPrice =
                                      toPriceController.text.isNotEmpty
                                          ? int.parse(toPriceController.text)
                                          : 100000;
                                  filterDataHotelCubit.state.minPrice =
                                      fromPriceController.text.isEmpty
                                          ? 1
                                          : int.parse(fromPriceController.text);
                                  getDataHotelCubit.getDataWithCondition(
                                      fromPrice:
                                          filterDataHotelCubit.state.minPrice,
                                      searchText:
                                          filterDataHotelCubit.state.searchText,
                                      toPrice:
                                          filterDataHotelCubit.state.maxPrice);
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColor.primaryColor),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.apply,
                                  style: AppStyle.heading
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          );
        });
  }
}

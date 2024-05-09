import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/authentication/cubit/user_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/checkout_page_step1.dart';
import 'package:intern_appcyclone/travel_app/pages/room_page/models/room_model.dart';
import 'package:intern_appcyclone/travel_app/pages/room_page/repository/room_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/travel_app/pages/room_page/widgets/card_room.dart';
import 'package:intern_appcyclone/utilities/const/page_name.dart';
import 'package:intern_appcyclone/utilities/const/route.dart';

import '../../../../utilities/button/linear_button.dart';
import '../../../../utilities/const/const.dart';
import '../../../../utilities/const/styles.dart';
import '../../hotel_page/widgets/card.dart';
import '../const/service.dart';

class CardsRoom extends StatefulWidget {
  const CardsRoom({super.key, required this.hotelId});

  final String hotelId;

  @override
  State<CardsRoom> createState() => _CardsRoomState();
}

class _CardsRoomState extends State<CardsRoom> {
  TextEditingController searchTextController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: TextFormField(
          //     controller: searchTextController,
          //     style: const TextStyle(fontFamily: fontApp),
          //     decoration: InputDecoration(
          //       hintText: 'Search',
          //       prefixIcon: const Icon(Icons.search, color: Colors.grey),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10),
          //         borderSide: BorderSide.none,
          //       ),
          //       contentPadding: const EdgeInsets.symmetric(
          //         horizontal: 20,
          //         vertical: 10,
          //       ),
          //       filled: true,
          //       fillColor: Colors.white,
          //     ),

          //     // find another solutions ?????
          //     onChanged: (value) {
          //       setState(() {
          //         searchTextController.text = value;
          //       });
          //     },
          //   ),
          // ),
          // const SizedBox(height: 10),
          StreamBuilder<List<RoomModel>>(
            stream:
                RoomRepository().fetchRoomPageDataWithHotelId(widget.hotelId),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                    child: Text(AppLocalizations.of(context)!.noData));
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var room = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: CardRoom(
                          room: room,
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) => CheckOutPage(roomModel: room),
                            //   ),
                            // );
                            Navigator.pushNamed(
                              context,
                              PageName.CheckOut,
                              arguments: room,
                            );
                          }),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

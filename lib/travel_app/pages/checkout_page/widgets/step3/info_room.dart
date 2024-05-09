import 'package:flutter/material.dart';
import 'package:intern_appcyclone/travel_app/pages/room_page/models/room_model.dart';

import '../../../room_page/widgets/card_room.dart';

class InfoRoom extends StatelessWidget {
  const InfoRoom({super.key, required this.room});

  final RoomModel room;

  @override
  Widget build(BuildContext context) {
    return CardRoom(
      room: room,
      onTap: () {},
      isCheckButton: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intern_appcyclone/travel_app/pages/room_page/widgets/cards_room.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';

import '../../../utilities/appbar/appbar_normal.dart';
import '../../../utilities/const/colors.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({super.key, required this.hotelId});

  final String hotelId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
          context, AppLocalizations.of(context)!.selectRoom, '',
          isBack: true),
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.backgroundColor,
          child: Column(
            children: [
              CardsRoom(hotelId: hotelId),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/models/hotel.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';

import '../../../utilities/button/back_button.dart';
import 'widgets/modal_bottom_sheet.dart';

class DetailHotelPage extends StatelessWidget {
  const DetailHotelPage({super.key, required this.hotelModel});

  final HotelModel hotelModel;

  @override
  Widget build(BuildContext context) {
    print(hotelModel.hotelId);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                hotelModel.image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: buttonBack(
                Icons.arrow_back,
                context,
                null,
              ),
            ),
            ModalBottomSheet(hotelModel: hotelModel),
          ],
        ),
      ),
    );
  }
}

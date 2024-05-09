import 'package:flutter/material.dart';
import 'package:intern_appcyclone/utilities/const/page_name.dart';

import '../../../../utilities/button/linear_button.dart';
import '../../../../utilities/const/styles.dart';
import '../../hotel_page/models/hotel.dart';
import '../../room_page/room_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContentModal extends StatelessWidget {
  const ContentModal({super.key, required this.hotelModel, required this.scrollController});

  final HotelModel hotelModel;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    hotelModel.name,
                    style: AppStyle.heading.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text.rich(
                    textAlign: TextAlign.end,
                    TextSpan(
                      text: '\$${hotelModel.price}',
                      style: AppStyle.heading
                          .copyWith(color: Colors.black, fontSize: 20),
                      children: [
                        TextSpan(
                          text: '/${AppLocalizations.of(context)!.night}',
                          style: AppStyle.normal.copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                const SizedBox(width: 5),
                Text(
                  hotelModel.location,
                  style: AppStyle.normal.copyWith(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 0.2,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                const SizedBox(width: 5),
                Text.rich(
                  TextSpan(
                    text: '${hotelModel.rating}/5',
                    children: <InlineSpan>[
                      TextSpan(
                        text:
                            ' (${hotelModel.totalReview} ${AppLocalizations.of(context)!.reviews})',
                        style: AppStyle.normal.copyWith(color: Colors.grey),
                      )
                    ],
                  ),
                  style: AppStyle.normal.copyWith(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 0.2,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.information,
                  style: AppStyle.heading.copyWith(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              hotelModel.information,
              style: AppStyle.normal.copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 0.2,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.location,
                  style: AppStyle.heading.copyWith(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              hotelModel.locationDescription,
              style: AppStyle.normal.copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonGradient(
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   return RoomPage(hotelId: hotelModel.hotelId);
                // }));
                Navigator.of(context).pushNamed(
                  PageName.Room,
                  arguments: hotelModel.hotelId,
                );
              },
              text: AppLocalizations.of(context)!.bookNow,
            )
          ],
        ),
      ),
    );
  }
}

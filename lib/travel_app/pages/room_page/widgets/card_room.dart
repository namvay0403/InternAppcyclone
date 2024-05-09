import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/travel_app/pages/room_page/models/room_model.dart';
import 'package:intern_appcyclone/utilities/global/global.dart';

import '../../../../utilities/button/linear_button.dart';
import '../../../../utilities/const/styles.dart';
import '../const/service.dart';
import 'card_service.dart';

class CardRoom extends StatelessWidget {
  const CardRoom({
    super.key,
    required this.room,
    this.onTap,
    this.isCheckButton = true,
  });

  final RoomModel room;
  final Function()? onTap;
  final bool isCheckButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        room.name,
                        style: AppStyle.heading
                            .copyWith(color: Colors.black, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        room.typePrice,
                        style: AppStyle.normal.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                          room.image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
            SizedBox(
              height: 90,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: room.services.length,
                  itemBuilder: (context, index) {
                    var service = room.services[index];
                    var serviceData = Services.serviceData(service);
                    return CardService(
                        nameService: serviceData.name,
                        iconService: serviceData.icon);
                  }),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: '\$${room.price}',
                      style: AppStyle.heading
                          .copyWith(color: Colors.black, fontSize: 24),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '\n/${AppLocalizations.of(context)!.night}',
                          style: AppStyle.normal.copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                isCheckButton
                    ? Expanded(
                        child: ButtonGradient(
                          onTap: () {
                            onTap!();
                          },
                          text: AppLocalizations.of(context)!.bookNow,
                        ),
                      )
                    : ValueListenableBuilder(
                        valueListenable: Count().count,
                        builder: ((context, value, child) => Text(
                              '$value ${AppLocalizations.of(context)!.night}',
                              style: AppStyle.heading
                                  .copyWith(color: Colors.black),
                            )),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_appcyclone/travel_app/pages/favourite_page/helper/helper.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/models/hotel.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utilities/button/linear_button.dart';

class CardCustom extends StatefulWidget {
  const CardCustom({super.key, required this.hotelModel, required this.onTap});

  final HotelModel hotelModel;
  final Function()? onTap;

  @override
  State<CardCustom> createState() => _CardCustomState();
}

class _CardCustomState extends State<CardCustom> {
  ValueNotifier<bool> isFavouriteNotifier = ValueNotifier<bool>(false);
  late List<HotelModel> wishListHotels = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWishList();
  }

  Future<void> getWishList() async {
    wishListHotels = await Helper().readWishList();
    isFavouriteNotifier.value =
        Helper().checkIndex(widget.hotelModel.hotelId, wishListHotels);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.hotelModel.image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: isFavouriteNotifier,
                      builder: (BuildContext context, value, Widget? child) {
                        return InkWell(
                          onTap: () {
                            isFavouriteNotifier.value =
                                !isFavouriteNotifier.value;

                            if (isFavouriteNotifier.value) {
                              Helper().addWishList(widget.hotelModel);
                            } else {
                              Helper()
                                  .removeWishList(widget.hotelModel.hotelId);
                            }
                          },
                          child: Icon(
                            Icons.favorite,
                            color: isFavouriteNotifier.value
                                ? Colors.red
                                : Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hotelModel.name,
                    style: AppStyle.heading
                        .copyWith(color: Colors.black, fontSize: 20),
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
                      Text(
                        widget.hotelModel.location,
                        style: AppStyle.normal.copyWith(color: Colors.black),
                      ),
                    ],
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
                      Text.rich(
                        TextSpan(
                          text: widget.hotelModel.rating.toString(),
                          children: <InlineSpan>[
                            TextSpan(
                              text:
                                  ' (${widget.hotelModel.totalReview} ${AppLocalizations.of(context)!.reviews})',
                              style:
                                  AppStyle.normal.copyWith(color: Colors.grey),
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
                    color: Colors.grey,
                    thickness: 0.3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: '\$${widget.hotelModel.price}',
                            style: AppStyle.heading
                                .copyWith(color: Colors.black, fontSize: 24),
                            children: <InlineSpan>[
                              TextSpan(
                                text:
                                    '\n/${AppLocalizations.of(context)!.night}',
                                style: AppStyle.normal
                                    .copyWith(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: ButtonGradient(
                        onTap: () {
                          widget.onTap!();
                        },
                        text: AppLocalizations.of(context)!.bookNow,
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

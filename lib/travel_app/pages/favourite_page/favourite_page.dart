import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/favourite_page/cubit/cubit/remove_wishlist_cubit.dart';
import 'package:intern_appcyclone/travel_app/pages/favourite_page/helper/helper.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/widgets/card.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/widgets/cards_hotel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/utilities/appbar/appbar.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';

import '../../../utilities/appbar/appbar_normal.dart';
import '../../../utilities/const/colors.dart';
import '../checkout_page/widgets/step1/content_appbar.dart';
import '../detail_hotel_page/detail_hotel_page.dart';
import '../hotel_page/models/hotel.dart';
import 'widgets/card_favorite.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late List<HotelModel> wishListHotels = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWishList();
  }

  Future<void> getWishList() async {
    wishListHotels = await Helper().readWishList();
    print(wishListHotels.length);
  }

  @override
  void didUpdateWidget(covariant FavoritePage oldWidget) {
    // TODO: implement didUpdateWidget
    if (widget != oldWidget) {
      setState(() {
        getWishList();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RemoveWishlistCubit(),
      child: Scaffold(
        appBar: appbarCustom(
          context,
          AppLocalizations.of(context)!.favoriteHotels,
          '',
        ),
        backgroundColor: AppColor.backgroundColor,
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              getWishList();
            });
          },
          child: SingleChildScrollView(
            child: Container(
              color: AppColor.backgroundColor,
              child: Column(
                children: [
                  // FutureBuilder(
                  //   future: Helper().readWishList(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState ==
                  //         ConnectionState.waiting) {
                  //       return const Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     }

                  //     if (snapshot.hasError) {
                  //       return Center(
                  //         child:
                  //             Text(AppLocalizations.of(context)!.error),
                  //       );
                  //     }
                  //     if (!snapshot.hasData) {
                  //       Center(
                  //         child: Text(
                  //             AppLocalizations.of(context)!.notWishList),
                  //       );
                  //     }
                  //     if (snapshot.hasData) {
                  //       return BlocBuilder<RemoveWishlistCubit,
                  //           RemoveWishlistState>(
                  //         builder: (context, state) {
                  //           if (state is RemoveWishlistInitial) {
                  //             return ListView.builder(
                  //               shrinkWrap: true,
                  //               physics:
                  //                   const NeverScrollableScrollPhysics(),
                  //               itemCount: snapshot.data!.length,
                  //               itemBuilder: (context, index) {
                  //                 var hotel = snapshot.data![index];
                  //                 return CardFavorite(
                  //                   hotelModel: hotel,
                  //                   onTap: () {
                  //                     Navigator.push(
                  //                         context,
                  //                         MaterialPageRoute(
                  //                             builder: (context) =>
                  //                                 DetailHotelPage(
                  //                                     hotelModel:
                  //                                         hotel)));
                  //                   },
                  //                 );
                  //               },
                  //             );
                  //           }
                  //           if (state is RemoveWishlistLoading) {
                  //             return const Center(
                  //               child: CircularProgressIndicator(),
                  //             );
                  //           }
                  //           if (state is RemoveWishlistSuccess) {
                  //             return ListView.builder(
                  //               shrinkWrap: true,
                  //               physics:
                  //                   const NeverScrollableScrollPhysics(),
                  //               itemCount: state.wishListHotels.length,
                  //               itemBuilder: (context, index) {
                  //                 var hotel = state.wishListHotels[index];
                  //                 return CardFavorite(
                  //                   hotelModel: hotel,
                  //                   onTap: () {
                  //                     Navigator.push(
                  //                         context,
                  //                         MaterialPageRoute(
                  //                             builder: (context) =>
                  //                                 DetailHotelPage(
                  //                                     hotelModel:
                  //                                         hotel)));
                  //                   },
                  //                 );
                  //               },
                  //             );
                  //           }
                  //           if (state is RemoveWishlistFailed) {
                  //             return Center(
                  //               child: Text(state.message),
                  //             );
                  //           }
                  //           return const Center(
                  //             child: CircularProgressIndicator(),
                  //           );
                  //         },
                  //       );
                  //     } else {
                  //       return const Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     }
                  //   },
                  // ),
                  const SizedBox(height: 10),

                  BlocBuilder<RemoveWishlistCubit, RemoveWishlistState>(
                    builder: (context, state) {
                      if (state is RemoveWishlistInitial) {
                        return Helper().readWishList().isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: Helper().readWishList().length,
                                itemBuilder: (context, index) {
                                  var hotel = Helper().readWishList()[index];
                                  return CardFavorite(
                                    hotelModel: hotel,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailHotelPage(
                                                      hotelModel: hotel)));
                                    },
                                  );
                                },
                              )
                            : Text(
                                AppLocalizations.of(context)!.notWishList,
                                style: AppStyle.heading.copyWith(
                                    color: Colors.black, fontSize: 15),
                              );
                      }
                      if (state is RemoveWishlistLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is RemoveWishlistSuccess) {
                        return state.wishListHotels.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.wishListHotels.length,
                                itemBuilder: (context, index) {
                                  var hotel = state.wishListHotels[index];
                                  return CardFavorite(
                                    hotelModel: hotel,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailHotelPage(
                                                      hotelModel: hotel)));
                                    },
                                  );
                                },
                              )
                            : Center(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 100),
                                    Text(
                                      AppLocalizations.of(context)!.notWishList,
                                      style: AppStyle.heading.copyWith(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                              );
                      }
                      if (state is RemoveWishlistFailed) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

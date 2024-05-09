import 'package:flutter/material.dart';
import 'package:intern_appcyclone/travel_app/pages/hotel_page/models/hotel.dart';

import '../../../../utilities/button/linear_button.dart';
import '../../../../utilities/const/styles.dart';
import 'content_modal_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModalBottomSheet extends StatefulWidget {
  const ModalBottomSheet({super.key, required this.hotelModel});

  final HotelModel hotelModel;

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration(seconds: 0)).then((_) {
    //   showModalBottomSheetCustom(context, widget.hotelModel);
    // });
  }

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: ButtonGradient(
    //     text: AppLocalizations.of(context)!.seeMore,
    //     onTap: () {
    //       // adding some properties
    //       // showModalBottomSheetCustom(context, widget.hotelModel);
    //       draggableView(widget.hotelModel);
    //     },
    //   ),
    // );
    return draggableView(widget.hotelModel);
  }

  Widget draggableView(HotelModel hotelModel) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.1,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: ContentModal(
            hotelModel: hotelModel,
            scrollController: scrollController,
          ),
        );
      },
    );
  }
}

Future<void> showModalBottomSheetCustom(context, HotelModel hotelModel) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    useSafeArea: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.8,
      maxWidth: MediaQuery.of(context).size.width,
    ),
    elevation: 10,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return ContentModal(
        hotelModel: hotelModel,
        scrollController: ScrollController(),
      );
    },
  );
}

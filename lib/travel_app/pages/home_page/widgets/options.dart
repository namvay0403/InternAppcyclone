import 'package:flutter/material.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/utilities/const/page_name.dart';
import 'package:intern_appcyclone/utilities/const/route.dart';

import '../../../../utilities/const/app_assets.dart';
import '../../../../utilities/const/styles.dart';
import '../../hotel_page/hotel_page.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: option(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const HotelPage()),
              // );
              Navigator.pushNamed(context, PageName.Hotel);
            },
            image: AppAssets.hotel,
            color: AppColor.hotel,
            title: AppLocalizations.of(context)!.hotel,
          ),
        ),
        Expanded(
          child: option(
            onTap: () {
              Navigator.pushNamed(context, PageName.BookingFlight);
            },
            image: AppAssets.flight,
            color: AppColor.flight,
            title: AppLocalizations.of(context)!.flight,
          ),
        ),
        Expanded(
          child: option(
            onTap: () {},
            image: AppAssets.all,
            color: AppColor.all,
            title: AppLocalizations.of(context)!.all,
          ),
        ),
      ],
    );
  }

  Widget option(
      {required String image,
      required String title,
      required Color color,
      required Function() onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 75,
            width: 95,
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: AppStyle.normal.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}

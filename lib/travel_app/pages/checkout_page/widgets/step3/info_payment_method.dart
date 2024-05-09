import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../utilities/const/styles.dart';
import '../../cubit/save_booking_info_cubit.dart';

class InfoPaymentMethod extends StatelessWidget {
  const InfoPaymentMethod({super.key, required this.typePayment});
  final String typePayment;

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
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Row(
          children: [
            const Expanded(
              child: Icon(
                Icons.payment,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.paymentMethod,
                    style: AppStyle.normal
                        .copyWith(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    typePayment,
                    style: AppStyle.heading
                        .copyWith(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.change,
                  style:
                      AppStyle.heading.copyWith(color: AppColor.primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

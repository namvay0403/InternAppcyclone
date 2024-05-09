import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/travel_app/pages/checkout_page/cubit/save_booking_info_cubit.dart';

import '../../../../../utilities/const/colors.dart';
import '../../../../../utilities/const/styles.dart';

class TimeChoose extends StatefulWidget {
  TimeChoose({super.key});

  @override
  State<TimeChoose> createState() => _TimeChooseState();
}

class _TimeChooseState extends State<TimeChoose> {
  TextEditingController checkInController =
      TextEditingController(text: DateTime.now().toString().split(" ")[0]);
  TextEditingController checkOutController = TextEditingController(
      text:
          DateTime.now().add(const Duration(days: 1)).toString().split(" ")[0]);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    checkInController.dispose();
    checkOutController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SaveInfoBooking>().state.dateStart = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        0,
        0,
        0,
        0,
        0);
    context.read<SaveInfoBooking>().state.dateEnd = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            0,
            0,
            0,
            0,
            0)
        .add(const Duration(days: 1));
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.watch_later_outlined,
                      color: AppColor.flight,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context)!.bookingDate,
                  style: AppStyle.heading.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                itemTime(
                    AppLocalizations.of(context)!.checkIn, checkInController),
                itemTime(
                    AppLocalizations.of(context)!.checkOut, checkOutController),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget itemTime(String type, TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: AppStyle.normal.copyWith(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextField(
                controller: controller,
                readOnly: true,
                style: AppStyle.normal.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.calendar_month_rounded,
                    color: AppColor.flight,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  filled: true,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                onTap: () {
                  _selectDate(context, controller);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      controller.text = picked.toString().split(" ")[0];
      if (controller == checkInController) {
        context.read<SaveInfoBooking>().state.dateStart = picked;
      } else {
        context.read<SaveInfoBooking>().state.dateEnd = picked;
      }
    }
  }
}

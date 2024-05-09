import 'package:flutter/material.dart';

import '../../../../../utilities/const/styles.dart';

class TextFormFieldFlight extends StatelessWidget {
  const TextFormFieldFlight({
    super.key,
    required this.label,
    required this.controller,
    required this.prefixImage,
    this.onTap,
    this.readOnly = false,
    this.suffix,
  });

  final String label;
  final TextEditingController controller;
  final String prefixImage;
  final Function()? onTap;
  final bool? readOnly;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                style: AppStyle.heading
                    .copyWith(fontSize: 16, color: Colors.black),
                controller: controller,
                readOnly: readOnly!,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: AppStyle.normal
                      .copyWith(color: Colors.grey, fontSize: 16),
                  prefixIcon: Image.asset(prefixImage, height: 20),
                  border: InputBorder.none,
                  suffixIcon: suffix,
                ),
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

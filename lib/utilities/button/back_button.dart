import 'package:flutter/material.dart';

Padding buttonBack(IconData icon, BuildContext context, Function()? onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            onTap == null ?  Navigator.pop(context) : onTap();
          },
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}

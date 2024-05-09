import 'package:flutter/material.dart';

import '../../../../utilities/const/styles.dart';

class CardService extends StatelessWidget {
  const CardService({super.key, required this.nameService, required this.iconService});

  final String nameService;
  final IconData iconService;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(iconService),
          ),
          Text(
            nameService,
            textAlign: TextAlign.center,
            style: AppStyle.normal.copyWith(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
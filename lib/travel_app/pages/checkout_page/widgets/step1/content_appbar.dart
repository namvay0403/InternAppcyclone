import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../utilities/const/styles.dart';

class ContentAppBar extends StatelessWidget {
  const ContentAppBar({super.key, required this.step, required this.content});

  final int step;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  step.toString(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              content,
              style: AppStyle.heading,
            ),
          ],
        ),
      ],
    );
  }
}

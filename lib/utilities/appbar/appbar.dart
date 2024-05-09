import 'package:flutter/material.dart';

import '../button/back_button.dart';
import '../const/app_assets.dart';

PreferredSize appbarCustom(context, String title, dynamic content,
    {bool isBack = false, Function()? onTap}) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(200),
      child: SizedBox(
        height: 220,
        child: Stack(
          children: [
            Image.asset(
              AppAssets.appbar,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 10),
                    content.runtimeType == String
                        ? Text(
                            content,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // const SizedBox(height: 10),
                              content,
                            ],
                          ),
                  ],
                ),
              ),
            ),
            isBack
                ? Positioned(
                    top: 35,
                    left: 25,
                    child: buttonBack(Icons.arrow_back, context, onTap),
                  )
                : Container(),
          ],
        ),
      ));
}

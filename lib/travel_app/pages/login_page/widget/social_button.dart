import 'package:flutter/material.dart';
import 'package:intern_appcyclone/utilities/const/const.dart';

class SocialButton extends StatelessWidget {
  const SocialButton(
      {super.key,
      required this.text,
      required this.textColor,
      required this.buttonColor,
      required this.image,
      this.onTap});
  final String text;
  final Color textColor;
  final Color buttonColor;
  final String image;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: buttonColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image),
              const SizedBox(width: 5),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontFamily: fontBoldApp,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

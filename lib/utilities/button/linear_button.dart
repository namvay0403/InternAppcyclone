import 'package:flutter/material.dart';
import 'package:intern_appcyclone/utilities/const/const.dart';

LinearGradient linearButton() {
  return const LinearGradient(
    colors: [
      // Color.fromARGB(1, 143, 103, 232),
      // Color.fromARGB(1, 99, 87, 204),
      Color(0xFF8F67E8),
      Color(0xFF6357CC),
    ],
    // begin: Alignment.bottomLeft,
    // end: Alignment.topRight,
  );
}

class ButtonGradient extends StatefulWidget {
  const ButtonGradient(
      {super.key,
      this.text,
      this.height = 50,
      this.width,
      required this.onTap,
      this.fontsize = 14});
  final String? text;
  final double? height;
  final double? width;
  final void Function()? onTap;
  final double? fontsize;

  @override
  State<ButtonGradient> createState() => _ButtonGradientState();
}

class _ButtonGradientState extends State<ButtonGradient> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      customBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: linearButton(),
        ),
        child: Center(
          child: Text(
            widget.text!,
            style: TextStyle(
                color: Colors.white,
                fontFamily: fontBoldApp,
                fontSize: widget.fontsize),
          ),
        ),
      ),
    );
  }
}

// InkWell buttonGradient(String? text, double? height, double? width,
//     Function? onTap, double? fontsize) {
//   return InkWell(
//     onTap: onTap!(),
//     child: Container(
//       height: height,
//       width: width,
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(50),
//         gradient: linearButton(),
//       ),
//       child: Center(
//         child: Text(
//           text!,
//           style: TextStyle(
//               color: Colors.white, fontFamily: fontBoldApp, fontSize: fontsize),
//         ),
//       ),
//     ),
//   );
// }

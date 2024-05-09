import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../const/const.dart';

class TextFormFieldCustom extends StatefulWidget {
  TextFormFieldCustom(
      {super.key,
      required this.hintText,
      this.iconPrefix,
      this.iconSuffix,
      this.isObscure = false,
      this.errorText,
      required this.label,
      this.prefixText,
      this.validatorFunc,
      this.readOnly = false,
      this.keyboardType = TextInputType.text,
      required this.controller,
      this.onTap});
  final String hintText;
  String? prefixText;
  final Widget? iconPrefix;
  final dynamic iconSuffix;
  bool isObscure;
  final String? errorText;
  final String label;
  bool readOnly;
  final Function()? onTap;
  String? Function(String?)? validatorFunc;
  final TextEditingController controller;

  final keyboardType;

  @override
  State<TextFormFieldCustom> createState() => _textFormFieldCustomState();
}

class _textFormFieldCustomState extends State<TextFormFieldCustom> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> obscureText = ValueNotifier<bool>(widget.isObscure);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            ValueListenableBuilder(
                valueListenable: obscureText,
                builder: (BuildContext context, value, Widget? child) {
                  return TextFormField(
                    readOnly: widget.readOnly,
                    controller: widget.controller,
                    validator: widget.validatorFunc,
                    keyboardType: widget.keyboardType,
                    style: const TextStyle(
                      fontFamily: fontBoldApp,
                    ),
                    obscureText: value,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      prefixText: widget.prefixText,
                      border: InputBorder.none,
                      errorText: widget.errorText,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      errorStyle: const TextStyle(
                        fontFamily: fontApp,
                      ),
                      prefixIcon: widget.iconPrefix,
                      suffixIcon: widget.iconSuffix != null
                          ? InkWell(
                              onTap: () {
                                obscureText.value = !obscureText.value;
                              },
                              // child: widget.isObscure
                              //     ? Icon(Icons.visibility)
                              //     : Icon(
                              //         Icons.visibility_off,
                              //       ),
                              child: Icon(
                                value ? Icons.visibility : Icons.visibility_off,
                              ),
                            )
                          : null,
                    ),
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap!();
                      }
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}


// TextFormField TextFormFieldCustom(String hintText, IconData? iconPrefix,
//     IconData? iconSuffix, bool? isObscure, String? errorText) {
//   return TextFormField(
//     style: const TextStyle(
//       fontFamily: fontBoldApp,
//     ),
//     obscureText: isObscure!,
//     decoration: InputDecoration(
//       hintText: hintText,
//       border: InputBorder.none,
//       errorText: errorText,
//       contentPadding: const EdgeInsets.symmetric(vertical: 10),
//       prefixIcon: iconPrefix != null
//           ? Icon(
//               iconPrefix,
//             )
//           : SizedBox(height: 0, width: 0),
//       suffixIcon: iconSuffix != null
//           ? Icon(
//               iconSuffix,
//             )
//           : SizedBox(),
//     ),
//   );
// }

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';

class TextFieldWidget extends StatelessWidget {
  final String? labelText;
  final Widget? textFieldIcon;
  final TextEditingController textEditingController;
  // final Function onTapCallBack;

  // final bool readOnly;
  // final

  // final BuildContext context;
  bool isObscured = false;

  TextFieldWidget({
    required this.labelText,
    this.textFieldIcon,
    required this.isObscured,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Colors.black,
          style: TextStyle(color: Colors.black),
          onSaved: (value) {
            textEditingController.text = value!;
          },
          enabled: true,
          validator: (value) {
            textEditingController.text = value!;
            if (textEditingController.text.isEmpty) {
              return "Email and Password is required!";
            }
          },
          controller: textEditingController,
          // maxLines: 5,

          textAlign: TextAlign.left,
          // maxLines: 4,4
          obscureText: isObscured,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(30),
            suffixIcon: Padding(
              padding: EdgeInsets.all(14.0),
              child: GestureDetector(
                  // onTap: () => onTapCallBack,
                  child: textFieldIcon),
            ),
            border: OutlineInputBorder(
                gapPadding: 10, borderSide: BorderSide(width: 0.8)),
            labelText: labelText,
            // label: Center(child: Text(labelText!)),
            labelStyle: TextStyle(color: mainRedShadeForText),
            alignLabelWithHint: true,
            // hintText: 'Enter your email',
            // filled: true,
            // fillColor: Colors.white.withOpacity(1),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 0.8, color: Color(0xffD10005).withOpacity(0.2)),
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 0.8, color: Color(0xffD10005).withOpacity(0.2)),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}

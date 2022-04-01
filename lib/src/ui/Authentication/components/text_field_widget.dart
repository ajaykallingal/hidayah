


import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';

class TextFieldWidget extends StatelessWidget {
  final String? labelText;
  final ImageIcon? textFieldIcon;

  // final BuildContext context;
  bool isObscured = false ;

  TextFieldWidget({required this.labelText, this.textFieldIcon,required this.isObscured});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          enabled: true,
            // maxLines: 5,

            textAlign: TextAlign.center,
          // maxLines: 4,4
          obscureText: isObscured,
          decoration: InputDecoration(


            contentPadding: EdgeInsets.all(30),
            suffixIcon: Padding(
              padding:  EdgeInsets.all(14.0),
              child: textFieldIcon,
            ),
            border: OutlineInputBorder(

                gapPadding: 10,borderSide: BorderSide(width: 0.8)),
            labelText: labelText,
            // label: Center(child: Text(labelText!)),
            labelStyle: TextStyle(color: mainRedShadeForText),
            alignLabelWithHint: true,
            // hintText: 'Enter your email',
            // filled: true,
            // fillColor: Colors.white.withOpacity(1),

            focusedBorder: OutlineInputBorder(

              borderSide: BorderSide(
                width: 0.8,
                  color: Color(0xffD10005).withOpacity(0.2)),
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(

              borderSide: BorderSide(
                width: 0.8,
                  color: Color(0xffD10005 ).withOpacity(0.2)),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}

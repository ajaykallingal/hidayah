import 'package:flutter/material.dart';

class PersonalDetailTextFieldWidget extends StatelessWidget {
  final String? labelText;
  final bool? isObscured;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  const PersonalDetailTextFieldWidget({Key? key,this.labelText,this.isObscured,required this.textEditingController,required this.keyboardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      height: 42,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        style: const TextStyle(color: Colors.black54),
        keyboardType: keyboardType,
        controller: textEditingController,
        enabled: true,
        // textAlign: TextAlign.center,
        obscureText: isObscured!,
        decoration: InputDecoration(

          contentPadding: const EdgeInsets.all(30),
          // suffixIcon: Padding(
          //   padding:  EdgeInsets.all(14.0),
          //   child: textFieldIcon,
          // ),
          // border: OutlineInputBorder(
          //
          //     gapPadding: 10,borderSide: BorderSide(width: 0.8)),
          // labelText: labelText,
          label: Center(child: Text(labelText!)),
          labelStyle: const TextStyle(color: Colors.black54),
          alignLabelWithHint: true,

          focusedBorder: OutlineInputBorder(

            borderSide: BorderSide(
                width: 0.8,
                color: const Color(0xffD10005).withOpacity(0.2)),
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(

                      borderSide: BorderSide(
                          width: 0.8,
                          color: const Color(0xffD10005 ).withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';

class RoundedTextFieldWithRadioButton extends StatelessWidget {
 
 const RoundedTextFieldWithRadioButton({
  required this.context,required this.text,required this.isChecked
});
  final BuildContext context;
  final String? text;
  final bool? isChecked;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: shadeForTextFieldBorder,width: 0.8),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left:10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text!,style: kSetGoalsTextStyle,),
           isChecked == true ?  Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              height: 20,
              width: 20,
              // child: Image.asset('assets/images/TICK.png',height: 30,width: 30,fit: BoxFit.cover,),
              decoration: const BoxDecoration(
                // color: Colors.white,
                shape: BoxShape.circle,

                image: DecorationImage(

                  image: AssetImage(
                      'assets/images/checked.png'),
                  fit: BoxFit.fill,


                ),
                // color: mainRedShadeForText,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 1.5,
                      color: Colors.black26,
                      offset: Offset(0, 1))
                ],
              ),
            )
                : Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 1.5,
                      color: Colors.black38,
                      offset: Offset(0, 1))
                ],
              ),
            ),

          ],
        ),
      ),

    );
  }
}
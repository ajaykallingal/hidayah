import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';

class RoundedBoxWithTick extends StatelessWidget {

  RoundedBoxWithTick({
    required this.genderSelected,required this.gender,
});

  final bool genderSelected;
  final String? gender;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xffD10005).withOpacity(0.2),width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(gender!,style: TextStyle(color: Colors.black54),),
          SizedBox(width: 20),
          genderSelected == true ? Container(

            height: 20,
            width: 20,
            // child: Image.asset('assets/images/TICK.png',height: 30,width: 30,fit: BoxFit.cover,),
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              // color: mainRedShadeForText,
              boxShadow: [
                BoxShadow(
                    blurRadius: 1.5,
                    color: Colors.black26,
                    offset: Offset(0, 1))
              ],
            ),
            child: Center(child: Image.asset('assets/images/TICK.png',scale: 3,)),
          )
              : Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
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
    );
  }
}
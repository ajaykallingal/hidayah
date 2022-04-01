import 'package:flutter/material.dart';

class RoundContainerWithTick extends StatelessWidget {
  const RoundContainerWithTick({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      height: 27,
      width: 27,
      // child: Image.asset('assets/images/TICK.png',height: 30,width: 30,fit: BoxFit.cover,),
      decoration: BoxDecoration(
        // color: Colors.white,
        shape: BoxShape.circle,

        image: DecorationImage(

          image: new AssetImage(
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
    );
  }
}
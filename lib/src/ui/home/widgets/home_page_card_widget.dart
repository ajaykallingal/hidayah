import 'package:flutter/material.dart';

class HomePageCardWidget extends StatelessWidget {

  const HomePageCardWidget({required this.child,});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(duration: Duration(seconds: 1),
      // height: 210,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
        child: child,

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //
        //   ],
        // ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hidayah/src/ui/home/textStyle/text_style.dart';

class RoundContainerWithoutTick extends StatelessWidget {
  const RoundContainerWithoutTick({
    Key? key, required this.prayerName,
  }) : super(key: key);
  final String? prayerName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      width: 27,
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
      child: Center(child: Text(prayerName!,style: kHomePageCard1PrayernamesTextStyle,)),
    );
  }
}
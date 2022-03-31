import 'package:flutter/material.dart';

import '../textStyle/text_style.dart';

class DailyVerseWidget extends StatelessWidget {
  const DailyVerseWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Verse',
          style: kHomePageCardTitleTextStyle,
        ),
        Divider(
          color: Color(0xFF707070).withOpacity(0.1),
          indent: 0,
          thickness: 0.8,
          endIndent: 0,
        ),
        SizedBox(height: 8),
        Center(
          child: Text(
            'And were it not for Allah\'s grace upon you and His mercy\nand that Allah is Oft-returning(to mercy),Wise!',
            style: kHomePageCard7TextStyle1,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton.icon(

            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            icon: ImageIcon(AssetImage('assets/images/SURAH FILL.png',),color: cardRichTextColor,),
            label: Text('Surah An-Nur',style: kHomePageCard3ButtonTextStyle,),

          ),
        ),
      ],
    );
  }
}
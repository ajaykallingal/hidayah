import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../textStyle/text_style.dart';

class PrayerTimesCardWidget extends StatelessWidget {
  const PrayerTimesCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prayer Times',
          style: kHomePageCardTitleTextStyle,
        ),
        Divider(
          color: Color(0xFF707070).withOpacity(0.1),
          indent: 0,
          thickness: 0.8,
          endIndent: 0,
        ),
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Next Prayer is',
                style: kHomePageCard3RichTextStyle1,
                children: <TextSpan>[
                  TextSpan(
                    text: ' Maghrib ',
                    style: kHomePageCard3RichTextStyle2,
                  ),
                  TextSpan(
                    text: 'at',
                    style: kHomePageCard3RichTextStyle1,
                  ),
                  TextSpan(
                    text: ' 6:45',
                    style: kHomePageCardTitleTextStyle,
                  ),
                  TextSpan(
                    text: '\nin 1 hour 57 minutes in Dubai,uae',
                    style: kHomePageCard3RichTextStyle3,
                  ),
                ]),
          ),
        ),
        SizedBox(height: 15),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton.icon(

            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            icon: ImageIcon(AssetImage('assets/images/PRAYERTIMES_FILL.png',),color: cardRichTextColor,),
            label: Text('Prayer Times',style: kHomePageCard3ButtonTextStyle,),

          ),
        ),

      ],
    );
  }
}
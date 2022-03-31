import 'package:flutter/material.dart';

import '../textStyle/text_style.dart';
class HadithOfThedayWidget extends StatelessWidget {
  const HadithOfThedayWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hadith of the day',
          style: kHomePageCardTitleTextStyle,
        ),
        Divider(
          color: Color(0xFF707070).withOpacity(0.1),
          indent: 0,
          thickness: 0.8,
          endIndent: 0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                "Abu Huraira reported: I said, “O Messenger of Allah, I hear many traditions from you and I forget them.” The Prophet said, “Spread open your garment.” I spread it and then he placed something from his hand into it, saying, “Wrap it.” I wrapped it around me and I never forgot a tradition ever again.",
                style: kHomePageCard8TextStyle1,
                softWrap: true,
              ),
              SizedBox(height: 50),
              Text(
                "Source: Ṣaḥīḥ al-Bukhārī 3448\n\nGrade: Sahih (authentic) according to Al-Bukhari",
                style: kHomePageCard8TextStyle1,
                softWrap: true,
              ),
              SizedBox(height: 50),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton.icon(

                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  icon: ImageIcon(AssetImage('assets/images/SURAH FILL.png',),color: cardRichTextColor,),
                  label: Text('View Hadith',style: kHomePageCard3ButtonTextStyle,),

                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
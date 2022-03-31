import 'package:flutter/material.dart';

import '../textStyle/text_style.dart';
class Daily_Duas_widget extends StatelessWidget {
  const Daily_Duas_widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Duas',
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
              Text(
                'Bismillah Ar-Rahman Ar-Raheem',
                style: kHomePageCard4TextStyle1,
              ),
              SizedBox(height: 7),
              Center(
                child: Text(
                  '"In The Name Of Allah"',
                  style: kHomePageCard4TextStyle2,
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  'However, in case of forgetting to recite the\nbismillah and we are already halfway\neating our meal we may recite',
                  style: kHomePageCard4TextStyle1,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 7),
              Text(
                "Bismillahi Awwalahu Wa Akhirahu",
                style: kHomePageCard4TextStyle1,
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  '“In the Name of Allah at the\nbeginning and at the end.”',
                  style: kHomePageCard4TextStyle2,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 7),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton.icon(

                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  icon: ImageIcon(AssetImage('assets/images/VIEW DUAS FILL.png',),color: cardRichTextColor,),
                  label: Text('Prayer Times',style: kHomePageCard3ButtonTextStyle,),

                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
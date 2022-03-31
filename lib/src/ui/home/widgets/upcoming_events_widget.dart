import 'package:flutter/material.dart';

import '../textStyle/text_style.dart';

class UpcomingEventsWidget extends StatelessWidget {
  const UpcomingEventsWidget({
    Key? key,
    required String upcomingEventsImageUrl,
  }) : _upcomingEventsImageUrl = upcomingEventsImageUrl, super(key: key);

  final String _upcomingEventsImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Events',
          style: kHomePageCardTitleTextStyle,
        ),
        Divider(
          color: Color(0xFF707070).withOpacity(0.1),
          indent: 0,
          thickness: 0.8,
          endIndent: 0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5,right: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 77,
                width: 76,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      _upcomingEventsImageUrl,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70),
                    Text("40 Days",style: kHomePageCard6TextStyle1,),
                    Text("14-April-2022",style: kHomePageCard6TextStyle2,),

                  ],
                ),
              ),
            ],
          ),

        ),

        Align(
          alignment: Alignment.bottomRight,
          child: TextButton.icon(

            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            icon: ImageIcon(AssetImage('assets/images/CALENDER FILL.png',),color: cardRichTextColor,),
            label: Text('Calender',style: kHomePageCard3ButtonTextStyle,),

          ),
        ),
      ],
    );
  }
}
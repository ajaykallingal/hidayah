import 'package:flutter/material.dart';

import '../textStyle/text_style.dart';

class DailyQuotesWidget extends StatelessWidget {
  const DailyQuotesWidget({
    Key? key,
    required String dailyQuotesImageUrl,
  }) : _dailyQuotesImageUrl = dailyQuotesImageUrl, super(key: key);

  final String _dailyQuotesImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Quotes',
          style: kHomePageCardTitleTextStyle,
        ),
        Divider(
          color: Color(0xFF707070).withOpacity(0.1),
          indent: 0,
          thickness: 0.8,
          endIndent: 0,
        ),
        SizedBox(height: 10),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Container(
                height: 132,
                width: 290,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(
                    _dailyQuotesImageUrl,
                  ),
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),


      ],
    );
  }
}
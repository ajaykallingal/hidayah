


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../more/text_style.dart';

class TileWidgetForDuas extends StatelessWidget {

  String? title;
  // String? subTitle;
  // String? iconPath;
  TileWidgetForDuas({
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 65,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // image: widget.favImageWidget,
        color: Colors.white.withOpacity(1.0),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            offset: Offset(3.0, 3.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-3.0, -3.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        children: [
          // ImageIcon(
          //   AssetImage(iconPath!),
          //   size: 39,
          //   color: moreListTileImageColor,
          // ),
          // SizedBox(width: 10),
          // VerticalDivider(indent: 2,endIndent: 2,color: dividerColor),
          // SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title!,
                style: kMoreScreenListTileTitleStyle,
              ),
              SizedBox(height: 0),


              // Text(
              //     subTitle!,
              //     style: kMoreScreenListTileSubTitleStyle),
            ],
          ),
        ],
      ),
    );
  }
}
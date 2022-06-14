


import 'package:flutter/material.dart';

import '../text_style.dart';

class MoreScreenListTileWidget extends StatelessWidget {

  String? title;
  String? subTitle;
  String? iconPath;
  MoreScreenListTileWidget({
    required this.iconPath,required this.title,required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 65,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // image: widget.favImageWidget,
        color: Colors.white.withOpacity(1.0),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[350]!,
            offset: const Offset(4.0, 4.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-4.0, -4.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(iconPath!),
            size: 39,
            color: moreListTileImageColor,
          ),
          const SizedBox(width: 10),
          VerticalDivider(indent: 2,endIndent: 2,color: dividerColor),
          const SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title!,
                style: kMoreScreenListTileTitleStyle,
              ),
              const SizedBox(height: 3),


              Text(
                  subTitle!,
                  style: kMoreScreenListTileSubTitleStyle),
            ],
          ),
        ],
      ),
    );
  }
}
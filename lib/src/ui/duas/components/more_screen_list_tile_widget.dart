


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
            color: Colors.grey[300]!,
            offset: const Offset(3.0, 3.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-3.0, -3.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          // widthFactor: 50,
          alignment: Alignment.centerLeft,
          child: Text(
            title!,
            style: kMoreScreenListTileTitleStyle,
          ),
        ),
      ),
    );
  }
}
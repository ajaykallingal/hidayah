import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/text_style.dart';

class PickFavContainerWidget extends StatefulWidget {


  PickFavContainerWidget({required this.favTitle,required this.favImageWidget,required this.isFavChecked});
  final String? favTitle;
  final DecorationImage favImageWidget;
  bool isFavChecked;

  @override
  State<PickFavContainerWidget> createState() => _PickFavContainerWidgetState();
}

class _PickFavContainerWidgetState extends State<PickFavContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          // clipBehavior: Clip.hardEdge,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                 widget.isFavChecked = !widget.isFavChecked;
                });
              },
              child: Container(
                height: 65,
                width: 65,

                decoration: BoxDecoration(
                  image: widget.favImageWidget,
                  color: Colors.white.withOpacity(1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10),),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[350]!,
                      offset: Offset(5.0,5.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0,
                    ),

                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5.0,-5.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0,
                    ),
                  ],

                ),
              ),
            ),
            widget.isFavChecked == true ?  Positioned(
              bottom: 0,
              right: 0,
              left: 49,
              top: 49,
              child: Container(
                // alignment: Alignment.bottomRight,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                height: 10,
                width: 10,
                // child: Image.asset('assets/images/TICK.png',height: 30,width: 30,fit: BoxFit.cover,),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  shape: BoxShape.circle,

                  image: DecorationImage(

                    image: new AssetImage(
                        'assets/images/TICK.png'),
                    fit: BoxFit.fill,


                  ),
                  // color: mainRedShadeForText,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1.5,
                        color: Colors.black26,
                        offset: Offset(0, 1))
                  ],
                ),
              ),
            ) : Container(),

          ],
        ),
        SizedBox(height: 10),
        Text(widget.favTitle!,style: kPickFavTextStyle,softWrap: true,textAlign: TextAlign.center,),

      ],
    );
  }
}

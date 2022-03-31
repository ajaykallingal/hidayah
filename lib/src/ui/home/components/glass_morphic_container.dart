import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphicContainer extends StatelessWidget {
GlassMorphicContainer({required this.icon});
final AssetImage icon;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child:   BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
        child: Container(
          height: 33,
          width: 33,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),

          ),
          child: IconButton(onPressed: () {},
            icon: ImageIcon(
              icon,
              color: Colors.white.withOpacity(1),),),
        ),
      ),
    );
  }
}
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hidayah/src/ui/Authentication/authentication_screen.dart';
import 'package:hidayah/src/ui/home/textStyle/text_style.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../shared_pref/object_factory.dart';

class GlassMorphicContainer extends StatelessWidget {
  final Widget child;

  GlassMorphicContainer({required this.child});


// final Function callBackFunction;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 33,
          width: 33,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: child,
        ),
      ),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/font_family.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/ui/Authentication/components/text_field_widget.dart';

import '../authentication_screen.dart';


class KBackground extends StatelessWidget {
  const KBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient:
        RadialGradient(
          center: Alignment.center,
          colors: [
            Color(0xffE80000),
            Color(0xff382424),

          ],
          radius: 1.5,
          focal: Alignment.center,
          // focalRadius: 1.0,

        ),

        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/bg_pattern.png'),
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 141,
                  width: 172,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo_white.png'),
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: 401,
                  width: 324,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: Colors.white.withOpacity(1.0),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: buildLoginForm(),
                      // ),
                    ],
                  ),
                ),

              ),


            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.27,
            left: MediaQuery.of(context).size.width / 1.5,
            // right: MediaQuery.of(context).size.width / 1.9,
            // bottom: 65,
            child: Container(
              child: Stack(
                children: [
                  Container(
                    height: 81,
                    width: 81,
                    decoration: BoxDecoration(

                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(1.0),
                      // color: Colors.red.withOpacity(1.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xffE9EAFE),
                          offset: Offset(
                            0.0,
                            2.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:  const EdgeInsets.all(13.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient:  RadialGradient(
                            center: Alignment.center,
                            colors: [
                              Color(0xffE80000),
                              Color(0xff382424),

                            ],
                            radius: 1.0,
                            focal: Alignment.bottomRight,
                            // focalRadius: 1.0,

                          ),
                        ),
                        child: RawMaterialButton(
                          elevation: 2,

                          // fillColor: Colors.redAccent,
                          child: const ImageIcon(
                            AssetImage('assets/images/RIGHT_ARROW.png'),
                            color: Colors.white,
                            size: 12,
                          ),
                          shape: CircleBorder(),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => KBackground(), ));
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildLoginForm() {

    return  Column(
      mainAxisSize: MainAxisSize.max,

      children: [
        Text('Login',style: kFormFieldsTitleTextStyle,),




        SizedBox(height: 70),


        TextFieldWidget(
          isObscured: false,
          textFieldIcon: ImageIcon(AssetImage('assets/images/MAIL_ICON.png'),color: Color(0xffD10005,)),
          labelText: 'Email Address',

        ),
        SizedBox(height: 20),
        TextFieldWidget(
          // context: context,
          isObscured: true,
          labelText: 'Password',
          textFieldIcon: ImageIcon(AssetImage('assets/images/PASSWORD_ICON.png'),color: Color(0xffD10005,)),


        ),
      ],
    );

  }
}

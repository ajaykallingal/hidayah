import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/font_family.dart';
import 'package:hidayah/src/constants/size_config.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/ui/Authentication/components/k_background.dart';
import 'package:hidayah/src/ui/Authentication/personal_details/Personal_details_screen.dart';
import 'package:hidayah/src/ui/Authentication/sign_up_screen.dart';

import 'components/text_field_widget.dart';

class AuthenticationScreen extends StatefulWidget {
  static const String id = 'auth_screen';

  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {

  void navigationPage() {

    if (mounted) {
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //         LoginScreen()),
      //         (Route<dynamic> route) => false);

        Navigator.pushReplacementNamed(
            context, PersonalDetailsScreen.id);

    }

  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true  ,
      body: _buildAuthenticationScreenBody(),

    );
  }


  Widget _buildAuthenticationScreenBody() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
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
                SizedBox(height: 15,),
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
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: buildLoginForm(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15,top: 0),
                              child: buildForgotPassword(),
                            ),
                          ],
                        ),
                        buildDontHaveAccount(),
                      ],
                    ),
                  ),

                ),


              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 1.24,
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
                              navigationPage();
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
      ),
    );
  }

  Widget buildDontHaveAccount(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('DONT HAVE AN ACCOUNT?',style: kDontHaveTextStyle,),
    TextButton(
    onPressed: (){
      Navigator.pushReplacementNamed(
          context,SignUpScreen.id);
    },
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
    child: Text('SIGN UP',style: TextStyle(
      letterSpacing: 0,
      decoration: TextDecoration.underline,
      fontFamily: FontFamily.ralewayRegular,
      fontSize: 14,
      color: mainRedShadeForTitle,
      // fontWeight: FontWeight.w600,
    ),),

    ),
      ],
    );
  }

  Widget buildForgotPassword() {
    return TextButton(
      onPressed: (){},
      child: Text('Forgot Password?',style: kForgotPasswordTextStyle,),
      
    );
  }



  Widget buildLoginForm() {

      return  Column(
        mainAxisSize: MainAxisSize.max,

        children: [
          Text('Login',style: kFormFieldsTitleTextStyle,),




          SizedBox(height: 70),


          TextFieldWidget(
              // context: context,
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


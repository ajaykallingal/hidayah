import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/personal_details_bloc.dart';
import 'package:hidayah/src/ui/Authentication/authentication_screen.dart';
import 'package:hidayah/src/ui/Authentication/personal_details/Personal_details_screen.dart';
import 'package:hidayah/src/ui/Authentication/personal_details/components/personal_details_screen_arguments.dart';

import 'components/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'sign_up_screen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final signUpBloc = PersonalDetailsBloc();
  bool loading = false;
  bool isShowPassword = true;
  String userId = "0";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    signUpBloc.personalDetailsSCStreamListener.listen((event) {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // userId = ObjectFactory().prefs.getUserId().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
            child: SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: 10),
                        const SizedBox(height: 20),

                        Align(
                          alignment: Alignment.topCenter,
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
                        const SizedBox(height: 10),
                        Stack(

                          children: [
                            Container(
                              height: 370,
                              width: 324,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: Colors.white.withOpacity(1.0),
                              ),
                            ),
                            Container(
                              height: 340,
                              width: 324,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(10),
                                color: Colors.white.withOpacity(1.0),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: buildLoginForm(),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),


                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 475,
            left: 250,
            // right: MediaQuery.of(context).size.width / 1.9,
            // bottom: 65,
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
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
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
                        shape: const CircleBorder(),
                        onPressed: () {
                          if (fullNameController.text.isEmpty) {
                            return showToastShort(
                                "Please enter Your full name!");
                          }
                          if (emailController.text.isEmpty) {
                            return showToastShort(
                                "Please enter a valid email");
                          }
                          if (passwordController.text.isEmpty) {
                            return showToastShort(
                                "Please enter a password");
                          }

                          setState(() {
                            loading = true;
                          });
                          Navigator.pushReplacementNamed(
                            context,
                            PersonalDetailsScreen.id,
                            arguments: PersonalDetailsScreenArguments(
                              fullName: fullNameController.text.toString(),
                              email: emailController.text.toString(),
                              password: passwordController.text.toString(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoginForm() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ListTile(
            horizontalTitleGap: 50,
            title: Text(
              'Sign Up',
              style: kFormFieldsTitleTextStyle,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AuthenticationScreen.id);
                },
                icon: const Icon(Icons.arrow_back_sharp)),
          ),
          const SizedBox(height: 30),
          TextFieldWidget(
            isObscured: false,
            textFieldIcon: const ImageIcon(AssetImage('assets/images/FULL_NAME.png'),
                color: Color(
                  0xffD10005,
                )),
            labelText: 'FullName',
            textEditingController: fullNameController,
          ),
          const SizedBox(height: 20),
          TextFieldWidget(
            // context: context,
            isObscured: false,
            labelText: 'EmailAddress',
            textFieldIcon: const ImageIcon(AssetImage('assets/images/MAIL_ICON.png'),
                color: Color(
                  0xffD10005,
                )),
            textEditingController: emailController,
          ),
          const SizedBox(height: 20),
          TextFieldWidget(
            isObscured: isShowPassword ? true : false,
            textFieldIcon:
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  child: const ImageIcon(AssetImage('assets/images/PASSWORD_ICON.png'),

                      color: Color(
                        0xffD10005,
                      )),
                ),
            labelText: 'Password',

            textEditingController: passwordController,
          ),
          // SizedBox(height: 20),
          // TextFieldWidget(
          //   isObscured: true,
          //   textFieldIcon:
          //       ImageIcon(AssetImage('assets/images/PASSWORD_ICON.png'),
          //           color: Color(
          //             0xffD10005,
          //           )),
          //   labelText: 'Confirm Password',
          //   textEditingController: confirmPasswordController,
          // ),
        ],
      ),
    );
  }
}

///common toast
void showToastShort(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
  );
}

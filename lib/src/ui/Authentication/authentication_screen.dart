import 'package:flutter/material.dart';
import 'package:hidayah/src/constants/font_family.dart';
import 'package:hidayah/src/constants/text_style.dart';
import 'package:hidayah/src/data/bloc/auth_bloc.dart';
import 'package:hidayah/src/data/models/login/login_with_email_request.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';
import 'package:hidayah/src/ui/Authentication/personal_details/components/email_validator.dart';
import 'package:hidayah/src/ui/Authentication/sign_up_screen.dart';
import 'package:hidayah/src/ui/home/home_screen.dart';
import '../../data/models/login/login_with_email_response.dart';
import 'components/text_field_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationScreen extends StatefulWidget {
  static const String id = 'auth_screen';

  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final loginWithEmailBloc = AuthBloc();
  bool loading = false;
  String userId = "0";
  String status = "";
  LoginResponse? loginResponse;
  bool isShowPassword = true;
  DateTime? backButtonPressTime;

  final snackBar = const SnackBar(
    content: Text('Press back again to leave'),
    duration: HomeScreen.snackBarDuration,
  );

  Future<bool> handleWillPop(BuildContext context) async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            now.difference(backButtonPressTime!) > HomeScreen.snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    return true;
  }

  // void navigationPage() {
  //   if (mounted) {
  //     // Navigator.pushAndRemoveUntil(
  //     //     context,
  //     //     MaterialPageRoute(
  //     //         builder: (context) =>
  //     //         LoginScreen()),
  //     //         (Route<dynamic> route) => false);
  //
  //     Navigator.pushReplacementNamed(context, PersonalDetailsScreen.id);
  //   }
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    loginWithEmailBloc.loginWithEmailResponseSCListener.listen((event) {
      if (event != null) {
        setState(() {
          ObjectFactory().prefs.setUserId(userId: event.response!.userId);
          ObjectFactory().prefs.setIsLoggedIn(true);
          ObjectFactory().prefs.saveUserData(event);
          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id,(route) => false,);
          
          
          loading = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildAuthenticationScreenBody();
  }

  Widget _buildAuthenticationScreenBody() {
    return Builder(

      builder: (BuildContext context) {
        return WillPopScope(
            child: Scaffold(
              resizeToAvoidBottomInset: true,

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
                            // SizedBox(height: 200),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 25),
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
                                const SizedBox(
                                  height: 15,
                                ),
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white.withOpacity(1.0),
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: buildLoginForm(),
                                          ),

                                          const SizedBox(height: 15 ),
                                          buildDontHaveAccount(),

                                        ],
                                      ),
                                    ),

                                    Positioned(
                                      top: 280,
                                      left: 230,
                                      // bottom: MediaQuery.of(context).size.height * 4,
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
                                                    print(status.toString());
                                                    if (emailTextEditingController.text.isEmpty) {
                                                      showToastShort(
                                                          "Please provide a valid email");
                                                    }
                                                    if (passwordTextEditingController
                                                        .text.isEmpty) {
                                                      showToastShort("Invalid Password!");
                                                    }
                                                    if (!loading) {
                                                      setState(() {
                                                        loading = true;
                                                      });
                                                      loginWithEmailBloc.loginWithEmailAndPassword(
                                                        request: LoginWithEmailRequest(
                                                            userEmail:
                                                            emailTextEditingController.text,
                                                            userPassword:
                                                            passwordTextEditingController.text),
                                                      );

                                                    }

                                                    print(
                                                        emailTextEditingController.text + passwordTextEditingController.text);


                                                    // navigationPage();
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
                              ],
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            onWillPop: () => handleWillPop(context),
        );
      },

    );
  }

  Widget buildDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'DONT HAVE AN ACCOUNT?',
          style: kDontHaveTextStyle,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, SignUpScreen.id);
          },
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: Text(
            'SIGN UP',
            style: TextStyle(
              letterSpacing: 0,
              decoration: TextDecoration.underline,
              fontFamily: FontFamily.ralewayRegular,
              fontSize: 14,
              color: mainRedShadeForTitle,
              // fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildForgotPassword() {
    return TextButton(
      onPressed: () {},
      child: Text(
        'Forgot Password?',
        style: kForgotPasswordTextStyle,
      ),
    );
  }

  Widget buildLoginForm() {
    return Column(
      children: [
        Text(
          'Login',
          style: kFormFieldsTitleTextStyle,
        ),
        const SizedBox(height: 50),
        TextFieldWidget(
          // context: context,
          isObscured: false,
          textFieldIcon: const ImageIcon(AssetImage('assets/images/MAIL_ICON.png'),
              color: Color(
                0xffD10005,
              )),
          labelText: 'Email Address',
          textEditingController: emailTextEditingController,
        ),
        const SizedBox(height: 20),
        TextFieldWidget(
          // context: context,
          isObscured: isShowPassword ? true : false,
          labelText: 'Password',
          textEditingController: passwordTextEditingController,
          textFieldIcon:
              GestureDetector(
                onTap: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
                child: const ImageIcon(AssetImage('assets/images/PASSWORD_ICON.png'),
                    color: Color(
                      0xffD10005,
                    )),
              ),
        ),

      ],
    );
  }

  ///common toast
  void showToastShort(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }
}

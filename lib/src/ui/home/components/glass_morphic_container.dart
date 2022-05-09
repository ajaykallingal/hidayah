// import 'dart:js';
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// class GlassMorphicContainer extends StatelessWidget {
// const GlassMorphicContainer({required this.icon});
// final AssetImage icon;
//   @override
//   Widget build(BuildContext context) {
//     return
//       ClipRRect(
//       child:   BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
//         child: Container(
//           height: 33,
//           width: 33,
//           decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(10),
//
//           ),
//           child: IconButton(onPressed: () {
//
//           },
//             icon: ImageIcon(
//               icon,
//               color: Colors.white.withOpacity(1),),),
//         ),
//       ),
//     );
//   }
// Future buildLogoutPopUp() async {
//   await Alert(
//     padding: EdgeInsets.only(top: 15),
//     // image: ImageIcon(
//     //   AssetImage(Assets.success),
//     //   size: 95,
//     //   color: Color(0xff68CE78).withOpacity(1.0),
//     // ),
//     closeIcon: Container(),
//
//     context: context,
//     // type: AlertType.success,
//     // title: "RFLUTTER ALERT",
//     desc: "Do you want to Logout?",
//     style: AlertStyle(
//         isOverlayTapDismiss: false,
//         alertElevation: 1.0,
//         alertPadding: EdgeInsets.symmetric(vertical: 200, horizontal: 50),
//         overlayColor: Colors.transparent.withOpacity(0.4),
//         constraints: BoxConstraints(maxHeight: 80, maxWidth: 324),
//         // alertPadding: EdgeInsets.only(top: 30),
//         alertBorder: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(23),
//           side: BorderSide(
//             color: Colors.white10,
//           ),
//         ),
//         // alertBorder: Border(top: BorderSide(color: Colors.white)),
//         descStyle: kTitiliumWebLeftSideSemiBoldText1),
//     buttons: [
//       DialogButton(
//         height: 36.0,
//         radius: BorderRadius.circular(12),
//         child: Text(
//           "Cancel",
//           // style: kSuccessAlertButtonStyle,
//         ),
//         onPressed: () => Navigator.of(context).pop(),
//         width: 95,
//         color: Color(0xff68CE78).withOpacity(1.0),
//       ),
//       DialogButton(
//         height: 36.0,
//         radius: BorderRadius.circular(12),
//         child: Text(
//           "Logout",
//           style: kSuccessAlertButtonStyle,
//         ),
//         onPressed: () {
//           if(assignedSelected) {
//             if (requestList.isEmpty &&
//                 ObjectFactory().prefs.isPhleboOnline()! &&
//                 assignedRequestFetched) {
//               testRequestBloc.onlineStatusPhlebo(
//                   request: OnlineStatusPhleboRequest(
//                       phleboId: ObjectFactory()
//                           .prefs
//                           .getPhleboData()!
//                           .response!
//                           .phlebotomistId,
//                       phlebotomistWorkStatus: false));
//               ObjectFactory().prefs.clearPrefs();
//               Navigator.pushNamedAndRemoveUntil(
//                   context, "/login", (route) => false);
//             }
//             else {
//               showToast("Please complete assigned task before go offline");
//             }
//           }else{
//             showToast("please check do you have active request..");
//             Navigator.of(context).pop();
//           }
//         },
//         width: 95,
//         color: Color(0xff68CE78).withOpacity(1.0),
//       ),
//     ],
//   ).show();
// }
// }
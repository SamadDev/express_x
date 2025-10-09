// // ignore_for_file: lines_longer_than_80_chars
//
// import 'package:wadiharir/common/constants/lottie.dart';
// import 'package:wadiharir/common/constants/size.dart';
// import 'package:wadiharir/common/extensions/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
//
// class ErrorPage extends StatelessWidget {
//   const ErrorPage({super.key, required this.title, required this.body});
//
//   final String? title;
//   final String? body;
//
//   static PageRoute<void> route({
//     String? title,
//     String? body,
//   }) {
//     return MaterialPageRoute(
//       builder: (context) {
//         return ErrorPage(
//           title: title,
//           body: body,
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Align(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: SizeAsset.spacing),
//           child: Column(
//             children: [
//               Lottie.asset(
//                 LottieAssets.errorAnimation,
//                 repeat: false,
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 title ?? 'Something Went Wrong',
//                 style: context.headline1.copyWith(color: Colors.redAccent),
//               ),
//               const SizedBox(height: 15),
//               Text(
//                 body ??
//                     'Seems that there is some issue with this part of our app we will try to fix it as soon as possible try again later.',
//                 style: context.headline5,
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.redAccent,
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).popUntil((route) => route.isFirst);
//                   },
//                   child: const Text(
//                     'Back Home',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

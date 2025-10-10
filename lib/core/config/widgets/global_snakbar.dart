// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:x_express/core/config/assets/app_svg.dart';
// import 'package:x_express/main.dart';
//
// class CustomSnakBar extends StatelessWidget {
//   final String message;
//   const CustomSnakBar({
//     super.key,
//     required this.message,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//             padding: const EdgeInsets.all(16),
//             height: 90,
//             decoration: BoxDecoration(color: const Color(0xff570909), borderRadius: BorderRadius.circular(20)),
//             child: Row(
//               children: [
//                 const SizedBox(width: 48),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Oops!",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           )),
//                       Spacer(),
//                       Text(
//                         message,
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             )),
//         Positioned(
//           bottom: 0,
//           child: ClipRRect(
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//             ),
//             child: SvgPicture.asset(AppSvg.bubbles, height: 48, width: 40, color: const Color(0xff570909)),
//           ),
//         ),
//         Positioned(
//           top: -20,
//           left: 0,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               SvgPicture.asset(AppSvg.fail, height: 40),
//               Positioned(
//                 top: 10,
//                 child: SvgPicture.asset(AppSvg.close, height: 16),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
//
// class SnackBarHelper {
//   final String message;
//   SnackBarHelper(this.message);
//   static void show(message) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//         ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
//           content: CustomSnakBar(message: message ?? "-"),
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ));
//
//     });
//   }
// }

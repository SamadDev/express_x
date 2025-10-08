// import 'package:x_express/Utils/exports.dart';
//
// class GeneralScreen extends StatelessWidget {
//   const GeneralScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Card(
//         clipBehavior: Clip.antiAlias,
//         elevation: 0,
//         margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//         color: AppTheme.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CustomImageView(imagePath: "assets/images/date.png", height: 24, width: 24),
//                     Padding(
//                         padding: EdgeInsets.only(left: 7, top: 5, bottom: 3),
//                         child: Text("01 May 2023 ",
//                             fontSize: 12, fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: AppTheme.black)))
//                   ],
//                 ),
//               ),
//               Divider(color: AppTheme.grey_between),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                   Text("name", fontSize: 14, fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: AppTheme.black)),
//                   SizedBox(width: 8),
//                   Text("opening balance", fontSize: 14, fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: AppTheme.black)),
//                   Text("current balance", fontSize: 14, fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: AppTheme.black))
//                 ]),
//               ),
//               Divider(color: AppTheme.grey_between),
//               ...List.generate(
//                   5,
//                   (index) => Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                   Row(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                     CustomImageView(
//                                         imagePath: 'assets/images/china.png',
//                                         height: 24,
//                                         width: 24,
//                                         margin: EdgeInsets.only(top: 1, bottom: 3)),
//                                     SizedBox(width: 5),
//                                     Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//                                       Text("RMB",
//                                           fontSize: 14, fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: AppTheme.black)),
//                                       SizedBox(height: 2),
//                                       Text("RMB".toUpperCase(),
//
//                                               fontSize: 12, fontFamily: 'nrt-reg', color: AppTheme.grey_between))
//                                     ])
//                                   ]),
//                                   Text("10,000",
//                                       fontSize: 14, fontFamily: 'nrt-bold',fontWeight: FontWeight.bold, color: AppTheme.black)),
//                                   Text("25,000",
//                                       fontSize: 14, fontFamily: 'nrt-bold',fontWeight: FontWeight.bold, color: AppTheme.green))
//                                 ]),
//                               ],
//                             ),
//                           ),
//                           Divider(color: AppTheme.grey_between)
//                         ],
//                       ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
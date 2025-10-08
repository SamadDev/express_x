// import 'package:x_express/Modules/Activity/activity.dart';
// import 'package:x_express/Screens/Activity/Widgets/activity_list_card.dart';
// import 'package:x_express/Utils/exports.dart';
//
// class CreditScreen extends StatelessWidget {
//   final ActivityModule activity;
//   CreditScreen({required this.activity});
//
//   Widget build(BuildContext context) {
//     final language=Provider.of<Language>(context,listen: false).getWords;
//     return Scaffold(
//       body: AnimationLimiter(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 150, child: ActivityTotalCard(balance: activity.balance!)),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                 child: Text(
//                   language["activities"],
//                   fontSize: 16, fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: AppTheme.black),
//                 ),
//               ),
//               SizedBox(
//                 child:activity.credits!.isEmpty?SizedBox(height:300,child: EmptyScreen()): Column(
//                   children: activity.credits!
//                       .map((e) =>
//                       ActivityListCard(
//                             type: 'credit',
//                             credits: e,
//                           )
//                   )
//                       .toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

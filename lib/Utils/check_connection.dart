// import 'package:x_express/main.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:x_express/Utils/exports.dart';
//
// class CheckConnection extends StatelessWidget {
//   Widget build(BuildContext context) {
//     var streamBuilder = Connectivity().onConnectivityChanged;
//     return StreamBuilder<ConnectivityResult>(
//       stream: streamBuilder,
//       initialData: ConnectivityResult.none,
//       builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
//         if ([
//           ConnectivityResult.mobile,
//           ConnectivityResult.wifi,
//           ConnectivityResult.ethernet,
//           ConnectivityResult.vpn,
//         ].contains(snapshot.data)) {
//           return MyApps();
//         } else {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             home: NoInternetScreen(),
//           );
//         }
//       },
//     );
//   }
// }

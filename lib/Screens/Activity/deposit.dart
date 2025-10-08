// import 'package:x_express/Modules/Activity/activity.dart';
// import 'package:x_express/Screens/Activity/Widgets/activity_list_card.dart';
// import 'package:x_express/Utils/exports.dart';
// import 'package:x_express/Utils/sheetWidget.dart';
// import 'package:intl/intl.dart';
//
// class DepositScreen extends StatefulWidget {
//   final ActivityModule activity;
//   DepositScreen({required this.activity});
//
//   @override
//   State<DepositScreen> createState() => _DepositScreenState();
// }
//
// class _DepositScreenState extends State<DepositScreen> {
//   var startDate = "";
//   var endDate = "";
//   DateTime initialStart = DateTime.now();
//   DateTime initialEnd = DateTime.now();
//   bool? currencyValue = false;
//   String currencyId = "";
//   @override
//   void initState() {
//     Provider.of<CurrencyTypeService>(context, listen: false).existCurrencyList = [];
//
//     super.initState();
//   }
//
//   Widget build(BuildContext context) {
//     final language = Provider.of<Language>(context, listen: false).getWords;
//     return SingleChildScrollView(
//       child: Consumer<CurrencyTypeService>(
//         builder: (ctx, currencyType, _) => Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(right: 13, left: 13, top: 8, bottom: 2),
//               child: Row(children: [
//                 TabFilterButton(
//                   title: startDate.toString().isNotEmpty && startDate.toString() != "null"
//                       ? DateFormat('dd-MM-yyyy').format(DateTime.parse(startDate))
//                       : language['from'],
//                   onPress: () async {
//                     startDate = "${(await showDialog(
//                       barrierDismissible: false,
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Theme(
//                           data: ThemeData.light().copyWith(
//                             colorScheme: ColorScheme.light(
//                               primary: AppTheme.primary,
//                               onPrimary: Colors.white,
//                             ),
//                           ),
//                           child: DatePickerDialog(
//                               firstDate: DateTime(2000), lastDate: DateTime(2100), initialDate: initialStart),
//                         );
//                       },
//                     ))}";
//                     setState(() {
//                       if (startDate.toString() != 'null') {
//                         startDate = startDate;
//                         initialStart = DateTime.parse(startDate);
//                       }
//                     });
//                   },
//                 ),
//                 TabFilterButton(
//                   title: endDate.toString().isNotEmpty && endDate.toString() != "null"
//                       ? DateFormat('dd-MM-yyyy').format(DateTime.parse(endDate))
//                       : language['to'],
//                   onPress: () async {
//                     endDate = "${(await showDialog(
//                       barrierDismissible: false,
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Theme(
//                           data: ThemeData.light().copyWith(
//                             colorScheme: ColorScheme.light(
//                               primary: AppTheme.primary,
//                               onPrimary: Colors.white,
//                             ),
//                           ),
//                           child: DatePickerDialog(
//                               firstDate: DateTime(1900), lastDate: DateTime(2100), initialDate: initialEnd),
//                         );
//                       },
//                     ))}";
//                     setState(() {
//                       if (endDate.toString() != 'null') {
//                         endDate = endDate;
//                         initialEnd = DateTime.parse(endDate);
//                       }
//                     });
//                   },
//                 ),
//                 Stack(
//                   children: [
//                     TabFilterButton(
//                       title: language['currency'],
//                       onPress: () {
//                         ButtonSheetWidget(
//                             context: context,
//                             child: Scaffold(
//                               appBar: AppBar(
//                                 title: Text(language['currency']),
//                               ),
//                               floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//                               floatingActionButton: InkWell(
//                                 onTap: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: Container(
//                                   decoration:
//                                       BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(12)),
//                                   width: double.infinity,
//                                   height: 40,
//                                   margin: EdgeInsets.symmetric(horizontal: 12),
//                                   alignment: Alignment.center,
//                                   child: Text("done"),
//                                 ),
//                               ),
//                               body: Consumer<CurrencyTypeService>(
//                                   builder: (ctx, currencyType, _) => FutureBuilder(
//                                       future: currencyType.getCurrencyType(),
//                                       builder: (ctx, snap) => StatefulBuilder(
//                                             builder: (context, setState) => SingleChildScrollView(
//                                               child: Column(
//                                                 children: currencyType.currencyTypeList.map((e) {
//                                                   bool existItem = currencyType.existCurrencyList
//                                                       .any((element) => element.id == e.id);
//
//                                                   return CheckboxListTile(
//                                                     value: existItem,
//                                                     activeColor: AppTheme.primary,
//                                                     onChanged: (value) {
//                                                       if (value == true) {
//                                                         setState(() {
//                                                           currencyType.addItem(e);
//                                                           currencyId = e.id.toString();
//                                                           e.isCheck = value ?? false;
//                                                         });
//                                                       } else {
//                                                         setState(() {
//                                                           currencyType.removeItem(e.id);
//                                                           currencyId = e.id.toString();
//                                                           e.isCheck = value ?? false;
//                                                         });
//                                                       }
//                                                     },
//                                                     title: Text(
//                                                       e.name,
//
//                                                         fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,
//                                                         fontSize: 15,
//                                                         color: AppTheme.black,
//                                                       ),
//                                                     ),
//                                                   );
//                                                 }).toList(),
//                                               ),
//                                             ),
//                                           ))),
//                             ),
//                             heightFactor: 0.5);
//                       },
//                     ),
//                     currencyType.existCurrencyList.isEmpty
//                         ? SizedBox.shrink()
//                         : Positioned(
//                             top: 2,
//                             right: 2,
//                             child: Container(
//                               width: 10,
//                               height: 10,
//                               decoration: BoxDecoration(color: AppTheme.green, borderRadius: BorderRadius.circular(90)),
//                             ))
//                   ],
//                 )
//               ]),
//             ),
//             SizedBox(height: 150, child: ActivityTotalCard(balance: widget.activity.balance!)),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 16, left: 16, top: 4, bottom: 4),
//                   child: Text(
//                     language['statement'],
//                     fontSize: 18, fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: AppTheme.black),
//                   ),
//                 ),
//                 Column(
//                   children: widget.activity.debits!
//                       .map((e) => ActivityListCard(
//                             type: 'deposit',
//                             debits: e,
//                           ))
//                       .toList(),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class TabFilterButton extends StatelessWidget {
//   final title;
//   final onPress;
//   final startDate;
//   final endDate;
//   final initialStart;
//   final initialEnd;
//   const TabFilterButton(
//       {Key? key, this.title, this.onPress, this.initialEnd, this.initialStart, this.startDate, this.endDate})
//       : super(key: key);
//
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 5),
//       child: GestureDetector(
//         onTap: onPress,
//         child: Container(
//           width: 100,
//           height: 33,
//           decoration: BoxDecoration(boxShadow: [
//             BoxShadow(
//               color: AppTheme.grey_between.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 0,
//               offset: Offset(0, 0),
//             ),
//           ], borderRadius: BorderRadius.circular(8), color: AppTheme.white),
//           alignment: Alignment.center,
//           child: Text(
//             title,
//             fontFamily: "sf_med", fontSize: 14, color: AppTheme.grey_thin),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// void showDateTime({initialStart, context}) async {
//   (await showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) {
//       return Theme(
//         data: ThemeData.light().copyWith(
//           colorScheme: ColorScheme.light(
//             primary: AppTheme.primary,
//             onPrimary: Colors.white,
//           ),
//         ),
//         child: DatePickerDialog(firstDate: DateTime(2000), lastDate: DateTime(2100), initialDate: initialStart),
//       );
//     },
//   ));
// }

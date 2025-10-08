// import 'package:x_express/Utils/exports.dart';
// import 'package:intl/intl.dart';
//
// class ShipmentDetailItemsCard extends StatelessWidget {
//   final shipmentDetail;
//
//   const ShipmentDetailItemsCard({Key? key, this.shipmentDetail}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return shipmentDetail == null
//         ? EmptyScreen()
//         : Container(
//             margin: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
//             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
//             decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(12)),
//             child: ExpansionTileCard(
//               expandedTextColor: AppTheme.primary,
//               paddingCurve: Curves.ease,
//               elevation: 0,
//               shadowColor: Colors.white,
//               expandedColor: Colors.white,
//               baseColor: AppTheme.white,
//               initiallyExpanded: false,
//               title: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       navigator_route(context: context, page: ImageShow());
//                     },
//                     child: Container(
//                       width: 56,
//                       height: 56,
//                       decoration: BoxDecoration(color: AppTheme.grey_thick, borderRadius: BorderRadius.circular(10)),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.asset(
//                           "assets/images/itesm.png",
//                           width: 56,
//                           height: 56,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(height: 8),
//                       GlobalText(text:
//                         shipmentDetail['itemName'] ?? "",
//                         fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, fontSize: 16, color: AppTheme.black),
//                       ),
//                       SizedBox(height: 5),
//                       GlobalText(text:
//                         shipmentDetail['itemCode'] ?? "",
//                         fontFamily: 'nrt-reg', fontSize: 14, color: AppTheme.grey_thin),
//                       ),
//                     ],
//                   ),
//                   Spacer(),
//                   Column(
//                     children: [
//                       GlobalText(text:
//                         "${NumberFormat.currency(locale: "en_US", symbol: '').format(double.parse(formatQuantity(shipmentDetail['price'] ?? 0.0).toString()))}",
//                         fontFamily: 'nrt-bold',fontWeight: FontWeight.bold,fontWeight: FontWeight.bold, , fontSize: 16, color: AppTheme.black),
//                       ),
//                       SizedBox(height: 8),
//                       GlobalText(text:
//                         "${shipmentDetail['packing'] ?? "0"} QTY",
//                         fontFamily: 'nrt-reg', fontSize: 14, color: AppTheme.grey_thin),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: 18, horizontal: 14),
//                         child: Column(
//                           children: [
//                             Divider(color: AppTheme.black.withOpacity(0.4), indent: 0, endIndent: 0),
//                             Row(
//                               children: [
//                                 GlobalText(text:
//                                   "Carton",
//                                   fontFamily: 'nrt-reg', fontSize: 15, color: AppTheme.grey_thin),
//                                 ),
//                                 Spacer(),
//                                 GlobalText(text:
//                                   shipmentDetail['packing'].toStringAsFixed(0) ?? "",
//                                   fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, fontSize: 16, color: AppTheme.black),
//                                 )
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 GlobalText(text:
//                                   "Total CBM",
//                                   fontFamily: 'nrt-reg', fontSize: 15, color: AppTheme.grey_thin),
//                                 ),
//                                 Spacer(),
//                                 GlobalText(text:
//                                   "${shipmentDetail['totalCBM'] ?? ""}",
//                                   fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, fontSize: 16, color: AppTheme.black),
//                                 )
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 GlobalText(text:
//                                   "Total Weight",
//                                   fontFamily: 'nrt-reg', fontSize: 15, color: AppTheme.grey_thin),
//                                 ),
//                                 Spacer(),
//                                 GlobalText(text:
//                                   "${shipmentDetail['totalWeight'] ?? ""}",
//                                   fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, fontSize: 16, color: AppTheme.black),
//                                 )
//                               ],
//                             ),
//
//                             SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 GlobalText(text:
//                                   "Unit Price",
//                                   fontFamily: 'nrt-reg', fontSize: 15, color: AppTheme.grey_thin),
//                                 ),
//                                 Spacer(),
//                                 GlobalText(text:
//                                   "${NumberFormat.currency(locale: "en_US", symbol: '').format(double.parse(formatQuantity(shipmentDetail['price'] ?? 0.0).toString()))}",
//                                   fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, fontSize: 15, color: AppTheme.black),
//                                 )
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             // Row(
//                             //   children: [
//                             //     GlobalText(text:
//                             //       "Total",
//                             //       fontFamily: 'nrt-reg', fontSize: 15, color: AppTheme.grey_thin),
//                             //     ),
//                             //     Spacer(),
//                             //     GlobalText(text:
//                             //       "${formatQuantity(shipmentDetail['total']??0.0)} $itemCurrency",
//                             //       fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, fontSize: 15, color: AppTheme.black),
//                             //     )
//                             //   ],
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//   }
// }

import 'package:x_express/Utils/exports.dart';

class ItemCard extends StatelessWidget {
  final shipmentDetail;
  final index;
  final length;
  ItemCard({this.shipmentDetail, this.index, this.length});
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return shipmentDetail == null
        ? EmptyScreen()
        : Container(
            color: AppTheme.white,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            // margin: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                SizedBox(height: 3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: AppTheme.grey_thick,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          "assets/images/itesm.png",
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (shipmentDetail['itemCode'].toString().isNotEmpty ||
                              shipmentDetail['itemCode'] != null) ...[
                            GlobalText(
                              text: shipmentDetail['itemCode'] ?? "",
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.65),
                            ),
                            SizedBox(height: 3),
                          ],
                          GlobalText(
                            text: shipmentDetail['itemName'] ?? "",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.85),
                          ),
                        ],
                      ),
                    ),
                    if (!shipmentDetail['total'].toString().startsWith("0") && shipmentDetail['total'] != null) ...[
                      GlobalText(
                        text: "${shipmentDetail['currency']["symbol"]} ${formatQuantity(shipmentDetail['total'])}",
                        fontSize: 15,
                        fontFamily: 'nrt-bold',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )
                    ],
                  ],
                ),
                //
                // Transform.scale(
                //   scaleX: 1.07,
                //   child: Divider(
                //     thickness: 1.1,
                //     color: Colors.grey.shade100,
                //     height: 35,
                //   ),
                // ),
                SizedBox(height: 20),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatisticCard(
                        title: language["totalQty"],
                        type: "",
                        value: formatQuantity(shipmentDetail['packing']),
                      ),
                      VerticalDivider(thickness: 1.1, color: Colors.grey.shade300),
                      _StatisticCard(
                        title: language["totalCBM"],
                        type: "cbm",
                        cmb: shipmentDetail['cbm'].toString(),
                        value: shipmentDetail['totalCBM'].toString(),
                        // value: "${formatQuantity(item['unitPrice'])} $itemCurrency",
                      ),
                      VerticalDivider(thickness: 1.1, color: Colors.grey.shade300),
                      _StatisticCard(
                        title: language["totalWeight"],
                        type: 'weight',
                        weight: shipmentDetail['weight'].toString(),
                        value: shipmentDetail['totalWeight'].toString(),
                      ),
                    ],
                  ),
                ),
                shipmentDetail['description'] == null
                    ? SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ).copyWith(top: 25),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GlobalText(
                                text: language["description"],
                                fontSize: 13,
                                fontFamily: 'nrt-reg',
                                fontWeight: FontWeight.w500,
                                color: AppTheme.grey_thin,
                              ),
                              SizedBox(height: 6),
                              GlobalText(
                                text: shipmentDetail['description'] ?? "",
                                fontSize: 14,
                                fontFamily: 'nrt-bold',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),

                if (length - 1 != index) ...[
                  SizedBox(height: 8),
                  Divider(height: 20, color: AppTheme.grey_between),
                ]
              ],
            ),
          );
  }
}

class _StatisticCard extends StatelessWidget {
  const _StatisticCard({required this.title, required this.value, required this.type, this.weight, this.cmb});

  final String title;
  final String value;
  final String type;
  final cmb;
  final weight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        GlobalText(
          text: title ?? "",
          fontSize: 13,
          fontFamily: 'nrt-reg',
          fontWeight: FontWeight.w500,
          color: AppTheme.grey_thin,
        ),
        SizedBox(height: 8),
        Column(
          children: [
            GlobalText(
              text: value ?? "",
              fontSize: 14,
              fontFamily: 'nrt-bold',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            SizedBox(height: 6),
            GlobalText(
              text: (type == "cbm" && (cmb != null && cmb.toString() != "0"))
                  ? "1" + "x" + cmb
                  : (type == "weight" && (weight != null || weight != "0"))
                      ? "1" + "x" + weight
                      : "",
              fontSize: 13,
              fontFamily: "sf_med",
              color: AppTheme.grey_between,
            ),
          ],
        ),
      ],
    );
  }
}

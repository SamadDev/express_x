import 'package:x_express/Modules/User%20From/Order/order_receive.dart';
import 'package:x_express/Screens/UserForm/Receive/receive_detail.dart';
import 'package:x_express/Utils/exports.dart';
import 'package:timeago/timeago.dart' as timeago;
export 'package:intl/intl.dart';

class OrderClientReceiveCard extends StatelessWidget {
  final type;
  final OrderReceiveModule orderReceive;
  OrderClientReceiveCard({required this.orderReceive, this.type});
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return InkWell(
      onTap: () {
        navigator_route(context: context, page: ReceiveListScreen(orderId: orderReceive.id));
      },
      child: ReceiptListCard(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalText(text:
                            language["receiveNo"] ?? "",
                            fontFamily: 'nrt-reg', fontSize: 16, color: Color(0xff666666),
                          ),
                          SizedBox(height: 4),
                          GlobalText(text:
                            orderReceive.receiveNo ?? "",
                                fontFamily: 'nrt-bold',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppTheme.black,
                          ),
                          SizedBox(height: 4),
                          GlobalText(text:
                            DateFormat('dd-MM-yyyy').format(DateTime.parse(orderReceive.receiveDate)),
                            fontFamily: 'nrt-reg', fontSize: 14, color: Color(0xff666666),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 2, bottom: 9),
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: Color(int.parse("0xff${orderReceive.statusColor}")).withOpacity(.1),
                                borderRadius: BorderRadius.circular(50)),
                            child: GlobalText(text:
                              orderReceive.statusName ?? "status",
                              
                                  fontSize: 14,
                                  fontFamily: 'nrt-reg',
                                  fontWeight: FontWeight.w500,
                                  color: Color(int.parse("0xff${orderReceive.statusColor}",)),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: GlobalText(text:
                              orderReceive.codeName ?? '',
                              color: AppTheme.black, fontFamily: 'nrt-reg',
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalText(text:
                            language["warehouse"] ?? "",
                            fontFamily: 'nrt-reg', fontSize: 16, color: Color(0xff666666),
                          ),
                          SizedBox(height: 4),
                          GlobalText(text:
                            orderReceive.warehouseName ?? "",
                            
                                fontFamily: 'nrt-bold',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppTheme.black,
                          ),
                        ],
                      ),
                      Spacer(),
                      orderReceive.refNo.toString().isEmpty || orderReceive.refNo == null
                          ? SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GlobalText(text:
                                  language["orderNo"] ?? "",
                                  fontFamily: 'nrt-reg', fontSize: 16, color: Color(0xff666666),),

                                SizedBox(height: 5),
                                GlobalText(text:
                                  orderReceive.refNo ?? "",
                                  
                                      fontFamily: 'nrt-bold',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: AppTheme.black,
                                )
                              ],
                            )
                    ],
                  ),
                  Transform.scale(
                    scaleX: 1.07,
                    child: Divider(
                      thickness: 1.1,
                      color: Colors.grey.shade100,
                      height: 35,
                    ),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatisticCard(
                          title: language['totalQty'],
                          value: orderReceive.totalPacking.toString(),
                        ),
                        VerticalDivider(
                          thickness: 1.1,
                          color: Colors.grey.shade300,
                        ),
                        _StatisticCard(
                          title: language['totalCBM'],
                          value: orderReceive.totalCBM.toString(),
                        ),
                        VerticalDivider(
                          thickness: 1.1,
                          color: Colors.grey.shade300,
                        ),
                        _StatisticCard(
                          title: language['totalWeight'],
                          value: orderReceive.totalWeight.toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )

            // ReceiptRowData(
            //   isFirst: true,
            //   title: "Receive No",
            //   value: orderReceive.id.toString(),
            // ),
            // ReceiptRowData(title: "Order No", value: orderReceive.refNo.toString() ?? "-"),
            // ReceiptRowData(
            //   title: "Receive Date",
            //   value: DateFormat("dd-MM-yyyy").format(DateTime.parse(orderReceive.receiveDate.toString())),
            // ),
            // ReceiptRowData(
            //   isFirst: true,
            //   title: "Customer",
            //   value: orderReceive.customerName.toString(),
            // ),
            // ReceiptRowData(
            //   isFirst: true,
            //   title: "Shipping Mark",
            //   value: orderReceive.codeName.toString(),
            // ),
            // ReceiptRowData(title: "Warehouse Name", value: orderReceive.warehouseName.toString()),
            // ReceiptRowData(
            //   title: "Total Packing",
            //   value:
            //       "${NumberFormat.currency(symbol: "", decimalDigits: 2).format(double.parse(orderReceive.totalPacking.toString()))}",
            // ),
            // ReceiptRowData(
            //   title: "Total CBM",
            //   value:
            //       "${NumberFormat.currency(symbol: "", decimalDigits: 2).format(double.parse(orderReceive.totalWeight.toString()))}",
            // ),
            // ReceiptRowData(
            //   isLast: true,
            //   title: "Total Weight",
            //   value:
            //       "${NumberFormat.currency(symbol: "", decimalDigits: 2).format(double.parse(orderReceive.totalWeight.toString()))}",
            // ),
          ],
        ),
      ),
    );
  }
}

class _StatisticCard extends StatelessWidget {
  const _StatisticCard({
    required this.title,
    this.value,
    this.type = '',
  });

  final String title;
  final String? value;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        GlobalText(text:
          title ?? "",

            fontSize: 13,
            fontFamily: 'nrt-reg',
            fontWeight: FontWeight.w500,
            color: AppTheme.grey_thin,

        ),
        SizedBox(height: 5),
        GlobalText(text:
          value == null ? "" : value ?? "",

            fontSize: 14,
            fontFamily: 'nrt-bold',
            fontWeight: FontWeight.bold,
            color: Colors.black,

        ),
      ],
    );
  }
}

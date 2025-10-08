import 'package:x_express/Modules/User%20From/Order/order_receive.dart';
import 'package:x_express/Screens/UserForm/Receive/receive_detail.dart';
import 'package:x_express/Utils/exports.dart';
import 'package:timeago/timeago.dart' as timeago;
export 'package:intl/intl.dart';

class OrderReceiveCard extends StatelessWidget {
  final type;
  final OrderReceiveModule orderReceive;
  OrderReceiveCard({required this.orderReceive, this.type});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigator_route(
            context: context,
            page: type == "user" ? ReceiveListScreen(orderId: orderReceive.id) : UserFormScreen(data: orderReceive.id));
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/images/box.png"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalText(
                              text: orderReceive.codeName ?? "",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.85),
                            ),
                            SizedBox(height: 3),
                            GlobalText(
                              text: orderReceive.customerName ?? "",
                              fontSize: 17,
                              fontFamily: "nrt-bold",
                              fontWeight: FontWeight.bold,
                              color: AppTheme.grey_thin,
                            ),
                          ],
                        ),
                      ),
                      GlobalText(
                        text: orderReceive.receiveNo.toString() ?? "",
                        fontFamily: "nrt-bold",
                        fontWeight: FontWeight.bold,
                        color: AppTheme.grey_thin,
                        fontSize: 15,
                      ),
                      SizedBox(width: 8)
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(children: [
                    Column(
                      children: [
                        GlobalText(
                          text: orderReceive.warehouseName ?? "",
                          fontFamily: 'nrt-bold',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.purple,
                        ),
                        SizedBox(height: 8),
                        GlobalText(
                          text: DateFormat("dd-MM-yyyy").format(DateTime.parse(orderReceive.receiveDate.toString())),
                          fontSize: 17,
                          fontFamily: "nrt-bold",
                          fontWeight: FontWeight.bold,
                          color: AppTheme.grey_between,
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(int.parse("0xff${orderReceive.statusColor}")).withOpacity(0.1)),
                          child: GlobalText(
                            text: orderReceive.statusName ?? "",
                            fontSize: 15,
                            fontFamily: "nrt-bold",
                            fontWeight: FontWeight.bold,
                            color: Color(int.parse(
                              "0xff${orderReceive.statusColor}",
                            )),
                          ),
                        ),
                        SizedBox(height: 8),
                        GlobalText(
                          text: timeago
                              .format(DateTime.parse(orderReceive.receiveDate.toString()), locale: 'en')
                              .replaceAll("now", "")
                              .replaceAll("ago", ""),
                          fontSize: 17,
                          fontFamily: "nrt-bold",
                          fontWeight: FontWeight.bold,
                          color: AppTheme.grey_between,
                        )
                      ],
                    )
                  ]),
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
                          title: "T.CTN",
                          value: orderReceive.totalPacking.toString(),
                        ),
                        VerticalDivider(
                          thickness: 1.1,
                          color: Colors.grey.shade300,
                        ),
                        _StatisticCard(
                          title: "T.CBM",
                          value: orderReceive.totalCBM.toString(),
                        ),
                        VerticalDivider(
                          thickness: 1.1,
                          color: Colors.grey.shade300,
                        ),
                        _StatisticCard(
                          title: "T.Weight",
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
        GlobalText(
          text: title ?? "",
          fontSize: 13,
          fontFamily: 'nrt-reg',
          fontWeight: FontWeight.w500,
          color: AppTheme.grey_thin,
        ),
        SizedBox(height: 5),
        GlobalText(
          text: value == null
              ? ""
              : type == "number"
                  ? NumberFormat.currency(symbol: "").format(double.parse(value.toString()))
                  : value ?? "",
          fontSize: 14,
          fontFamily: 'nrt-bold',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ],
    );
  }
}

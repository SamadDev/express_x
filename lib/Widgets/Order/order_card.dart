import 'package:x_express/Screens/Order/OrderDetail/orderDetail.dart';
import 'package:x_express/Screens/UserForm/OrderUser/Post/order_user_form.dart';
import 'package:x_express/Utils/exports.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final OrderModule? order;
  final type;
  OrderCard({this.order, this.type});

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      height: 180,
      decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          navigator_route(
              context: context,
              page: type == "user"
                  ? OrderFormScreen(data: order)
                  : OrderDetailTapbar(
                      orderId: order!.id,
                    ));
        },
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalText(
                      text: language["orderNumber"],
                      fontSize: 16,
                      color: Color(0xff666666),
                    ),
                    SizedBox(height: 6),
                    GlobalText(
                      text: order!.orderNo ?? "",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppTheme.black,
                    ),
                    SizedBox(height: 6),
                    GlobalText(
                      text: DateFormat('dd-MM-yyyy').format(DateTime.parse(order!.orderDate)),
                      fontSize: 14,
                      color: Color(0xff666666),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(7),
                      margin: EdgeInsets.only(top: 2, bottom: 9),
                      decoration: BoxDecoration(
                          color: Color(int.parse("0xff${order!.statusColor}")).withOpacity(.1),
                          borderRadius: BorderRadius.circular(50)),
                      child: GlobalText(
                        text: order!.statusName ?? "status",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(int.parse(
                          "0xff${order!.statusColor}",
                        )),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: GlobalText(
                        text: order!.codeName ?? '',
                        color: AppTheme.black,
                      ),
                    )
                  ],
                )
              ],
            ),
            Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalText(
                      text: language["orderTotal"],
                      fontSize: 15,
                      color: Color(0xff666666),
                    ),
                    SizedBox(height: 3),
                    GlobalText(
                      text: "${formatQuantity(order!.total ?? "0.0")} ${order!.currencySymbol}",
                      fontFamily: 'nrt-bold',
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: AppTheme.black,
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GlobalText(
                        text: language['remaining'],
                        fontSize: 15,
                        color: Color(0xff666666),
                      ),
                      SizedBox(height: 3),
                      GlobalText(
                        text: "${formatQuantity(order!.remaining ?? "0.0")} ${order!.currencySymbol}",
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: formatQuantity(order!.remaining ?? "0.0").toString().startsWith("0.00")
                            ? AppTheme.black
                            : AppTheme.red,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

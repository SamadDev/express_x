import 'package:x_express/Utils/exports.dart';

class OpenOrder extends StatelessWidget {
  final customerId;
  OpenOrder({this.customerId});
  Widget build(BuildContext context) {
    final openOrder = Provider.of<OpenOrderServices>(context, listen: false);
    final userForm = Provider.of<UserFormService>(context, listen: false);

    return Scaffold(
      backgroundColor: AppTheme.grey_thick,
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 17,
        title: Text("Open Orders"),
        leading: SizedBox.shrink(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close)),
          )
        ],
      ),
      body: FutureBuilder(
          future: openOrder.getOpenOrder(context: context, customerId: customerId),
          builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator(color: AppTheme.primary))
              : AnimationLimiter(
                  child: openOrder.orderList.isEmpty
                      ? EmptyScreen()
                      : ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 20, top: 15),
                          itemCount: openOrder.orderList.length,
                          itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                            position: i,
                            duration: Duration(milliseconds: 500),
                            child: SlideAnimation(
                              verticalOffset: 70.0,
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  onTap: () async {
                                    await openOrder.getOrderItems(context: context, orderId: openOrder.orderList[i].id);
                                    userForm.setItems(openOrder.openOrderItems);
                                    userForm.setOrderId(openOrder.orderList[i].id.toString(),
                                        openOrder.orderList[i].orderNo.toString());
                                    navigator_route_pop(context: context);
                                  },
                                  child: ReceiptListCard(
                                    child: Column(
                                      children: [
                                        ReceiptRowData(
                                          isFirst: true,
                                          title: "Order No",
                                          value: openOrder.orderList[i].orderNo,
                                        ),
                                        ReceiptRowData(
                                          title: "Order Date",
                                          value: DateFormat("dd_MM-yyyy")
                                              .format(DateTime.parse(openOrder.orderList[i].orderDate.toString())),
                                        ),
                                        ReceiptRowData(
                                          title: "Order Status",
                                          value: openOrder.orderList[i].statusName,
                                          color: Color(int.parse("0xff${openOrder.orderList[i].statusColor}")),
                                        ),
                                        ReceiptRowData(
                                          title: "Reference No" ?? "",
                                          value: openOrder.orderList[i].refNo ?? "--",
                                        ),
                                        ReceiptRowData(
                                          title: "Shipping Mark" ?? "",
                                          value: openOrder.orderList[i].codeName.toString(),
                                        ),
                                        ReceiptRowData(
                                          title: "Total" ?? "",
                                          value: NumberFormat.currency(symbol: "")
                                              .format(double.parse(openOrder.orderList[i].total.toString())),
                                        ),
                                        ReceiptRowData(
                                          title: "Total Qty" ?? "",
                                          value: openOrder.orderList[i].totalQty == null
                                              ? ""
                                              : NumberFormat.currency(symbol: "")
                                                  .format(double.parse(openOrder.orderList[i].totalQty.toString())),
                                        ),
                                        ReceiptRowData(
                                          title: "totalPaid" ?? "",
                                          value: NumberFormat.currency(symbol: "")
                                              .format(double.parse(openOrder.orderList[i].remaining.toString())),
                                          isLast: true,
                                        ),
                                      ],
                                    ),
                                    // order: data.pending_list[i],
                                    // type: "pending",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                )),
    );
  }
}

import 'package:x_express/Utils/exports.dart';

class OrderDetailReceipt extends StatelessWidget {
  final orderId;
  OrderDetailReceipt(this.orderId);
  Widget build(BuildContext context) {
    final payment = Provider.of<PaymentOrderService>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 17,
        title: Text(language['payments']),
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
        future: payment.getPaymentOrder(orderId),
        builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
            ? ListView(
                children: List.generate(6, (index) => ShimmerOrderCard()).toList(),
              )
            : Consumer<OrderServices>(
                builder: (ctx, data, _) => payment.paymentOrder.isEmpty
                    ? EmptyScreen()
                    : LazyLoadScrollView(
                        isLoading: false,
                        scrollOffset: 350,
                        onEndOfPage: () {
                          Fluttertoast.showToast(
                              msg: language["please wait"],
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: AppTheme.card,
                              textColor: AppTheme.grey,
                              fontSize: 16.0);
                          data.getOrder(
                            context: context,
                            isPagination: true,
                          );
                        },
                        child: AnimationLimiter(
                          child: RefreshIndicator(
                            color: AppTheme.primary,
                            onRefresh: () async {
                              data.orderList.clear();
                              await data.getOrder(
                                context: context,
                                isRefresh: true,
                              );
                            },
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 20, top: 15),
                              itemCount: payment.paymentOrder.length,
                              itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                                position: i,
                                duration: Duration(milliseconds: 500),
                                child: SlideAnimation(
                                  verticalOffset: 70.0,
                                  child: FadeInAnimation(
                                    child: ReceiptListCard(
                                      child: Column(
                                        children: [
                                          ReceiptRowData(
                                            title: language['paymentNo'] ?? "",
                                            value: payment.paymentOrder[i].paymentNumber,
                                          ),
                                          ReceiptRowData(
                                            isFirst: true,
                                            title: language['paymentDate'] ?? "",
                                            value: DateFormat("dd-MM-yyyy").format(
                                              DateTime.parse(payment.paymentOrder[i].paymentDate!),
                                            ),
                                          ),
                                          ReceiptRowData(
                                            title: language['referenceNumber'] ?? "",
                                            value: payment.paymentOrder[i].reNumber!,
                                          ),
                                          ReceiptRowData(
                                            isLast: true,
                                            title: language['paidAmount'] ?? "",
                                            value:
                                                "${NumberFormat.currency(locale: 'en_US', decimalDigits: 0, symbol: '').format(double.parse(payment.paymentOrder[i].paidAmount.toString()))} ${payment.paymentOrder[i].currency}",
                                          )
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
                        ),
                      ),
              ),
      ),
    );
  }
}

import 'package:x_express/Screens/Order/OrderDetail/Order%20widgets/order_detail_items.dart';
import 'package:x_express/Utils/exports.dart';

class OrderDetailTapbar extends StatefulWidget {
  final orderId;
  OrderDetailTapbar({this.orderId});
  State<OrderDetailTapbar> createState() => _OrderDetailTapbarState();
}

class _OrderDetailTapbarState extends State<OrderDetailTapbar> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    final orderDetail = Provider.of<OrderDetailServices>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        actions: [
          GestureDetector(
            onTap: () {
              navigator_route(
                  context: context,
                  page: PdfViewerScreen(
                    fileExtension: orderDetail.orderDetail["orderNo"],
                    id: widget.orderId,
                    type: "order",
                    url: "order",
                  ));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20, left: 20.0, top: 0),
              child: Image.asset(
                'assets/images/print.png',
                width: 23,
                height: 23,
                color: AppTheme.primary,
              ),
            ),
          ),
        ],
        title: Text(language['orderDetail']),
        backgroundColor: AppTheme.white,
        toolbarHeight: 40.0,
      ),
      body: FutureBuilder(
        future: orderDetail.getDetailOrder(orderId: widget.orderId),
        builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
            ? ShimmerOrderDetail()
            : SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 40, top: 5),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    DetailCard(
                        title: language["generalInfo"],
                        column: Column(
                          children: [
                            RowData(
                                title: language['orderNo'], value: orderDetail.orderDetail['orderNo'], isStart: true),
                            RowData(
                                title: language['orderDate'],
                                value: orderDetail.orderDetail['orderDate'],
                                type: 'date'),
                            RowData(title: language['refNo'], value: orderDetail.orderDetail['orderNo']),
                            RowData(title: language['marka'], value: orderDetail.orderDetail['codeName']),
                            RowData(
                                title: language['deliveryDate'],
                                value: orderDetail.orderDetail['deliveryDate'],
                                type: 'date'),
                            RowData(
                                isLast: true,
                                title: language['orderStatus'],
                                color: Color(int.parse("0xff${orderDetail.orderDetail["statusColor"]}")),
                                value: orderDetail.orderDetail['statusName']),
                          ],
                        )),
                    SizedBox(height: 15),
                    DetailCard(
                      title: language["financialDetails"],
                      isSeeMore: true,
                      onTap: () {
                        ButtonSheetWidget(
                            heightFactor: 0.9,
                            context: context,
                            child: OrderDetailReceipt(orderDetail.orderDetail['id']));
                      },
                      column: Column(
                        children: [
                          RowData(
                              title: language['subTotal'],
                              value: orderDetail.orderDetail['subTotal'],
                              currency: orderDetail.orderDetail['currencySymbol'],
                              type: 'currency'),
                          RowData(
                              title: language['discount'],
                              value: orderDetail.orderDetail['discountAmount'],
                              currency: orderDetail.orderDetail['currencySymbol'],
                              color: AppTheme.red,
                              type: 'currency'),
                          RowData(
                              title: language['total'],
                              value: orderDetail.orderDetail['total'],
                              currency: orderDetail.orderDetail['currencySymbol'],
                              type: 'currency'),
                          RowData(
                              title: language['totalPaid'],
                              value: orderDetail.orderDetail['totalPaid'],
                              type: 'currency',
                              currency: orderDetail.orderDetail['currencySymbol'],
                              color: AppTheme.green),
                          RowData(
                              title: language['remaining'],
                              value: orderDetail.orderDetail['remaining'],
                              type: 'currency',
                              currency: orderDetail.orderDetail['currencySymbol'],
                              color: AppTheme.red),
                          RowData(
                            title: language['dueDate'],
                            value: orderDetail.orderDetail['dueDate'],
                            type: 'date',
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    orderDetail.orderDetail['detailsResult'].isEmpty
                        ? SizedBox.shrink()
                        : DetailCard(
                            title: language["products"],
                            column: Column(
                              children: orderDetail.orderDetail['detailsResult'].map<Widget>((e) {
                                final index = orderDetail.orderDetail['detailsResult'].indexOf(e);
                                return ItemCard(
                                  itemCurrency: orderDetail.orderDetail['currencySymbol'],
                                  item: e,
                                  index: index,
                                  length: orderDetail.orderDetail['detailsResult'].length,
                                );
                              }).toList(),
                            ),
                          )
                  ],
                ),
              ),
      ),
    );
  }
}

import 'package:x_express/Utils/exports.dart';

class OrderUserFilterResultScreen extends StatelessWidget {
  final status;
  final orderNo;
  final refNo;
  final customer;
  final s_date;
  final e_date;

  OrderUserFilterResultScreen({this.status, this.e_date, this.s_date, this.customer, this.orderNo, this.refNo});
  Widget build(BuildContext context) {
    final order = Provider.of<OrderUserServices>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.white,
          title: Text("Filter Result"),
        ),
        body: FutureBuilder(
          future: order.getOrderFilterList(
            context: context,
            isPagination: false,
            orderNumber: orderNo,
            refNo: refNo,
            e_date: e_date,
            s_date: s_date,
            customerId: customer,
          ),
          builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
              ? ShimmerListCard()
              : Consumer<OrderUserServices>(
                  builder: (ctx, data, _) => data.orderFilterList.isEmpty
                      ? EmptyScreen()
                      : Stack(
                          children: [
                            LazyLoadScrollView(
                              onEndOfPage: () async {
                                data.changeState();
                                await data.getOrderFilterList(
                                  context: context,
                                  isPagination: true,
                                  orderNumber: orderNo,
                                  refNo: refNo,
                                  customerId: customer,
                                  e_date: e_date,
                                  s_date: s_date,
                                );
                                data.changeState();
                              },
                              child: AnimationLimiter(
                                child: ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(bottom: 20, top: 7),
                                  itemCount: data.orderFilterList.length,
                                  itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                                    position: i,
                                    duration: Duration(milliseconds: 500),
                                    child: SlideAnimation(
                                      verticalOffset: 70.0,
                                      child: OrderCard(
                                        order: order.orderFilterList[i],
                                        type: "user",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                                visible: data.isLoading,
                                child: Positioned(
                                    bottom: 5,
                                    right: 10,
                                    left: 10,
                                    child: Center(
                                      child: CircularProgressIndicator(color: AppTheme.primary),
                                    )))
                          ],
                        ),
                ),
        ));
  }
}

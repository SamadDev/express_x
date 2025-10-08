
import 'package:x_express/Screens/UserForm/Receive/Widgets/receive_card.dart';
import 'package:x_express/Utils/exports.dart';

class ReceiveFilterResultScreen extends StatelessWidget {
  final status;
  final orderNo;
  final receiveNo;
  final customer;
  final s_date;
  final e_date;

  ReceiveFilterResultScreen({this.status, this.e_date, this.s_date, this.customer, this.orderNo, this.receiveNo});
  Widget build(BuildContext context) {
    final order = Provider.of<ReceiveServices>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.white,
          title: Text("Filter Result"),
        ),
        body: FutureBuilder(
          future: order.getOrderReceivesFilterList(
            context: context,
            isPagination: false,
            orderNumber: orderNo,
            receiveNo: receiveNo,
            e_date: e_date,
            s_date: s_date,
            customer: customer,
          ),
          builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
              ? Column(children: List.generate(4, (index) => ShimmerOrderCard()))
              : Consumer<ReceiveServices>(
                  builder: (ctx, data, _) => data.orderFilterList.isEmpty
                      ? EmptyScreen()
                      : Stack(
                          children: [
                            LazyLoadScrollView(
                              onEndOfPage: () async {
                                data.changeState();
                                await data.getOrderReceivesFilterList(
                                  context: context,
                                  isPagination: true,
                                  orderNumber: orderNo,
                                  receiveNo: receiveNo,
                                  customer: customer,
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
                                      child: OrderReceiveCard(
                                        index: i,
                                        length: data.orderFilterList.length,
                                        orderReceive: data.orderFilterList[i],
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

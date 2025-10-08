import 'package:x_express/Screens/UserForm/OrderUser/Filter/order_user_filter.dart';
import 'package:x_express/Screens/UserForm/OrderUser/Post/order_user_form.dart';
import 'package:x_express/Utils/exports.dart';

class OrderUserListScreen extends StatelessWidget {
  final type;
  OrderUserListScreen({this.type = "employ"});
  Widget build(BuildContext context) {
    final order = Provider.of<OrderUserServices>(context, listen: false);
    return Scaffold(
      floatingActionButton: type == "user"
          ? SizedBox.shrink()
          : FloatingActionButton(
              backgroundColor: AppTheme.primary,
              onPressed: () {
                navigator_route(context: context, page: OrderFormScreen());
              },
              child: Icon(
                Icons.add,
                color: AppTheme.white,
              ),
            ),
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(createRoute(OrderUserFilterScreen()));
            },
            child: Padding(
              padding: EdgeInsets.only(top: 15, right: 20, left: 20),
              child: Image.asset(
                'assets/images/filter.png',
                width: 20,
                height: 20,
                color: AppTheme.primary,
              ),
            ),
          ),
        ],
        // titleSpacing: 0,
        elevation: 0.1,
        leading: SizedBox.shrink(),
        leadingWidth: type == "user" ? 40 : 20,
        title: Text("Order List"),
      ),
      body: FutureBuilder(
          future: order.getOrder(context: context),
          builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
              ? ShimmerListCard()
              : Consumer<OrderUserServices>(
                  builder: (ctx, data, _) => data.isRefresh
                      ? ShimmerListCard()
                      : data.orderList.isEmpty
                          ? EmptyScreen()
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                LazyLoadScrollView(
                                  onEndOfPage: () async {
                                    data.changeState();
                                    await data.getOrder(context: context, isPagination: true);
                                    data.changeState();
                                  },
                                  child: AnimationLimiter(
                                    child: RefreshIndicator(
                                      color: AppTheme.primary,
                                      onRefresh: () async {
                                        data.onRefreshLoading();
                                        await data.getOrder(context: context, isRefresh: true);
                                        data.onRefreshLoading();
                                      },
                                      child: ListView.builder(
                                        physics: AlwaysScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 20, top: 7),
                                        itemCount: order.orderList.length,
                                        itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                                          position: i,
                                          duration: Duration(milliseconds: 500),
                                          child: SlideAnimation(
                                            verticalOffset: 70.0,
                                            child: FadeInAnimation(
                                              child: OrderCard(
                                                order: order.orderList[i],
                                                type: "user",
                                              ),
                                            ),
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
                            ))),
    );
  }
}

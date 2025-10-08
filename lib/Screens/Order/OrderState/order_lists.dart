import 'package:x_express/Utils/exports.dart';

class OrderPendingScreen extends StatefulWidget {
  final int statusId;

  OrderPendingScreen({required this.statusId});

  @override
  _OrderPendingScreenState createState() => _OrderPendingScreenState();
}

class _OrderPendingScreenState extends State<OrderPendingScreen> {
  late OrderServices orderService;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    orderService = Provider.of<OrderServices>(context, listen: false);
    _fetchOrders();
  }

  void _fetchOrders() async {
    setState(() {
      isLoading = true;
    });
    await orderService.getOrder(context: context, statusId: widget.statusId, isPagination: false);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? ShimmerListCard()
        : Consumer<OrderServices>(
            builder: (ctx, data, _) {
              if (data.isRefresh) {
                return ShimmerListCard();
              } else if (data.orderList.isEmpty) {
                return EmptyScreen();
              } else {
                return Stack(
                  children: [
                    LazyLoadScrollView(
                      scrollOffset: (Responsive.sH(context) * 0.1).round(),
                      onEndOfPage: () async {
                        data.changeState();
                        await data.getOrderFilterList(context: context, isPagination: true, statusId: widget.statusId);
                        data.changeState();
                      },
                      child: AnimationLimiter(
                        child: RefreshIndicator(
                          color: AppTheme.primary,
                          onRefresh: () async {
                            data.onRefreshLoading();
                            await data.getOrder(context: context, isRefresh: true, statusId: widget.statusId);
                            data.onRefreshLoading();
                          },
                          child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 20, top: 7),
                            itemCount: data.orderList.length,
                            itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                              position: i,
                              duration: Duration(milliseconds: 500),
                              child: SlideAnimation(
                                verticalOffset: 70.0,
                                child: FadeInAnimation(
                                  child: OrderCard(
                                    order: data.orderList[i],
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
                          child: CircularProgressIndicator(
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          );
  }
}

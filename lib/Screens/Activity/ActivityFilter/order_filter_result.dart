import 'package:x_express/Utils/exports.dart';

class FilterResultScreen extends StatelessWidget {
  final status;
  final orderNo;
  final s_date;
  final e_date;

  FilterResultScreen({this.status, this.e_date, this.s_date, this.orderNo});
  Widget build(BuildContext context) {
    final order = Provider.of<OrderServices>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.white,
          title: Text("Filter Result"),
        ),
        body: FutureBuilder(
          future: order.getOrderFilterList(
            context: context,
            statusId: status,
            isPagination: false,
            orderNumber: orderNo,
            e_date: e_date,
            s_date: s_date,
          ),
          builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
              ? Column(children: List.generate(4, (index) => ShimmerOrderCard()))
              : Consumer<OrderServices>(
                  builder: (ctx, data, _) => data.orderFilterList.isEmpty
                      ? EmptyScreen()
                      : LazyLoadScrollView(
                          isLoading: false,
                          scrollOffset: 350,
                          onEndOfPage: () async {
                            Fluttertoast.showToast(
                                msg: language.getWords["please wait"],
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: AppTheme.card,
                                textColor: AppTheme.primary,
                                fontSize: 16.0);
                            await data.getOrderFilterList(
                              context: context,
                              statusId: status,
                              isPagination: false,
                              orderNumber: orderNo,
                              e_date: e_date,
                              s_date: s_date,
                            );
                          },
                          child: AnimationLimiter(
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 20),
                              itemCount: data.orderFilterList.length,
                              itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                                position: i,
                                duration: Duration(milliseconds: 500),
                                child: SlideAnimation(
                                  verticalOffset: 70.0,
                                  child: OrderCard(
                                    order: data.orderFilterList[i],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
        ));
  }
}

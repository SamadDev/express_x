import 'package:x_express/Utils/exports.dart';

class OrderSearchListScreen extends StatelessWidget {
  final text;
  OrderSearchListScreen({this.text});
  Widget build(BuildContext context) {
    return Consumer<OrderServices>(
      builder: (ctx, data, _) => data.orderSearchList.isEmpty
          ? EmptyScreen()
          : Stack(
              children: [
                LazyLoadScrollView(
                  onEndOfPage: () async {
                    data.changeState();
                    await data.getOrderSearch(isPagination: true, text: text);
                    data.changeState();
                  },
                  child: AnimationLimiter(
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 0, top: 7),
                      itemCount: data.orderSearchList.length,
                      itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                        position: i,
                        duration: Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 70.0,
                          child: FadeInAnimation(
                            child: Column(
                              children: [
                                OrderCard(order: data.orderSearchList[i]),
                              ],
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
            ),
    );
  }
}

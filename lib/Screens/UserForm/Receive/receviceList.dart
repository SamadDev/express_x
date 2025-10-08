import 'package:x_express/Screens/UserForm/Receive/Filter/receive_filter.dart';
import 'package:x_express/Screens/UserForm/Receive/Widgets/receive_card.dart';
import 'package:x_express/Screens/UserForm/Receive/Widgets/receive_client_card.dart';
import 'package:x_express/Utils/exports.dart';

class OrderReceiveListScreen extends StatelessWidget {
  final type;
  OrderReceiveListScreen({this.type = "employ"});
  Widget build(BuildContext context) {
    final orderReceive = Provider.of<ReceiveServices>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
      floatingActionButton: type == "user"
          ? SizedBox.shrink()
          : FloatingActionButton(
              backgroundColor: AppTheme.primary,
              onPressed: () {
                navigator_route(context: context, page: UserFormScreen());
              },
              child: Icon(Icons.add, color: AppTheme.white)),
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(createRoute(ReceiveFilterScreen(
                type: "client",
              )));
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
        title: GlobalText(
          text: language["receivesList"],
          fontSize: 22,
          fontFamily: 'nrt-bold',
          fontWeight: FontWeight.bold,
          color: AppTheme.black,
        ),
      ),
      body: FutureBuilder(
          future: orderReceive.getOrderReceives(),
          builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
              ? ShimmerListCard()
              : Consumer<ReceiveServices>(
                  builder: (ctx, data, _) => data.isRefresh
                      ? ShimmerListCard()
                      : data.orderReceiveList.isEmpty
                          ? EmptyScreen()
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                LazyLoadScrollView(
                                  onEndOfPage: () async {
                                    data.changeState();
                                    await data.getOrderReceives(context: context, isPagination: true);
                                    data.changeState();
                                  },
                                  child: AnimationLimiter(
                                    child: RefreshIndicator(
                                      color: AppTheme.primary,
                                      onRefresh: () async {
                                        data.onRefreshLoading();
                                        await data.getOrderReceives(context: context, isRefresh: true);
                                        data.onRefreshLoading();
                                      },
                                      child: ListView.builder(
                                        physics: AlwaysScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 20, top: 7),
                                        itemCount: orderReceive.orderReceiveList.length,
                                        itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                                          position: i,
                                          duration: Duration(milliseconds: 500),
                                          child: SlideAnimation(
                                            verticalOffset: 70.0,
                                            child: FadeInAnimation(
                                              child: type == 'user'
                                                  ? OrderClientReceiveCard(
                                                      orderReceive: orderReceive.orderReceiveList[i],
                                                      type: type,
                                                    )
                                                  : OrderReceiveCard(
                                                      index: i,
                                                      length: data.orderReceiveList.length,
                                                      orderReceive: orderReceive.orderReceiveList[i],
                                                      type: type,
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

import 'package:x_express/Screens/UserForm/Receive/Widgets/receive_client_card.dart';
import 'package:x_express/Utils/exports.dart';

class ReceiveClientScreen extends StatefulWidget {
  final int statusId;
  final String? type;

  ReceiveClientScreen({required this.statusId, this.type});

  @override
  _ReceiveClientScreenState createState() => _ReceiveClientScreenState();
}

class _ReceiveClientScreenState extends State<ReceiveClientScreen> {
  late ReceiveServices receiveService;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    receiveService = Provider.of<ReceiveServices>(context, listen: false);
    _fetchReceives();
  }

  void _fetchReceives() async {
    setState(() {
      isLoading = true;
    });
    await receiveService.getOrderReceives(context: context, statusId: widget.statusId, isPagination: false);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? ShimmerListCard()
        : Consumer<ReceiveServices>(
            builder: (ctx, data, _) {
              if (data.isRefresh) {
                return ShimmerListCard();
              } else if (data.orderReceiveList.isEmpty) {
                return EmptyScreen();
              } else {
                return Stack(
                  children: [
                    LazyLoadScrollView(
                      scrollOffset: (Responsive.sH(context) * 0.1).round(),
                      onEndOfPage: () async {
                        data.changeState();
                        await data.getOrderReceives(context: context, isPagination: true, statusId: widget.statusId);
                        data.changeState();
                      },
                      child: AnimationLimiter(
                        child: RefreshIndicator(
                          color: AppTheme.primary,
                          onRefresh: () async {
                            data.onRefreshLoading();
                            await data.getOrderReceives(context: context, isRefresh: true, statusId: widget.statusId);
                            data.onRefreshLoading();
                          },
                          child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 20, top: 7),
                            itemCount: data.orderReceiveList.length,
                            itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                              position: i,
                              duration: Duration(milliseconds: 500),
                              child: SlideAnimation(
                                verticalOffset: 70.0,
                                child: FadeInAnimation(
                                  child: OrderClientReceiveCard(
                                    type: "user",
                                    orderReceive: data.orderReceiveList[i],
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

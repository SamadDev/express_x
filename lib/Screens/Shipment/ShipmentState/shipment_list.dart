import 'package:x_express/Utils/exports.dart';

class ShipmentListScreen extends StatefulWidget {
  final int statusId;

  ShipmentListScreen({required this.statusId});

  @override
  _ShipmentListScreenState createState() => _ShipmentListScreenState();
}

class _ShipmentListScreenState extends State<ShipmentListScreen> {
  late ShipmentServices shipmentService;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    shipmentService = Provider.of<ShipmentServices>(context, listen: false);
    _fetchShipments();
  }

  void _fetchShipments() async {
    setState(() {
      isLoading = true;
    });
    await shipmentService.getShipment(context: context, statusId: widget.statusId, isPagination: false);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? ShimmerListCard()
        : Consumer<ShipmentServices>(
      builder: (ctx, data, _) {
        if (data.isRefresh) {
          return ShimmerListCard();
        } else if (data.shipmentList.isEmpty) {
          return EmptyScreen();
        } else {
          return Stack(
            children: [
              LazyLoadScrollView(
                onEndOfPage: () async {
                  data.changeState();
                  await data.getShipment(context: context, isPagination: true, statusId: widget.statusId);
                  data.changeState();
                },
                child: AnimationLimiter(
                  child: RefreshIndicator(
                    color: AppTheme.primary,
                    onRefresh: () async {
                      data.onRefreshLoading();
                      await data.getShipment(context: context, isRefresh: true, statusId: widget.statusId);
                      data.onRefreshLoading();
                    },
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 0, top: 7),
                      itemCount: data.shipmentList.length,
                      itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                        position: i,
                        duration: Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 70.0,
                          child: FadeInAnimation(
                            child: Column(
                              children: [
                                ShipmentCard(
                                  shipment: data.shipmentList[i],
                                ),
                              ],
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
              ),
            ],
          );
        }
      },
    );
  }
}
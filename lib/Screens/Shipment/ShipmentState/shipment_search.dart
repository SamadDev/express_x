import 'package:x_express/Utils/exports.dart';

class ShipmentSearchListScreen extends StatelessWidget {
  final text;
  ShipmentSearchListScreen({this.text});
  Widget build(BuildContext context) {
    final data = Provider.of<ShipmentServices>(context, listen: false);
    return data.shipmentSearchList.isEmpty
        ? EmptyScreen()
        : Stack(
            children: [
              LazyLoadScrollView(
                onEndOfPage: () async {
                  data.changeState();
                  await data.getShipmentSearch(isPagination: true, text: text);
                  data.changeState();
                },
                child: AnimationLimiter(
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 0, top: 7),
                    itemCount: data.shipmentSearchList.length,
                    itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                      position: i,
                      duration: Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 70.0,
                        child: FadeInAnimation(
                          child: Column(
                            children: [
                              ShipmentCard(
                                shipment: data.shipmentSearchList[i],
                              ),
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
              ),
            ],
          );
  }
}

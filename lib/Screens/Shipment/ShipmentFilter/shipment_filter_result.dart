import 'package:x_express/Screens/Shipment/ShipmentState/Widget/shipment_card.dart';
import 'package:x_express/Utils/exports.dart';

class ShipmentFilterResultScreen extends StatelessWidget {
  final shipmentNmber;
  final status;
  final s_date;
  final e_date;

  ShipmentFilterResultScreen({this.status, this.e_date, this.s_date, this.shipmentNmber});
  Widget build(BuildContext context) {
    final shipment = Provider.of<ShipmentServices>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.white,
          title: Text("Filter Result"),
        ),
        body: FutureBuilder(
          future: shipment.getShipmentFilterList(
            context: context,
            statusId: status,
            isPagination: false,
            shipmentNumber: shipmentNmber,
            e_date: e_date,
            s_date: s_date,
          ),
          builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
              ? Column(children: List.generate(4, (index) => ShimmerOrderCard()))
              : Consumer<ShipmentServices>(
                  builder: (ctx, data, _) => data.shipmentFilterList.isEmpty
                      ? EmptyScreen()
                      : Stack(
                          children: [
                            LazyLoadScrollView(
                              onEndOfPage: () async {
                                data.changeState();
                                await data.getShipmentFilterList(
                                  context: context,
                                  statusId: status,
                                  isPagination: true,
                                  shipmentNumber: shipmentNmber,
                                  e_date: e_date,
                                  s_date: s_date,
                                );
                                data.changeState();
                              },
                              child: AnimationLimiter(
                                child: ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(bottom: 20, top: 7),
                                  itemCount: data.shipmentFilterList.length,
                                  itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                                    position: i,
                                    duration: Duration(milliseconds: 500),
                                    child: SlideAnimation(
                                      verticalOffset: 70.0,
                                      child: ShipmentCard(
                                        shipment: data.shipmentFilterList[i],
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
                ),
        ));
  }
}

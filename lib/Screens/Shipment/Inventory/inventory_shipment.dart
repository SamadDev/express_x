import 'package:x_express/Screens/Shipment/Inventory/Widgets/shipment_dashboardCard.dart';
import 'package:x_express/Services/Shipment/inventory.dart';
import 'package:x_express/Utils/exports.dart';

class ShipmentDashboardListScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final inventory = Provider.of<InventoryListDetailService>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;
    TextEditingController _searchController = TextEditingController();
    final Debouncer _debouncer = Debouncer(milliseconds: 200);

    return Scaffold(
      appBar: AppBar(
        actions: [],
        leadingWidth: 40,
        title: Text(language["shipmentDetail"]),
      ),
      body: FutureBuilder(
        future: inventory.getInventoryShipment(),
        builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
            ? SingleChildScrollView(child: Column(children: List.generate(12, (index) => ShimmerOrderCard())))
            : Consumer<InventoryListDetailService>(
                builder: (ctx, data, _) => data.inventoryShipmentList.isEmpty
                    ? EmptyScreen()
                    : Column(
                      children: [

                        Padding(
                          padding: EdgeInsets.only(right: 12, left: 12, bottom: 0),
                          child: CustomSearchFormField(
                            controller: _searchController,
                            hintText: language['search'],
                            prefix: Icon(Icons.search,size: 24),
                            hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: AppTheme.black),
                            fillColor: AppTheme.white,
                            borderType: true,
                            onChange: (value) async {
                              _debouncer.run(() {
                                data.getInventoryShipment(text: _searchController.text, isRefresh: true);
                              });
                            },
                          ),
                        ),
                        (data.inventoryShipmentList.isEmpty ||
                            (data.inventoryShipmentList.isEmpty && _searchController.text.isNotEmpty))
                            ? Expanded(child: EmptyScreen())
                            : Expanded(
                          child: AnimationLimiter(
                            child: RefreshIndicator(
                              color: AppTheme.primary,
                              onRefresh: () async {
                                data.inventoryShipmentList.clear();
                                await data.getInventoryShipment(
                                  context: context,
                                  isRefresh: true,
                                );
                              },
                              child: ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.only(bottom: 20, top: 4),
                                itemCount: inventory.inventoryShipmentList.length,
                                itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                                  position: i,
                                  duration: Duration(milliseconds: 500),
                                  child: SlideAnimation(
                                    verticalOffset: 70.0,
                                    child: FadeInAnimation(
                                      child: ShipmentDashboardCard(
                                        inventory: inventory.inventoryShipmentList[i],
                                        length: inventory.inventoryShipmentList.length,
                                        index: i,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
      ),
    );
  }
}

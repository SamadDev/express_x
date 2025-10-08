import 'package:x_express/Screens/Shipment/Inventory/Widgets/InventoryListDetailCard.dart';
import 'package:x_express/Services/Shipment/inventory.dart';
import 'package:x_express/Utils/exports.dart';

class InventoryListScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final inventory = Provider.of<InventoryListDetailService>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;
    TextEditingController _searchController = TextEditingController();

    final Debouncer _debouncer = Debouncer(milliseconds: 200);

    return Scaffold(
      appBar: AppBar(
        actions: [],
        leadingWidth: 40,
        title: Text(language['inventory']),
      ),
      body: FutureBuilder(
        future: inventory.getInventory(),
        builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
            ? SingleChildScrollView(child: Column(children: List.generate(12, (index) => ShimmerOrderCard())))
            : Consumer<InventoryListDetailService>(
                builder: (ctx, data, _) => Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                          child: CustomSearchFormField(
                            controller: _searchController,
                            prefix: Icon(Icons.search,size: 24),
                            hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: AppTheme.black),
                            hintText: language['search'],
                            fillColor: AppTheme.white,
                            borderType: true,
                            onChange: (value) async {
                              _debouncer.run(() {
                                data.getInventory(text: _searchController.text, isRefresh: true);
                              });
                            },
                          ),
                        ),
                        (data.inventoryList.isEmpty ||
                                (data.inventoryList.isEmpty && _searchController.text.isNotEmpty))
                            ? Expanded(child: EmptyScreen())
                            : Expanded(
                                child: AnimationLimiter(
                                  child: RefreshIndicator(
                                    color: AppTheme.primary,
                                    onRefresh: () async {
                                      data.inventoryList.clear();
                                      await data.getInventory(context: context, isRefresh: true);
                                    },
                                    child: ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(bottom: 20, top: 4),
                                      itemCount: inventory.inventoryList.length,
                                      itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                                        position: i,
                                        duration: Duration(milliseconds: 500),
                                        child: SlideAnimation(
                                          verticalOffset: 70.0,
                                          child: FadeInAnimation(
                                            child: InventoryListDetailCard(
                                              inventory: inventory.inventoryList[i],
                                              length: inventory.inventoryList.length,
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

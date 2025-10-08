import 'package:x_express/Screens/Shipment/ShipmentFilter/shipment_filter.dart';
import 'package:x_express/Screens/Shipment/ShipmentState/shipment_search.dart';

import 'package:x_express/Utils/exports.dart';

class ShipmentTapBar extends StatefulWidget {
  State<ShipmentTapBar> createState() => _ShipmentTapBarState();
}

class _ShipmentTapBarState extends State<ShipmentTapBar> with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  TabController? _controller;

  Widget build(BuildContext context) {
    final status = Provider.of<ShipmentStatusService>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;
    final Debouncer _debouncer = Debouncer(milliseconds: 200);

    return FutureBuilder(
      future: status.getStatusShipment(),
      builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
          ? ShimmerTab(title: language["shipments"])
          : DefaultTabController(
        length: status.shipmentStatus.length,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(createRoute(ShipmentFilterScreen()));
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20, left: 20.0, top: 15),
                  child: Image.asset(
                    'assets/images/filter.png',
                    width: 20,
                    height: 20,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ],
            backgroundColor: AppTheme.grey_thick,
            centerTitle: false,
            toolbarHeight: 70.0,
            titleSpacing: 20,
            title: GlobalText(text:
              language["shipments"],

                  fontSize: 22, fontFamily: 'nrt-bold', fontWeight: FontWeight.bold, color: AppTheme.black,
            ),
          ),
          body: Consumer<ShipmentServices>(
            builder: (ctx, search, _) => Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 12, left: 12, bottom: 12),
                  child: CustomSearchFormField(
                    controller: _searchController,
                    prefix: Icon(Icons.search,size: 24),
                    hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: AppTheme.black),
                    hintText: language['search'],
                    fillColor: AppTheme.white,
                    borderType: false,
                    textInputAction: TextInputAction.search,
                    onChange: (value) {
                      _debouncer.run(() {
                        search.getShipmentSearch(text: value, isRefresh: true);
                      });
                    },
                  ),
                ),
                if (_searchController.text.isEmpty) ...[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    height: 38,
                    decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(8.0)),
                    child: TabBar(
                      controller: _controller,
                      indicator: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: AppTheme.primary),
                      labelColor: AppTheme.white,
                      unselectedLabelColor: AppTheme.black,
                      tabs: List.generate(
                        status.shipmentStatus.length,
                            (index) => status.shipmentStatus[index].id == 1
                            ? SizedBox.shrink()
                            : Tab(
                          child: TextLanguage(
                            titleAr: status.shipmentStatus[index].titleAr,
                            titleEn: status.shipmentStatus[index].title,
                            titleKr: status.shipmentStatus[index].titleKr,
                            style: TextStyle(fontFamily: "nrt-reg"),
                            ),
                          ),
                        ),
                      ),
                    ),

                ],
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    physics: AlwaysScrollableScrollPhysics(),
                    children: List.generate(
                        status.shipmentStatus.length,
                            (index) => status.shipmentStatus[index].id == 1
                            ? SizedBox()
                            : _searchController.text.isNotEmpty
                            ? ShipmentSearchListScreen(text: _searchController.text)
                            : ShipmentListScreen(statusId: status.shipmentStatus[index].id)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


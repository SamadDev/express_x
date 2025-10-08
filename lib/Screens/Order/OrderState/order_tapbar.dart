import 'package:x_express/Screens/Order/OrderFilter/order_filter.dart';
import 'package:x_express/Screens/Order/OrderState/order_search.dart';
import 'package:x_express/Theme/theme.dart';
import 'package:x_express/Utils/exports.dart';

class OrderTapBar extends StatefulWidget {
  State<OrderTapBar> createState() => _OrderTapBarState();
}

class _OrderTapBarState extends State<OrderTapBar> with SingleTickerProviderStateMixin {
  TabController? _controller;
  TextEditingController _searchController = TextEditingController();

  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    final status = Provider.of<OrderStatusService>(context, listen: false);
    final Debouncer _debouncer = Debouncer(milliseconds: 200);

    return FutureBuilder(
      future: status.getStatusOrder(),
      builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
          ? ShimmerTab(title: language.getWords['orderNav'])
          : DefaultTabController(
              length: status.orderStatus.length,
              initialIndex: 0,
              child: Scaffold(
                backgroundColor: AppTheme.scaffold,
                appBar: AppBar(
                  actions: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(createRoute(OrderFilterScreen()));
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
                  centerTitle: false,
                  toolbarHeight: 70.0,
                  titleSpacing: 20,
                  title: Text(language.getWords['orderNav']),
                ),
                body: Consumer<OrderServices>(
                  builder: (ctx, order, _) => Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 12, left: 12, bottom: 12),
                        child: CustomSearchFormField(
                          controller: _searchController,
                          prefix: Icon(Icons.search, size: 24),
                          hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: AppTheme.black),
                          hintText: language.getWords['search'],
                          fillColor: AppTheme.white,
                          borderType: true,
                          textInputAction: TextInputAction.search,
                          onChange: (value) {
                            _debouncer.run(() {
                              order.getOrderSearch(text: value, isRefresh: true);
                            });
                          },
                        ),
                      ),

                      if (_searchController.text.isEmpty) ...[
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TabBar(
                            controller: _controller,
                            indicator: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: AppTheme.primary),
                            labelColor: AppTheme.white,
                            unselectedLabelColor: AppTheme.black,
                            isScrollable: false,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: List.generate(
                              status.orderStatus.length,
                              (index) => Tab(
                                child: TextLanguage(
                                  titleAr: status.orderStatus[index].titleAr,
                                  titleEn: status.orderStatus[index].title,
                                  titleKr: status.orderStatus[index].titleKr,
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
                              status.orderStatus.length,
                              (index) => _searchController.text.isEmpty
                                  ? OrderPendingScreen(statusId: status.orderStatus[index].id)
                                  : OrderSearchListScreen(
                                      text: _searchController.text,
                                    )),
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

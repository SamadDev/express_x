import 'package:x_express/Utils/exports.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    required this.width,
    required this.height,
    this.radius = 3,
    this.padding = 0,
  });

  final double width;
  final double height;
  final double radius;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: padding, left: padding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Shimmer.fromColors(
          baseColor: AppTheme.card,
          highlightColor: Colors.grey[300]!,
          child: Container(
            padding: EdgeInsets.only(right: padding, left: padding),
            width: width,
            height: height,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius), color: AppTheme.card),
          ),
        ),
      ),
    );
  }
}

class WebViewerShimmer extends StatelessWidget {
  const WebViewerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: ShimmerEffect(width: double.infinity, height: 40),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final child;
  const DashboardCard({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Row(
          children: [
            ShimmerEffect(width: 20, height: 2),
          ],
        ),
      ),
      Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: child)
    ]);
    ;
  }
}

class ShimmerDashboardList extends StatelessWidget {
  const ShimmerDashboardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DashboardCard(
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [ShimmerRateDashboardCard(), ShimmerRateDashboardCard(), ShimmerRateDashboardCard()])),
      ),
      DashboardCard(
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [ShimmerRateDashboardCard(), ShimmerRateDashboardCard(), ShimmerRateDashboardCard()])),
      ),
      DashboardCard(
          child: Column(children: [
        ShimmerTransactionDashboardCard(),
        ShimmerTransactionDashboardCard(),
        ShimmerTransactionDashboardCard(),
      ])),
      DashboardCard(
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [ShimmerRateDashboardCard(), ShimmerRateDashboardCard(), ShimmerRateDashboardCard()])),
      )
    ]);
  }
}

class ShimmerTransactionDashboardCard extends StatelessWidget {
  const ShimmerTransactionDashboardCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppTheme.grey_thick.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ], color: AppTheme.white, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      width: Responsive.sW(context),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 45,
              height: 45,
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(color: AppTheme.green.withOpacity(0.1), borderRadius: BorderRadius.circular(90)),
              child: ShimmerEffect(width: 45, height: 45),
            ),
            SizedBox(width: 18),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerEffect(width: 20, height: 5),
                SizedBox(height: 6),
                Row(children: [
                  ShimmerEffect(width: 45, height: 5),
                ]),
              ],
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShimmerEffect(width: 20, height: 5),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ShimmerRateDashboardCard extends StatelessWidget {
  const ShimmerRateDashboardCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppTheme.white),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            ShimmerEffect(width: 20, height: 8),
            Spacer(),
            ShimmerEffect(width: 20, height: 8),
          ],
        ),
        SizedBox(height: 17),
        ShimmerEffect(width: 20, height: 8),
        SizedBox(height: 17),
        Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ShimmerEffect(width: 20, height: 8),
            Row(
              children: [
                ShimmerEffect(width: 20, height: 8),
              ],
            ),
          ]),
          Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ShimmerEffect(width: 20, height: 8),
            Row(
              children: [
                ShimmerEffect(width: 20, height: 8),
              ],
            ),
          ]),
        ]),
      ]),
    );
  }
}

class ShimmerOrderCard extends StatelessWidget {
  const ShimmerOrderCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 150,
      decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerEffect(width: 70, height: 12),
                  SizedBox(height: 6),
                  ShimmerEffect(width: 70, height: 12),
                  SizedBox(height: 6),
                  ShimmerEffect(width: 70, height: 12),
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                height: 30,
                child: ShimmerEffect(width: 70, height: 30),
              )
            ],
          ),
          Spacer(),
          Row(
            children: [
              Column(
                children: [
                  ShimmerEffect(width: 70, height: 12),
                  SizedBox(height: 5),
                  ShimmerEffect(width: 70, height: 12),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  ShimmerEffect(width: 70, height: 12),
                  SizedBox(height: 5),
                  ShimmerEffect(width: 70, height: 12),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ShimmerListCard extends StatelessWidget {
  const ShimmerListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: List.generate(12, (index) => ShimmerOrderCard())));
  }
}

class ShimmerTab extends StatefulWidget {
  final title;
  const ShimmerTab({Key? key, this.title}) : super(key: key);

  @override
  State<ShimmerTab> createState() => _ShimmerTabState();
}

class _ShimmerTabState extends State<ShimmerTab> {
  var _tabController;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppTheme.white,
            centerTitle: false,
            toolbarHeight: 70.0,
            titleSpacing: 20,
            title: GlobalText(
              text: widget.title,
              fontSize: 22,
              fontFamily: 'nrt-bold',
              fontWeight: FontWeight.bold,
              color: AppTheme.black,
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20, left: 20.0, top: 15),
                child: Image.asset(
                  'assets/images/filter.png',
                  width: 20,
                  height: 20,
                  color: AppTheme.primary,
                ),
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              isScrollable: false,
              unselectedLabelStyle: TextStyle(
                  fontFamily: 'nrt-reg', fontWeight: FontWeight.w500, fontSize: 14, color: AppTheme.grey_thin),
              labelStyle: TextStyle(
                  fontFamily: 'nrt-reg', fontWeight: FontWeight.w500, fontSize: 14, color: AppTheme.grey_thin),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(4),
              tabs: [
                Tab(
                    child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
                        child: ShimmerEffect(height: 18, width: 49))),
                Tab(
                    child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
                        child: ShimmerEffect(height: 18, width: 49))),
                Tab(
                    child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
                        child: ShimmerEffect(height: 18, width: 49))),
                Tab(
                    child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
                        child: ShimmerEffect(height: 18, width: 49))),
              ],
            )),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(12, (index) => ShimmerOrderCard()),
          ),
        ),
      ),
    );
  }
}

class ShimmerShipmentDetail extends StatelessWidget {
  const ShimmerShipmentDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: AppTheme.primary,
                    leading: BackButton(color: AppTheme.white),
                    pinned: true,
                    floating: true,
                    expandedHeight: 170.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SizedBox(
                        height: 170,
                        child: Stack(
                          alignment: Alignment.center,
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(AppTheme.primary.withOpacity(0.3), BlendMode.darken),
                                  child: Image.asset(
                                    "assets/images/back.jpg",
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 30),
                                  GlobalText(
                                      text: language['shipments'],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: AppTheme.grey_thick),
                                  SizedBox(height: 8),
                                  GlobalText(
                                    text: language['shipmentDetail'] ?? "",
                                    fontSize: 15,
                                    fontFamily: 'nrt-reg',
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.grey_thick,
                                  ),
                                  SizedBox(height: 40),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    ShimmerEffect(width: 60, height: 20),
                    SizedBox(height: 20),
                    ShimmerEffect(width: 60, height: 20),
                  ]))
                ],
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}

class ShimmerOrderDetail extends StatelessWidget {
  const ShimmerOrderDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 12),
            ShimmerEffect(width: 60, height: 20),
            // SizedBox(height: 10),
            ShimmerEffect(width: 60, height: 20),
          ],
        ),
      ),
    );
    ;
  }
}

class ShimmerReceiveDetail extends StatelessWidget {
  const ShimmerReceiveDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            ShimmerEffect(width: 60, height: 20),
            // SizedBox(height: 10),
            ShimmerEffect(width: 60, height: 20),
          ],
        ),
      ),
    );
    ;
  }
}

class ShimmerDetailCard extends StatelessWidget {
  final title;
  const ShimmerDetailCard({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
      child: OrderDetailCard(
        title: title,
        column1: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerEffect(width: 100, height: 15),
            SizedBox(height: 20),
            ShimmerEffect(width: 100, height: 15),
            SizedBox(height: 20),
            ShimmerEffect(width: 100, height: 15),
            SizedBox(height: 20),
            ShimmerEffect(width: 100, height: 15),
            SizedBox(height: 20),
            ShimmerEffect(width: 100, height: 15),
            SizedBox(height: 20),
            ShimmerEffect(width: 100, height: 15),
            SizedBox(height: 20),
            ShimmerEffect(width: 100, height: 15),
            SizedBox(height: 20),
          ],
        ),
        column2: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ShimmerEffect(width: 100, height: 15),
            SizedBox(height: 20),
            ShimmerEffect(width: 100, height: 15),
            SizedBox(height: 20),
            ShimmerEffect(width: 100, height: 15),
            SizedBox(height: 20),
            ShimmerEffect(width: 100, height: 15),
            SizedBox(height: 20),
            ShimmerEffect(width: 100, height: 15),
            SizedBox(height: 20),
            ShimmerEffect(width: 100, height: 15),
            SizedBox(height: 20),
            ShimmerEffect(width: 100, height: 15),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class OrderDetailCard extends StatelessWidget {
  final title;
  final isSeeMore;
  final onTap;
  final column1;
  final column2;
  const OrderDetailCard({this.column1, this.column2, this.title, this.onTap, this.isSeeMore = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            children: [
              GlobalText(
                text: title,
                fontFamily: 'nrt-reg',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppTheme.black,
              ),
              Spacer(),
              isSeeMore
                  ? GestureDetector(
                      onTap: onTap,
                      child: GlobalText(
                        text: "See Details",
                        fontFamily: 'nrt-reg',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppTheme.primary,
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [column1, Spacer(), column2],
          ),
        )
      ],
    );
  }
}

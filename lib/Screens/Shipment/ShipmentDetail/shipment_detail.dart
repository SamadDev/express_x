import 'package:x_express/Screens/Shipment/ShipmentDetail/shipment_items_detail.dart';
import 'package:x_express/Screens/Shipment/ShipmentDetail/track_web.dart';
import 'package:x_express/Utils/directionWidget.dart';
import 'package:x_express/Utils/exports.dart';
import 'package:intl/intl.dart' as intl;

class ShipmentDetailScreen extends StatefulWidget {
  final shipmentId;
  ShipmentDetailScreen({this.shipmentId});

  @override
  State<ShipmentDetailScreen> createState() => _ShipmentDetailScreenState();
}

class _ShipmentDetailScreenState extends State<ShipmentDetailScreen> {
  ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    final shipmentService = Provider.of<ShipmentDetailServices>(context, listen: false);
    shipmentService.getDetailShipment(shipmentId: widget.shipmentId);
    // shipmentService.updateSelectedIndex(0);
    super.initState();
  }

  Widget build(BuildContext context) {
    final shipmentService = Provider.of<ShipmentDetailServices>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;
    final loading = Provider.of<ShipmentDetailServices>(context, listen: true);

    return Scaffold(
      body: Stack(
        children: [
          loading.loading
              ? ShimmerShipmentDetail()
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverAppBar(
                          actions: [
                            GestureDetector(
                              onTap: () {
                                navigator_route(
                                    context: context,
                                    page: PdfViewerScreen(
                                      fileExtension: shipmentService.shipmentDetail['shipmentNo'],
                                      type: "shipment",
                                      url: "customer-shipment",
                                      id: widget.shipmentId,
                                    ));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 20, left: 20.0, top: 0),
                                child: Container(
                                  child: Image.asset(
                                    'assets/images/print.png',
                                    width: 23,
                                    height: 23,
                                    color: AppTheme.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                          backgroundColor: AppTheme.primary,
                          leading: BackButton(color: AppTheme.white),
                          pinned: true,
                          floating: true,
                          title: GlobalText(
                            text: _scrollPosition > 130
                                ? "${language['shipment']} ${shipmentService.shipmentDetail['shipmentNo'].toString()}"
                                : "",
                            color: AppTheme.white,
                          ),
                          expandedHeight: 170.0,
                          flexibleSpace: FlexibleSpaceBar(
                            background: SizedBox(
                              height: 200,
                              child: _Header(
                                shipment: shipmentService.shipmentDetail,
                              ),
                            ),
                          ),
                        ),
                        SliverList(
                            delegate: SliverChildListDelegate([
                          SizedBox(height: 22),
                          BasicInfo(shipment: shipmentService.shipmentDetail),
                          SizedBox(height: 22),
                          _DeliveryStatus(shipment: shipmentService.shipmentDetail),
                          SizedBox(height: shipmentService.shipmentDetail['tracks'].toString() == '[]' ? 0 : 22),
                          ShipmentProduct(shipment: shipmentService.shipmentDetail),
                        ]))
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final shipment;

  _Header({this.shipment});
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Stack(
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
          margin: EdgeInsets.only(top: 70),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30),
              DirectionalityWidget(
                child: GlobalText(
                  text: "${language['shipment']} #${shipment['shipmentNo'].toString()}",
                  fontFamily: 'nrt-bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppTheme.grey_thick,
                ),
              ),
              SizedBox(height: 8),
              GlobalText(
                text: shipment['location'] == null ? '' : shipment['location']['name'],
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
    );
  }
}

class BasicInfo extends StatelessWidget {
  final shipment;
  const BasicInfo({Key? key, this.shipment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;

    return DetailCard(
        title: language["basicInfo"],
        column: Column(
          children: [
            RowData(title: '${language['shipmentNumber']}', value: shipment['shipmentNo'], isStart: true),
            RowData(title: language['date'], value: shipment['shipmentDate'].toString(), type: 'date'),
            RowData(title: language['deliveryDate'], value: shipment['deliveryDate'], type: 'date'),
            RowData(
                title: language["shippingCountry"],
                value: shipment['originCountry'] == null ? "" : shipment['originCountry']['name']),
            RowData(
                title: language['shippingPort'],
                value: shipment['originPort'] == null ? '' : shipment['originPort']['name']),
            RowData(
                title: language["destinationCountry"],
                value: shipment['destinationCountry'] == null ? "" : shipment['destinationCountry']['name']),
            RowData(
                title: language["destinationCity"],
                value: shipment['destinationCity'] == null ? "" : shipment['destinationCity']['name']),
            RowData(
                title: language['destinationPort'],
                value: shipment['destinationPort'] == null ? "" : shipment['destinationPort']['name']),
            RowData(
                title: "${language['currentLocation']}",
                value: shipment['location'] == null ? "" : shipment['location']['name']),
            RowData(
                title: '${language['status']}',
                value: shipment['status']['name'],
                color: Color(
                    shipment['status']['color'] == null ? 0xff00000 : int.parse("0xff${shipment['status']['color']}")),
                isLast: true),
          ],
        ));
  }
}

class _DeliveryStatus extends StatelessWidget {
  final shipment;
  _DeliveryStatus({this.shipment});
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return shipment['tracks'].toString() == '[]'
        ? SizedBox.shrink()
        : DetailCard(
            isSeeMore: true,
            isSubtext: true,
            title: language['tracking'],
            onTap: () {
              navigator_route(context: context, page: ShipmentTrack(containerNum: shipment['containerNo']));
            },
            column: Column(
                children: shipment['tracks'].map<Widget>((e) {
              final isFirst = shipment['tracks'].indexOf(e) == 0;
              final isLast = shipment['tracks'].indexOf(e) == shipment['tracks'].length - 1;
              return _DeliveryStatusItem(
                title: e['location'] == null ? '' : e['location']['name'] ?? "",
                date: e['date'] ?? '',
                description: e['description'] ?? '',
                isFirst: isFirst,
                isLast: isLast,
              );
            }).toList()),
          );
  }
}

class ShipmentProduct extends StatelessWidget {
  final shipment;
  const ShipmentProduct({Key? key, this.shipment}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return shipment['details'] == null
        ? SizedBox()
        : DetailCard(
            title: language["products"],
            column: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppTheme.white),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(children: [
                          _TextTile(title: language['totalQuantity'], value: shipment['totalPacking'].toString() ?? ""),
                          _TextTile(title: language["totalCBM"], value: shipment['totalCBM'].toString()),
                          _TextTile(title: language["totalWeight"], value: shipment['totalWeight'].toString() ?? ""),
                        ]),
                      ),
                      Column(
                        children: shipment['details'].map<Widget>((e) {
                          final index = shipment['details'].indexOf(e);

                          return ItemCard(shipmentDetail: e, index: index, length: shipment['details'].length);
                        }).toList(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}

class _DeliveryStatusItem extends StatelessWidget {
  const _DeliveryStatusItem({
    required this.date,
    required this.title,
    required this.description,
    this.isFirst = false,
    this.isLast = false,
  });

  final String date;
  final String title;
  final String description;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Transform.translate(
              offset: const Offset(0, 30),
              child: SizedBox(
                width: 30,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isLast
                        ? Container(
                            width: 30,
                            height: 30,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(90)),
                            child: Image.asset(
                              'assets/images/ship.png',
                              height: 20,
                              width: 20,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Container(
                            child: CircleAvatar(
                              backgroundColor: AppTheme.primary,
                              radius: 4,
                            ),
                          ),
                    isLast
                        ? SizedBox.shrink()
                        : Expanded(
                            child: Container(
                              width: 1,
                              color: AppTheme.primary,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 7),
                  Row(children: [
                    GlobalText(
                      text: "$title ",
                      fontSize: 17,
                      fontFamily: "nrt-bold",
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                    Spacer(),
                    GlobalText(
                      text: "${intl.DateFormat('dd-MM-yyyy').format(DateTime.parse(date))}",
                      fontSize: 14,
                      fontFamily: "sf_med",
                      color: AppTheme.black,
                    ),
                  ]),
                  SizedBox(height: 8),
                  GlobalText(
                    text: description ?? "",
                    color: AppTheme.grey_thin,
                    fontSize: 15,
                    fontFamily: "sf_med",
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextTile extends StatelessWidget {
  const _TextTile({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 7,
                  child: GlobalText(
                    text: title,
                    color: Colors.grey.shade800,
                    fontSize: 15,
                  ),
                ),
                VerticalDivider(color: Colors.grey.shade200, thickness: 1.1),
                Expanded(
                  flex: 12,
                  child: GlobalText(
                    text: value,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 15.5,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey.shade200, thickness: 1.1),
        ],
      ),
    );
  }
}

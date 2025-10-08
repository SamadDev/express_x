import 'package:x_express/Modules/User%20From/Order/order_receive_by_id.dart';
import 'package:x_express/Utils/exports.dart';

class ReceiveListScreen extends StatelessWidget {
  final orderId;
  final index;
  final length;
  ReceiveListScreen({this.orderId, this.length, this.index});

  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    final receive = Provider.of<ReceiveServices>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              navigator_route(
                  context: context,
                  page: PdfViewerScreen(
                    fileExtension: receive.receiveDataModule!.receiveNo.toString(),
                    id: orderId,
                    type: "receive",
                    url: "order-receive",
                  ));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20, left: 20.0, top: 0),
              child: Image.asset(
                'assets/images/print.png',
                width: 23,
                height: 23,
                color: AppTheme.primary,
              ),
            ),
          )
        ],
        elevation: 0.1,
        title: Text(language['receiveDetail'] ?? "Receive Detail"),
        backgroundColor: AppTheme.white,
        toolbarHeight: 40.0,
      ),
      body: FutureBuilder(
        future: receive.getReceiveOrderWithId(context: context, id: orderId),
        builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
            ? ShimmerReceiveDetail()
            : SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 40, top: 5),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    DetailCard(
                        title: language["generalInfo"],
                        column: Column(
                          children: [
                            RowData(
                                title: language['receiveNo'] ?? "",
                                value: receive.receiveDataModule!.receiveNo.toString(),
                                isStart: true),
                            RowData(
                                title: language['receiveDate'],
                                value: receive.receiveDataModule!.receiveDate!,
                                type: 'date'),
                            RowData(title: language['orderNo'], value: receive.receiveDataModule!.refNo ?? ""),
                            // RowData(
                            //     title: language['warehouse']??"", value: receive.receiveDataModule!.warehouse!.toString() ?? ""),
                            RowData(
                              title: language['marka'],
                              value: receive.receiveDataModule!.customerCode!.name ?? "",
                              isLast: false,
                            ),

                            RowData(
                                isLast: true,
                                title: language['status'],
                                color: Color(int.parse("0xff${receive.receiveDataModule!.status!.color!}")),
                                value: StringLanguage(
                                  titleKr: receive.receiveDataModule!.status!.nameKr ?? "",
                                  titleAr: receive.receiveDataModule!.status!.nameAr ?? "",
                                  titleEn: receive.receiveDataModule!.status!.name ?? "",
                                  context: context,
                                ))
                          ],
                        )),
                    SizedBox(
                      height: 25,
                    ),
                    receive.receiveDataModule!.details!.isEmpty
                        ? SizedBox.shrink()
                        : DetailCard(
                            title: language["products"],
                            column: Column(
                              children: receive.receiveDataModule!.details!.map<Widget>((e) {
                                final length = receive.receiveDataModule!.details!.length;
                                final index = receive.receiveDataModule!.details!.indexOf(e);

                                return ItemCard(
                                  item: e,
                                  index: index,
                                  length: length,
                                );
                              }).toList(),
                            ),
                          )
                  ],
                ),
              ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final index;
  final length;
  final Details item;
  ItemCard({required this.item, this.index, this.length});
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Container(
      color: AppTheme.white,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      // margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          SizedBox(height: 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppTheme.grey_thick,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    "assets/images/itesm.png",
                    color: AppTheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.itemCode.toString().isNotEmpty && item.itemCode != null) ...[
                      GlobalText(text:
                        item.itemCode ?? "",
                        
                          fontSize: 13,
                          color: Colors.black.withOpacity(0.65),

                      ),
                      SizedBox(height: 3),
                    ],
                    GlobalText(text:
                      item.itemName ?? "",
                      
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.85),

                    ),
                  ],
                ),
              ),
              if (!item.total.toString().startsWith("0") && item.total != null) ...[
                Text(
                  "${item.total}",
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1,
                    fontFamily: 'nrt-bold',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ],
            ],
          ),
          //
          // Transform.scale(
          //   scaleX: 1.07,
          //   child: Divider(
          //     thickness: 1.1,
          //     color: Colors.grey.shade100,
          //     height: 35,
          //   ),
          // ),
          SizedBox(height: 20),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatisticCard(
                  title: language["totalQty"],
                  type: "carton",
                  carton: formatQuantity(item.packingQuantity ?? 0),
                  packing: formatQuantity(item.packing ?? 0),
                  value: formatQuantity(item.quantity),
                ),
                VerticalDivider(
                  thickness: 1.1,
                  color: Colors.grey.shade300,
                ),
                _StatisticCard(
                  title: language["totalCBM"],
                  type: "cbm",
                  cmb: formatQuantity(item.totalCBM ?? 0),
                  value: formatQuantity(item.totalCBM),
                  // value: "${formatQuantity(item['unitPrice'])} $itemCurrency",
                ),
                VerticalDivider(
                  thickness: 1.1,
                  color: Colors.grey.shade300,
                ),
                _StatisticCard(
                  title: language["totalWeight"],
                  type: 'weight',
                  weight: "${formatQuantity(item.totalWeight ?? 0)}",
                  value: "${formatQuantity(item.totalWeight ?? 0)}",
                ),
              ],
            ),
          ),
          item.description == null
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ).copyWith(top: 25),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          language["description"],
                          style: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'nrt-reg',
                            fontWeight: FontWeight.w500,
                            color: AppTheme.grey_thin,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          item.description ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'nrt-bold',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),

          if (length - 1 != index) ...[
            SizedBox(height: 8),
            Divider(height: 20, color: AppTheme.grey_between),
          ]
        ],
      ),
    );
  }
}

class _StatisticCard extends StatelessWidget {
  const _StatisticCard(
      {required this.title, required this.value, required this.type, this.packing, this.carton, this.weight, this.cmb});

  final String title;
  final String value;
  final String type;
  final cmb;
  final packing;
  final weight;
  final carton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        Text(
          title.toString() ?? "",
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'nrt-reg',
            fontWeight: FontWeight.w500,
            color: AppTheme.grey_thin,
          ),
        ),
        SizedBox(height: 8),
        Column(
          children: [
            Text(
              value.toString() ?? "",
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'nrt-bold',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 6),
            GlobalText(text:
              (type == "cbm" && (cmb != null && cmb.toString() != "0"))
                  ? "1" + "x" + cmb
                  : (type == "weight" && (weight != null || weight != "0"))
                      ? "1" + "x" + weight
                      : (type == "carton" && (carton != null && carton.toString() != "0"))
                          ? packing + "x" + carton
                          : "",
              fontSize: 13, fontFamily: "sf_med", color: AppTheme.grey_between,
            )
          ],
        ),
      ],
    );
  }
}

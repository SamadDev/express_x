import 'package:x_express/Utils/exports.dart';

class ItemCard extends StatelessWidget {
  final item;
  final itemCurrency;
  final index;
  final length;
  ItemCard({this.itemCurrency, this.item, this.index, this.length});
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Container(
      decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(8)),
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
                    if (item['itemCode'].toString().isNotEmpty || item['itemCode'] != null) ...[
    GlobalText(text:
                        item['itemCode'] ?? "${item['sort']}",

                          fontSize: 13,
                          color: Colors.black.withOpacity(0.65),

                      ),
                      SizedBox(height: 3),
                    ],
                      GlobalText(text:
                      item['itemName'] ?? "",

                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.85),

                    ),
                  ],
                ),
              ),
              if (!item['total'].toString().startsWith("0") || item['total'] != null) ...[
                Text(
                  "${formatQuantity(item['total'])} $itemCurrency",
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1,
                    fontFamily: 'nrt-bold',fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ]
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
                  title: language["carton"],
                  value: formatQuantity(item['packing']),
                ),
                VerticalDivider(
                  thickness: 1.1,
                  color: Colors.grey.shade300,
                ),
                _StatisticCard(
                  title: language["quantity"],
                  value: formatQuantity(item['packingQuantity']),
                  // value: "${formatQuantity(item['unitPrice'])} $itemCurrency",
                ),
                VerticalDivider(
                  thickness: 1.1,
                  color: Colors.grey.shade300,
                ),
                _StatisticCard(
                  title: language["totalQty"],
                  value: "${formatQuantity(item['quantity'])}",
                ),
                VerticalDivider(
                  thickness: 1.1,
                  color: Colors.grey.shade300,
                ),
                _StatisticCard(
                  title: language["unitPrice"],
                  value: "${formatQuantity(item['unitPrice'])} $itemCurrency",
                ),
              ],
            ),
          ),
          item['description'] == null
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ).copyWith(top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        language["description"],
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,
                          color: AppTheme.grey_thin,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        item['description'] ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'nrt-bold',fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
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
  const _StatisticCard({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        Text(
          title ?? "",
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,
            color: AppTheme.grey_thin,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value ?? "",
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'nrt-bold',fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

import 'package:x_express/Modules/Shimpent/inventory.dart';
import 'package:x_express/Screens/Currency/Widets/currency_card.dart';
import 'package:x_express/Utils/exports.dart';

class ShipmentDashboardCard extends StatelessWidget {
  final ShipmentDashboardModule inventory;
  final index;
  final length;
  ShipmentDashboardCard({required this.inventory, this.index, this.length});
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
      decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        children: [
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
                    if (inventory.itemCode.toString().isNotEmpty || inventory.itemCode != null) ...[
                      GlobalText(text:
                        inventory.itemCode ?? "",
                        
                          fontSize: 13,
                          color: Colors.black.withOpacity(0.65),
              
                      ),
                      SizedBox(height: 3),
                    ],
                    GlobalText(text:
                      inventory.itemName ?? "",
                      
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.85),
                
                    ),
                  ],
                ),
              ),
              if (!inventory.shipmentNo.toString().startsWith("0") && inventory.shipmentNo != null) ...[
                Column(
                  children: [
                    SizedBox(height: 8),
                    GlobalText(text:
                      "${DateFormat("yyyy-MM-dd").format(DateTime.parse(inventory.shipmentDate.toString()))}",
                     
                        fontSize: 13,
                     
                        fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,
                        color: AppTheme.grey_thin,
              
                    ),
                    SizedBox(height: 8),
                    GlobalText(text:
                      "${inventory.shipmentNo}",
                      
                        fontSize: 15,
                 
                        fontFamily: 'nrt-bold',fontWeight: FontWeight.bold,
                        color: Colors.black,
             
                    ),
                  ],
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
                  title: language["carton"],
                  type: "",
                  value: formatQuantity(inventory.packing ?? 0),
                ),
                VerticalDivider(
                  thickness: 1.1,
                  color: Colors.grey.shade300,
                ),
                _StatisticCard(
                  title: language["totalCBM"],
                  type: "cbm",
                  value: inventory.totalCBM.toString(),
                  // value: "${formatQuantity(item['unitPrice'])} $itemCurrency",
                ),
                VerticalDivider(
                  thickness: 1.1,
                  color: Colors.grey.shade300,
                ),
                _StatisticCard(
                  title: language["totalWeight"],
                  type: 'weight',
                  value: inventory.totalWeight.toString(),
                ),
              ],
            ),
          ),
          inventory.description == null
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
                        GlobalText(text:
                          language["description"],
                        
                            fontSize: 13,
                            fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,
                            color: AppTheme.grey_thin,
                
                        ),
                        SizedBox(height: 6),
                        GlobalText(text:
                          inventory.description ?? "",
         
                            fontSize: 14,
                          fontWeight: FontWeight.bold,
                            color: Colors.black,
                          textAlign: TextAlign.justify,
                     
                     
                        ),
                      ],
                    ),
                  ),
                ),

          // if (length - 1 != index) ...[
          //   SizedBox(height: 8),
          //   Divider(height: 20, color: AppTheme.grey_between),
          // ]
        ],
      ),
    );
  }
}

class _StatisticCard extends StatelessWidget {
  const _StatisticCard({required this.title, required this.value, required this.type, this.weight, this.cmb});

  final String title;
  final String value;
  final String type;
  final cmb;
  final weight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        GlobalText(text:
          title ?? "",

            fontSize: 13,
          fontWeight: FontWeight.w500,
            color: AppTheme.grey_thin,

        ),
        SizedBox(height: 8),
        Column(
          children: [
            GlobalText(text:
              value ?? "",

                fontSize: 14,
              fontWeight: FontWeight.bold,
                color: Colors.black,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:x_express/Screens/Shipment/ShipmentDetail/shipment_detail.dart';
import 'package:x_express/Screens/Shipment/ShipmentState/Widget/shipment_tracking.dart';
import 'package:x_express/Utils/exports.dart';
import 'package:intl/intl.dart' as intl;

class ShipmentCard extends StatelessWidget {
  final ShipmentModule shipment;
  const ShipmentCard({Key? key, required this.shipment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);

    return InkWell(
      onTap: () {
        navigator_route(
            context: context,
            page: ShipmentDetailScreen(
              shipmentId: shipment.id,
            ));
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalText(
                          text: language.getWords["shipmentNumber"],
                          fontSize: 15,
                          fontFamily: 'nrt-reg',
                          color: AppTheme.grey_between,
                        ),
                        SizedBox(height: 2),
                        GlobalText(
                          text: shipment.shipmentNo ?? "-",
                          fontSize: 17,
                          fontFamily: 'nrt-bold',
                          fontWeight: FontWeight.bold,
                          color: AppTheme.black,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2, bottom: 9),
                      padding: EdgeInsets.all(7),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(int.parse("0xff${shipment.statusColor}")).withOpacity(.2),
                          borderRadius: BorderRadius.circular(12)),
                      child: GlobalText(
                        text: shipment.statusName,
                        fontSize: 14,
                        fontFamily: 'nrt-reg',
                        fontWeight: FontWeight.w500,
                        color: Color(int.parse(
                          "0xff${shipment.statusColor}",
                        )),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Directionality(
                  textDirection: language.languageCode == "en" ? TextDirection.rtl : TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalText(
                            text: shipment.fromLocationName ?? "",
                            fontSize: 14,
                            fontFamily: 'nrt-reg',
                            fontWeight: FontWeight.w500,
                            color: AppTheme.black,
                          ),
                          SizedBox(height: 2),
                          GlobalText(
                            text: intl.DateFormat('dd-MM-yyyy').format(DateTime.parse(shipment.shipmentDate)),
                            fontSize: 12,
                            fontFamily: 'nrt-reg',
                            fontWeight: FontWeight.w500,
                            color: AppTheme.grey_thin,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GlobalText(
                            text: shipment.toLocationName ?? "",
                            fontSize: 14,
                            fontFamily: 'nrt-reg',
                            fontWeight: FontWeight.w500,
                            color: AppTheme.black,
                          ),
                          SizedBox(height: 2),
                          GlobalText(
                            text: shipment.deliveryDate == null
                                ? language.getWords["estimatedDelivery"]
                                : "ETA ${intl.DateFormat("dd-MM-yyyy").format(DateTime.parse(shipment.deliveryDate))}",
                            //  language["destination"],

                            fontSize: 12,
                            fontFamily: 'nrt-reg',
                            fontWeight: FontWeight.w500,
                            color: AppTheme.grey_thin,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6),
                SizedBox(
                  height: 70,
                  child: LineWithPoint(
                    startPoint: Offset(7, 30),
                    endPoint: Offset(Responsive.sW(context) * 0.835, 30),
                    city: shipment.locationName ?? "",
                    middlePercentage: shipment.deliveryRate > 1 ? 1.0 : double.parse(shipment.deliveryRate.toString()),
                  ),
                ),
                SizedBox(height: 5)
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}

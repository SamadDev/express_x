import 'package:x_express/Modules/Currency/currency.dart';
import 'package:x_express/Utils/exports.dart';
export 'package:intl/intl.dart';

class CurrencyCard extends StatelessWidget {
  final CurrencyModule currency;
  CurrencyCard({required this.currency});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 1),
          Padding(
            padding: EdgeInsets.only(left: 3, right: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: "assets/images/china.png",
                  height: 32,
                  width: 32,
                  margin: EdgeInsets.only(bottom: 4),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    top: 2,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalText(text:
                        currency.toCurrency!.name ?? "",
                        fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, fontSize: 14, color: AppTheme.black,
                      ),
                      SizedBox(height: 4),
                      GlobalText(text:
                        currency.toCurrency!.code.toUpperCase() ?? "",
                     fontFamily: 'nrt-reg', fontSize: 13, color: Color(0xff808080),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  children: [
                    GlobalText(text:
                      "${currency.exchangeRate.toString()} ${currency.toCurrency!.symbol ?? ""}",
                      fontFamily: 'nrt-bold',fontWeight: FontWeight.bold, fontSize: 17, color: AppTheme.black,
                    ),
                    // SizedBox(height: 4),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: GlobalText(text:
                    //     "+10%",
                    //     fontFamily: 'nrt-reg', fontSize: 13, color: AppTheme.green),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GlobalText(text:
                  currency.description ?? "",
                  fontSize: 15,  fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: AppTheme.black,
                ),
                GlobalText(text:
                  DateFormat('dd-MM-yyyy').format(DateTime.parse(currency.date.toString())),
                  fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, fontSize: 13, color: AppTheme.grey_thin,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

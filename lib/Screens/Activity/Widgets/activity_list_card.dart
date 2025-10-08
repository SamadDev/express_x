import 'package:x_express/Modules/Activity/activity.dart';
import 'package:x_express/Screens/Activity/Widgets/activity_detail.dart';
import 'package:x_express/Utils/date_format.dart';
import 'package:x_express/Utils/exports.dart';

class ActivityListCard extends StatelessWidget {
  final Transactions transaction;
  ActivityListCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return InkWell(
      onTap: () {
        ShowModuleBottomSheet(context, ActivityDetailScreen(transaction));
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 45,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: transaction.credit < transaction.debit
                              ? AppTheme.red.withOpacity(0.1)
                              : AppTheme.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(90)),
                      child: RotatedBox(
                        quarterTurns: transaction.credit < transaction.debit ? 4 : 2,
                        child: Image.asset(
                          "assets/images/down.png",
                          width: 10,
                          height: 10,
                          color: transaction.credit < transaction.debit ? AppTheme.red : AppTheme.green,
                        ),
                      )),
                  SizedBox(width: 18),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalText(
                        text: transaction.documentType ?? "",
                        fontSize: 16,

                        fontWeight: FontWeight.bold,
                        color: AppTheme.black,
                      ),
                      SizedBox(height: 6),
                      Row(children: [
                        if (transaction.documentNo != null) ...[
                          GlobalText(
                              text: transaction.documentNo ?? "",
                              fontFamily: 'nrt-reg',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppTheme.grey_thin),
                          GlobalText(
                              text: "  -  ",
                              fontFamily: 'nrt-reg',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppTheme.grey_thin),
                        ],
                        GlobalText(
                          text: formatDate(transaction.documentDate),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppTheme.grey_thin,
                        )
                      ]),
                    ],
                  ),
                  Spacer(),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      GlobalText(text:
                          "${transaction.currencySymbol} ${formatQuantity(transaction.credit > transaction.debit ? transaction.credit : transaction.debit ?? 0)} ",
                          fontSize: 15,  color: AppTheme.black,
                        ),
                        SizedBox(height: 8),
                      GlobalText(text:
                          "${transaction.currencySymbol} ${NumberFormat.currency(decimalDigits: 0, symbol: "").format(transaction.balance ?? 0)} ",
                          
                              fontSize: 15,

                              color: transaction.balance! > 0
                                  ? AppTheme.red
                                  : transaction.balance == 0.0
                                      ? AppTheme.black
                                      : AppTheme.green,
                        )
                      ])
                ],
              ),
              if (transaction.description != null && transaction.description!.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.only(
                      left: language.languageCode == "en" ? 50 : 0, right: language.languageCode == "en" ? 0 : 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Divider(),
                    GlobalText(text:
                        transaction.description!,
                        fontSize: 15,  color: AppTheme.black,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          )),
    );
  }
}

import 'package:x_express/Utils/date_format.dart';
import 'package:x_express/Utils/exports.dart';
import 'package:x_express/Modules/Activity/activity.dart';

class ActivityDetailScreen extends StatelessWidget {
  final Transactions transaction;
  ActivityDetailScreen(this.transaction);
  Widget build(BuildContext context) {
    print(transaction.documentDate);
    final language = Provider.of<Language>(context, listen: false).getWords;

    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Column(
        children: [
          AppBar(),
          AnimationConfiguration.staggeredList(
            position: 1,
            duration: Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 70.0,
              child: FadeInAnimation(
                child: ReceiptListCard(
                  child: Column(
                    children: [
                      ReceiptRowData(
                        isFirst: true,
                        title: language['documentNo'] ?? "",
                        value: transaction.documentNo??"",
                      ),
                      ReceiptRowData(
                        title: language['documentDate'] ?? "",
                        value:formatDate(transaction.documentDate),
                      ),
                      ReceiptRowData(
                        title: language['amount'] ?? "",
                        value: transaction.balance.toString(),
                      ),
                      ReceiptRowData(
                        title: language['exchangeRate'] ?? "",
                        value: transaction.exchangeRate.toString(),
                      ),
                      ReceiptRowData(
                        title: language['exchangeAmount'] ?? "",
                        value: transaction.exchangeAmount.toString(),
                      ),
                      ReceiptRowData(
                        title: language['description'] ?? "",
                        value: transaction.description.toString(),
                      ),
                      // ReceiptRowData(
                      //   isLast: true,
                      //   title: language['paidAmount'] ?? "",
                      //   value: transaction.credit ?? "",
                      // )
                    ],
                  ),
                  // order: data.pending_list[i],
                  // type: "pending",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

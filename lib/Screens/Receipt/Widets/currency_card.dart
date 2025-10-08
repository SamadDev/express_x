import 'package:x_express/Screens/Receipt/receipt_detail.dart';
import 'package:x_express/Utils/exports.dart';
export 'package:intl/intl.dart';

class ReceiptCard extends StatelessWidget {
  final ReceiptModule receipt;
  ReceiptCard({required this.receipt});
  @override
  Widget build(BuildContext context) {
    final language=Provider.of<Language>(context,listen: false).getWords;
    return InkWell(
      onTap: () {
        navigator_route(page: VoucherDetailsPage(receipt: receipt), context: context);
      },
      child: ReceiptListCard(
        child: Column(
          children: [
            ReceiptRowData(
              isFirst: true,
              title: language["receiptNo"],
              value: receipt.docNo.toString(),
            ),
            ReceiptRowData(
              title: language["receiptDate"],
              value: DateFormat("yyyy-MM-dd").format(DateTime.parse(receipt.docDate.toString())),
            ),
            ReceiptRowData(
              title: language["amountMoney"].toString(),
              value:
                  "${formatQuantity(receipt.amount??0)} ${receipt.currencyName}",
            ),
            ReceiptRowData(
              title: language["discount"]??"",
              value:
                  "${formatQuantity(double.parse(receipt.discount.toString()))} ${receipt.toCurrencyName}",
              color: AppTheme.red,
            ),
            ReceiptRowData(
              title: language["fee"]??"",
              value:
              "${formatQuantity(double.parse(receipt.fee.toString()))} ${receipt.currencyName}",
            ),
            ReceiptRowData(
              title: language["paymentMethod"]??"",
              value: receipt.paymentMethodName,
              isLast: true,
            )
          ],
        ),
      ),
    );
  }
}

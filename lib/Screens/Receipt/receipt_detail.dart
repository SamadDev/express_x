import 'package:x_express/Screens/Currency/Widets/currency_card.dart';
import 'package:x_express/Utils/exports.dart';

class VoucherDetailsPage extends StatelessWidget {
  final ReceiptModule receipt;
  const VoucherDetailsPage({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
      appBar: AppBar(),
      extendBody: false,
      extendBodyBehindAppBar: false,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: AnimationLimiter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 2000),
              childAnimationBuilder: (widget) => SlideAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                delay: const Duration(milliseconds: 55),
                verticalOffset: 40,
                child: FadeInAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  delay: const Duration(milliseconds: 55),
                  child: widget,
                ),
              ),
              children: [
                Center(
                  child: GlobalText(text:
                    language['receiptDetails'],
                    fontSize: 23, fontFamily: "sf_med", color: AppTheme.black,
                  ),
                ),
                const SizedBox(height: 18),
                const DashedLine(color: Colors.grey),
                _VoucherHeaderInfo(receipt: receipt),
                // const DashedLine(color: Colors.grey),
                // _VoucherItems(),
                const DashedLine(color: Colors.grey),
                _BottomVoucherInfo(receipt: receipt),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VoucherHeaderInfo extends StatelessWidget {
  final ReceiptModule receipt;
  _VoucherHeaderInfo({required this.receipt});
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _VoucherHeaderTextTile(
            title: language['receiptNumber'],
            value: receipt.docNo ?? "",
          ),
          _VoucherHeaderTextTile(
            title: language['receiptDate'],
            value: DateFormat("dd-MM-yyyy").format(DateTime.parse(receipt.docDate.toString())),
          ),
          receipt.refNo.toString().isEmpty
              ? SizedBox.shrink()
              : _VoucherHeaderTextTile(
                  title: language['referenceNumber'],
                  value: receipt.refNo ?? "",
                ),
          _VoucherHeaderTextTile(
            title: language['amountMoney'],
            value:
                "${formatQuantity(double.parse(receipt.amount.toString()))} ${receipt.currencyName}",
          ),
          _VoucherHeaderTextTile(
            title: language['exchangeRate'],
            value:
                "${NumberFormat.currency(symbol: "", decimalDigits: 1).format(double.parse(receipt.exchangeRate.toString()))} ${receipt.toCurrencyName}",
          ),
          _VoucherHeaderTextTile(
            title: language['exchangeAmount'],
            value:
                "${formatQuantity(double.parse(receipt.exchangeAmount.toString()))} ${receipt.toCurrencyName}",
            color: AppTheme.green,
          ),
          receipt.discount.toString().startsWith('0.0')
              ? SizedBox.shrink()
              : _VoucherHeaderTextTile(
                  title: language['discount'],
                  value:
                      "${formatQuantity(double.parse(receipt.discount.toString()))} ${receipt.toCurrencyName}",
                  color: AppTheme.red,
                ),
          receipt.fee.toString().startsWith('0.0')
              ? SizedBox.shrink()
              : _VoucherHeaderTextTile(
                  title: language['fee'],
                  value:
                      "${formatQuantity(double.parse(receipt.fee.toString()))} ${receipt.currencyName}",
                  color: AppTheme.black,
                ),
          _VoucherHeaderTextTile(
            title: language['name'],
            value: receipt.name ?? "",
          ),
          _VoucherHeaderTextTile(
            title: language['paymentMethod'],
            value: receipt.paymentMethodName ?? "",
          ),
          const SizedBox(height: 3),
        ],
      ),
    );
  }
}

class _VoucherHeaderTextTile extends StatelessWidget {
  _VoucherHeaderTextTile({
    required this.title,
    required this.value,
    this.color = AppTheme.black,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return (value == null || value.toString() == "0" || value.isEmpty || value.toString() == "0.0")
        ? SizedBox.shrink()
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
              GlobalText(text:
                  title,

                    fontFamily: 'nrt-reg',
                    color: AppTheme.grey_thin,
                    fontSize: 15,
                  ),

                const Spacer(),
      GlobalText(text:
                  value,

                    color: color,
                    fontFamily: "sf_med",
                    fontSize: 15,

                ),
              ],
            ),
          );
  }
}

class _VoucherItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GlobalText(text:
            'Items',
            fontSize: 20, fontFamily: 'nrt-reg', fontWeight: FontWeight.w500, color: AppTheme.black,
          ),
          const SizedBox(height: 20 * 0.4),
          // ...voucherDetails.items.map(
          //       (e) => _VoucherItem(
          //     title: e.item,
          //     subtitle: '${e.quantity}  x  ${e.currency}${e.price}',
          //     amount: e.subTotal,
          //     note: e.note,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _BottomVoucherInfo extends StatelessWidget {
  final ReceiptModule receipt;
  _BottomVoucherInfo({required this.receipt});
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              GlobalText(text:
                language['total'],
                fontSize: 18, fontFamily: 'nrt-reg', fontWeight: FontWeight.w500, color: AppTheme.black,
              ),
              const Spacer(),
              GlobalText(text:
                "${formatQuantity(double.parse(receipt.exchangeAmount.toString()))} ${receipt.toCurrencyName}",

                  fontWeight: FontWeight.bold,
                  color: AppTheme.black,
                  fontSize: 16,
                ),

            ],
          ),
          const SizedBox(height: 20 * 0.8),
          // GlobalText(text:
          //   receipt.description,
          //
          //     fontSize: 14,
          //     fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,
          //     color: AppTheme.grey_thin,
          //   ),
          // ),
          const SizedBox(height: 20),
          // SizedBox(
          //   width: double.infinity,
          //   height: 50,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: AppTheme.primary,
          //     ),
          //     onPressed: () {},
          //     child: GlobalText(text:
          //       'Receipt Document',
          //
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white.withOpacity(0.92),
          //         fontSize: 17,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class DashedLine extends StatelessWidget {
  const DashedLine({super.key, this.height = 1, this.color = Colors.black});
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.maxWidth;
        const dashWidth = 6.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (3 * dashWidth)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

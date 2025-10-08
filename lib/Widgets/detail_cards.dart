import 'package:x_express/Screens/Currency/Widets/currency_card.dart';
import 'package:x_express/Utils/exports.dart';

class DetailCard extends StatelessWidget {
  final title;
  final isSeeMore;
  final onTap;
  final column;
  final isSubtext;
  const DetailCard({this.column, this.title, this.onTap, this.isSeeMore = false, this.isSubtext = false});

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              GlobalText(
                text: title ?? "",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppTheme.black,
              ),
              Spacer(),
              isSeeMore
                  ? GestureDetector(
                      onTap: onTap,
                      child: GlobalText(
                        text: isSubtext ? language['document'] : language['seeDetail'],
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppTheme.blue,
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(8)),
          child: column,
        )
      ],
    );
  }
}

class RowData extends StatelessWidget {
  final title;
  final value;
  final bool isStart;
  final bool isLast;
  final color;
  final type;
  final statusChild;
  final currency;
  const RowData({
    Key? key,
    this.title,
    this.value,
    this.color = AppTheme.black,
    this.isLast = false,
    this.isStart = false,
    this.currency,
    this.statusChild,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(title);
    return (value.toString().isEmpty || value.toString().startsWith("0") || value == null || value.toString() == "null")
        ? SizedBox.shrink()
        : Column(
            children: [
              isStart ? SizedBox(height: 4) : SizedBox.shrink(),
              Row(
                children: [
                  GlobalText(
                    text: title ?? "",
                    fontSize: 15,
                    fontFamily: "nrt-reg",
                    color: AppTheme.grey_thin,
                  ),
                  Spacer(),
                  type == "status"
                      ? statusChild
                      : GlobalText(
                          text: type == 'currency'
                              ? "${NumberFormat.currency(symbol: "", locale: 'en_US', decimalDigits: 0).format(double.parse(value.toString()))} ${currency}"
                              : type == "date"
                                  ? DateFormat('dd-MM-yyyy').format(DateTime.parse(value.toString()))
                                  : type == "number"
                                      ? NumberFormat.decimalPatternDigits(decimalDigits: 0)
                                          .format(double.parse(value ?? "0"))
                                      : value ?? "-",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: "nrt-bold",
                          color: color,
                        )
                ],
              ),
              isLast ? SizedBox(height: 4) : SizedBox(height: 20)
            ],
          );
  }
}

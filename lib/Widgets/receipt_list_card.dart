import 'package:x_express/Utils/exports.dart';

class ReceiptListCard extends StatelessWidget {
  final child;
  const ReceiptListCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(

          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(12)),
          child: child,
        )
      ],
    );
  }
}

class ReceiptRowData extends StatelessWidget {
  final title;
  final value;
  final color;
  final bool isFirst;
  final bool isLast;
  const ReceiptRowData(
      {Key? key, this.title, this.value, this.isLast = false, this.isFirst = false, this.color = AppTheme.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(value);
    return value.toString().startsWith("0") ||value.toString().isEmpty||value.toString()=="null"
        ? SizedBox.shrink()
        : Column(
            children: [
              isFirst ? SizedBox(height: 3) : SizedBox.shrink(),
              Row(
                children: [
    GlobalText(text:title ?? title, fontSize: 15,  color: AppTheme.grey_thin),
                  Spacer(),
                  GlobalText(text:value ?? "", fontSize: 15, fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: color)
                ],
              ),
              isLast ? SizedBox(height: 3) : SizedBox(height: 20)
            ],
          );
  }
}

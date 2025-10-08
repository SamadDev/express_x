import 'package:x_express/Utils/exports.dart';

class OrderDetailCard extends StatelessWidget {
  final title;
  final isSeeMore;
  final onTap;
  final column1;
  final column2;
  const OrderDetailCard({this.column1, this.column2, this.title, this.onTap, this.isSeeMore = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              GlobalText(text:
                title,
                fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, fontSize: 16, color: AppTheme.black,
              ),
              Spacer(),
              isSeeMore
                  ? GestureDetector(
                      onTap: onTap,
                      child: GlobalText(text:
                        "see details",
                        fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, fontSize: 16, color: AppTheme.black
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
          decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [column1, Spacer(), column2],
          ),
        )
      ],
    );
  }
}

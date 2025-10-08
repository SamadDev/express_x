import 'package:x_express/Utils/exports.dart';
import 'package:intl/intl.dart';

class StatisticCard extends StatelessWidget {
  const StatisticCard({
    required this.title,
    this.value,
    this.type = '',
  });

  final String title;
  final String? value;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        Text(
          title ?? "",
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,
            color: AppTheme.grey_thin,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value == null
              ? ""
              : type == "number"
                  ? NumberFormat.currency(symbol: "").format(double.parse(value.toString()))
                  : value ?? "",
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'nrt-bold',fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

import 'package:x_express/Utils/exports.dart';

// class DeliveryStatus extends StatelessWidget {
//   final ShipmentModule? Shipment;
//   final orderId;
//   DeliveryStatus({this.orderId, this.Shipment});
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//         children: status.map((e) {
//       final isFirst = status.indexOf(e) == 0;
//       final isLast = status.indexOf(e) == status.length - 1;
//       return _DeliveryStatusItem(
//         title: e.title,
//         description: e.description ?? '',
//         date: e.date ?? '',
//         isFirst: isFirst,
//         isLast: isLast,
//       );
//     }).toList());
//   }
// }
//
// List status = [
//   _DeliveryStatusItem(
//     title: "ready to shipping. China",
//     description: "note",
//     date: "date",
//     isFirst: true,
//     isLast: false,
//   ),
//   _DeliveryStatusItem(
//     title: "ready to shipping. China",
//     description: "note",
//     date: "date",
//     isFirst: true,
//     isLast: false,
//   ),
//   _DeliveryStatusItem(
//     title: "ready to shipping. China",
//     description: "note",
//     date: "date",
//     isFirst: false,
//     isLast: false,
//   ),
//   _DeliveryStatusItem(
//     title: "ready to shipping. China",
//     description: "note",
//     date: "date",
//     isFirst: false,
//     isLast: false,
//   ),
//   _DeliveryStatusItem(
//     title: "ready to shipping. China",
//     description: "note",
//     date: "date",
//     isFirst: false,
//     isLast: false,
//   ),
// ];
//
// class _DeliveryStatusItem extends StatelessWidget {
//   const _DeliveryStatusItem({
//     required this.date,
//     required this.title,
//     required this.description,
//     this.isFirst = false,
//     this.isLast = false,
//   });
//
//   final String date;
//   final String title;
//   final String description;
//   final bool isFirst;
//   final bool isLast;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           width: isLast ? 40 : 70,
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               isLast
//                   ? Container(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(height: 20),
//                           Container(
//                             width: 30,
//                             height: 30,
//                             alignment: Alignment.center,
//                             padding: EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
//                             decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(90)),
//                             child: Image.asset(
//                               'assets/images/ship.png',
//                               height: 20,
//                               width: 20,
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           GlobalText(text:
//                             "dubai",
//                             fontSize: 14, fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: AppTheme.primary),
//                           )
//                         ],
//                       ),
//                     )
//                   : Container(
//                       child: CircleAvatar(
//                         backgroundColor: AppTheme.primary,
//                         radius: 4,
//                       ),
//                     ),
//               isLast
//                   ? SizedBox.shrink()
//                   : Expanded(
//                       child: Container(
//                         height: 1,
//                         width: 50,
//                         color: AppTheme.primary,
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

class LineWithPoint extends StatelessWidget {
  final Offset startPoint;
  final Offset endPoint;
  final city;
  final double middlePercentage;

  const LineWithPoint({
    required this.startPoint,
    required this.endPoint,
    required this.city,
    required this.middlePercentage,
  });

  @override
  Widget build(BuildContext context) {
    double xMiddle = (endPoint.dx - 25 - startPoint.dx) * middlePercentage + startPoint.dx;
    double xStart = (endPoint.dx - startPoint.dx) * 0 + startPoint.dx;
    double xEnd = (endPoint.dx - startPoint.dx) * 1 + startPoint.dx;

    return Stack(
      children: [
        Positioned(
          left: startPoint.dx,
          top: startPoint.dy,
          child: CustomPaint(
            painter: LinePainter(endPoint.dx - startPoint.dx),
          ),
        ),
        Positioned(
          left: xMiddle - 4,
          top: startPoint.dy - 35,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
                  decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(90)),
                  child: Image.asset(
                    'assets/images/ship.png',
                    height: 20,
                    width: 20,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        Positioned(
          left: (middlePercentage > 0.8 && city.toString().length > 7) ? xMiddle - 40 : xMiddle - 5,
          top: startPoint.dy - 35,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
                ),
                // SizedBox(height: 10),
                // Positioned(
                //   left: xMiddle - 50,
                //   child: GlobalText(text:
                //     city,
                //     fontSize: 14, fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: AppTheme.primary),
                //   ),
                // )
              ],
            ),
          ),
        ),
        Positioned(
          left: (middlePercentage > 0.8 && city.toString().length > 7) ? xMiddle - 40 : xMiddle - 5,
          bottom: startPoint.dy - 30,
          child: GlobalText(text:
            city,
            fontSize: 14, fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: AppTheme.primary,
          ),
        ),
        if (middlePercentage > 0) ...[
          Positioned(
            left: xStart - 4,
            top: startPoint.dy - 4,
            child: CircleAvatar(
              backgroundColor: AppTheme.primary,
              radius: 4,
            ),
          )
        ],
        if (middlePercentage < 1) ...[
          Positioned(
            left: xEnd - 4,
            top: startPoint.dy - 4,
            child: CircleAvatar(
              backgroundColor: AppTheme.primary,
              radius: 4,
            ),
          )
        ]
      ],
    );
  }
}

class LinePainter extends CustomPainter {
  final double width;

  LinePainter(this.width);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, 0),
      Offset(width, 0),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

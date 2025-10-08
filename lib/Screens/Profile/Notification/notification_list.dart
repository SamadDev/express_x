import 'package:x_express/Screens/Order/OrderDetail/orderDetail.dart';
import 'package:x_express/Screens/Receipt/receipt_detail.dart';
import 'package:x_express/Screens/Shipment/ShipmentDetail/shipment_detail.dart';
import 'package:x_express/Utils/exports.dart';
import 'package:x_express/Utils/pagination.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(DateTime.now());
    final language = Provider.of<Language>(context, listen: false).getWords;
    final notification = Provider.of<NotificationListService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(language['notification']),
      ),
      body: ChangeNotifierProvider(
        create: (_) => PaginationProvider<NotificationListModule>(
            fetchItems: (page) => notification.getNotificationList(page: page, context: context)),
        child: PaginatedListView<NotificationListModule>(
          itemBuilder: (context, notification) => _NotificationCard(notification: notification),
          loadingBuilder: (context) => ShimmerListCard(),
          emptyBuilder: (context) => EmptyScreen(),
        ),
      ),
    );
    //   Scaffold(
    //   appBar: AppBar(
    //     elevation: 0,
    //     toolbarHeight: 70,
    //     title: Text(
    //       language.getWords['notification'],
    //     ),
    //   ),
    //   body: FutureBuilder(
    //     future: notification.getNotificationList(context),
    //     builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
    //         ? Column(children: List.generate(4, (index) => ShimmerOrderCard()).toList())
    //         : Consumer<NotificationListService>(
    //             builder: (ctx, data, _) => AnimationLimiter(
    //               child: data.notificationList.isEmpty
    //                   ? EmptyScreen()
    //                   : ListView.builder(
    //                       itemCount: notification.notificationList.length,
    //                       itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
    //                         position: 4,
    //                         duration: const Duration(milliseconds: 0),
    //                         child: SlideAnimation(
    //                           verticalOffset: 70.0,
    //                           child: FadeInAnimation(
    //                             child: _NotificationCard(notification: notification.notificationList[i]),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //             ),
    //           ),
    //   ),
    // );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationListModule? notification;
  _NotificationCard({this.notification});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        notificationNav(context: context, id: notification!.refId!, screen: notification!.action!);
      },
      child: Card(
        color: AppTheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 0,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.card,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:
                          // notification!.nType.toString() == '1' ?
                          Icon(
                        Icons.notifications,
                        color: AppTheme.primary,
                        size: 25,
                      )
                      // : notification!.nType.toString() == "3"
                      //     ? Icon(
                      //         Icons.link,
                      //         color: AppTheme.primary,
                      //         size: 25,
                      //       )
                      //     : Image.asset(
                      //         'assets/icons/order.png',
                      //         color: AppTheme.primary,
                      //         height: 25,
                      //         width: 25,
                      //       )
                      ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: GlobalText(
                              text: notification!.title ?? "",
                              maxLines: 3,
                              fontFamily: 'nrt-reg',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppTheme.black,
                            )),
                            GlobalText(
                              text:
                                  timeago.format(DateTime.parse(notification!.dateTime.toString()), locale: 'en_short'),
                              fontSize: 13,
                              fontFamily: 'sf_normal',
                              color: AppTheme.black,
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        GlobalText(
                          text: 'General',
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              height: 16,
              color: AppTheme.card,
            ),
            Padding(
              padding: EdgeInsets.all(14).copyWith(top: 4),
              child: GlobalText(
                text: notification!.body!,
                fontSize: 13,
                color: AppTheme.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void notificationNav({screen, context, id}) {
  if (screen == "order") {
    navigator_route(context: context, page: OrderDetailTapbar(orderId: id));
  } else if (screen == "receipt") {
    navigator_route(context: context, page: VoucherDetailsPage(receipt: id));
  } else if (screen == "shipment") {
    navigator_route(context: context, page: ShipmentDetailScreen(shipmentId: id));
  } else if (screen == "receive") {
    navigator_route(context: context, page: VoucherDetailsPage(receipt: id));
  }
}

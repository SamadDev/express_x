import 'package:x_express/Utils/exports.dart';

class OpenOrderServices with ChangeNotifier {
  List<OrderModule> _orderList = [];
  List<OrderModule> get orderList => _orderList;
  List openOrderItems = [];
  bool itemsLoading = false;

  Future<void> getOpenOrder({context, customerId}) async {
    try {
      var data = await Request.reqGet('tms/orders/$customerId/open-orders');
      _orderList = data.map<OrderModule>((e) => OrderModule.fromJson(e)).toList();
      if (_orderList.isEmpty) {
        navigator_route_pop(context: context);
      }
      notifyListeners();
    } catch (e) {
      print("get order error is: $e");
    }
  }

  Future<void> getOrderItems({context, orderId}) async {
    try {
      itemsLoading = true;
      var data = await Request.reqGet("tms/orders/$orderId/open-order-items");
      print(data);
      openOrderItems = data;
      print(openOrderItems);
      itemsLoading = false;
      notifyListeners();
    } catch (e) {
      itemsLoading = false;
      print("get order error is: $e");
    }
  }
}

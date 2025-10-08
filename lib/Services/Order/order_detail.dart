import 'package:x_express/Utils/exports.dart';

class OrderDetailServices with ChangeNotifier {
  var orderDetail;

  Future<void> getDetailOrder({status = false, orderId}) async {
    print(orderId);
    try {
      orderDetail = await Request.reqGet('tms/orders/$orderId/view');
      notifyListeners();
    } catch (e) {
      print("error is: $e");
    }
  }
}

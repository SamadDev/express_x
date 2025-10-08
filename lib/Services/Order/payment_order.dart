import 'package:x_express/Modules/Order/payment_detail.dart';
import 'package:x_express/Utils/exports.dart';

class PaymentOrderService with ChangeNotifier {
  List<OrderPaymentModule> paymentOrder = [];

  Future<void> getPaymentOrder(orderId) async {
    try {
      var data = await Request.reqGet('tms/orders/$orderId/payments');
      paymentOrder = data.map<OrderPaymentModule>((e) => OrderPaymentModule.fromJson(e)).toList();
      print(paymentOrder.length);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}

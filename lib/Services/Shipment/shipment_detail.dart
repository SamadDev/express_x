import 'dart:developer';

import 'package:x_express/Utils/exports.dart';

class ShipmentDetailServices with ChangeNotifier {
  var shipmentDetail;
  bool loading = false;

  Future<void> getDetailShipment({status = false, shipmentId}) async {
    try {
      loading = true;
      shipmentDetail = await Request.reqGet('tms/shipments/$shipmentId/view');
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      print("error is: $e");
    }
  }

  bool _isStart = false;
  bool get isStart => _isStart;

  void setLoading(bool value) {
    _isStart = value;
    notifyListeners();
  }
  //tabBar
  // int _selectedIndex = 0;
  // int get selectedIndex => _selectedIndex;
  // void updateSelectedIndex(int index) {
  //   _selectedIndex = index;
  //   notifyListeners();
  // }
}

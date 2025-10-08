import 'package:x_express/Modules/Shimpent/shipment_status.dart';
import 'package:x_express/Utils/exports.dart';

class ShipmentStatusService with ChangeNotifier {
  List<ShipmentSatesModule> existStateFilterList = [];
  List<ShipmentSatesModule> shipmentStatus = [];
  late int shipmentId;

  Future<void> getStatusShipment() async {
    try {
      if (shipmentStatus.isEmpty) {
        var data = await Request.reqGet('tms/shipments/statuses');

        shipmentStatus = data.map<ShipmentSatesModule>((e) => ShipmentSatesModule.fromJson(e)).toList();
        shipmentStatus.removeWhere((element) => element.id == 1);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  ///Filter state list
  void addItem(item) {
    existStateFilterList.add(ShipmentSatesModule(title: item.title, check: item.check, id: item.id));
    notifyListeners();
  }

  void removeItem(title) {
    existStateFilterList.removeWhere((element) => element.title == title);
    notifyListeners();
  }

  void removeAll() {
    existStateFilterList = [];
    notifyListeners();
  }

  void setShipmenId(value) {
    shipmentId = value;
    print("shipmentId$value");
    notifyListeners();
  }
}

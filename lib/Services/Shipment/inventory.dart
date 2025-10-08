import 'package:x_express/Modules/Shimpent/inventory.dart';
import 'package:x_express/Utils/exports.dart';

class InventoryListDetailService with ChangeNotifier {
  List<InventoryListDetailModule> _inventoryList = [];
  List<ShipmentDashboardModule> _inventoryShipmentList = [];
  List<InventoryListDetailModule> get inventoryList => _inventoryList;
  List<ShipmentDashboardModule> get inventoryShipmentList => _inventoryShipmentList;

  var perPage = 15;
  var pageNumber = 0;
  bool isLoading = false;

  Future<void> getInventory({context, isRefresh = false, text}) async {
    try {
      if (isRefresh) {
        pageNumber = 0;
        _inventoryList = [];
      }
      pageNumber += 1;
      var data = await Request.reqGet('tms/reports/inventory?searchText=$text');
      _inventoryList = data.map<InventoryListDetailModule>((e) => InventoryListDetailModule.fromJson(e)).toList();

      notifyListeners();
    } catch (e) {
      isLoading = false;
      print("get inventory error is: $e");
    }
  }

  Future<void> getInventoryShipment({context, isRefresh = false, text}) async {
    try {
      var data = await Request.reqGet('tms/shipments/details?searchText=$text');
      _inventoryShipmentList = data.map<ShipmentDashboardModule>((e) => ShipmentDashboardModule.fromJson(e)).toList();

      notifyListeners();
    } catch (e) {
      isLoading = false;
      print("get inventory error is: $e");
    }
  }

  void changeState() {
    isLoading = !isLoading;
    print("isLoading is: $isLoading");
    notifyListeners();
  }
}

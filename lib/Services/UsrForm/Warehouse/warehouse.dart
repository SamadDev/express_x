import 'package:x_express/Utils/exports.dart';

class WarehouseService with ChangeNotifier {
  List<WarehouseModule> _warehouseList = [];
  List<WarehouseModule> get warehouseList => _warehouseList;
bool isLoading=false;
  Future<void> getWarehouse() async {
    try {
      if(_warehouseList.isNotEmpty)return;
      isLoading=true;
      var data = await Request.reqGet('wms/warehouses');
      _warehouseList = data.map<WarehouseModule>((e) => WarehouseModule.fromJson(e)).toList();
      isLoading=false;
      print("warehouse length is: ${warehouseList.length}");
      notifyListeners();
    } catch (e) {
      isLoading=false;
      print("get warehouse error is: $e");
    }
  }
}

import 'package:x_express/Modules/User%20From/Customers/supplier.dart';
import 'package:x_express/Utils/exports.dart';

class SupplierService with ChangeNotifier {
  List<SupplierModule> _supplierList = [];
  var supplierDateData;
  List<SupplierModule> get supplierList => _supplierList;

  Future<void> getSupplier({customer}) async {
    try {
      var data = await Request.reqGet('cim/customers/$customer/suppliers');
      print("supplier data is: $data");
      supplierDateData = data;
      _supplierList = data.map<SupplierModule>((e) => SupplierModule.fromJson(e)).toList();
      notifyListeners();
    } catch (e) {
      print("get supplier error is: $e");
    }
  }
}

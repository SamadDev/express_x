import 'package:x_express/Utils/exports.dart';

class CustomersService with ChangeNotifier {
  List<CustomerModule> _customersList = [];
  var customerData;
  List<CustomerModule> get customersList => _customersList;

  Future<void> getCustomers({customer}) async {
    try {
      var data = await Request.reqGet('cim/customers/filter/?filter=$customer');
      customerData = data;
      print("customer data is: ${data}");
      _customersList = data.map<CustomerModule>((e) => CustomerModule.fromJson(e)).toList();
      print("customer data is: ${_customersList[0]}");
      print(_customersList.length);
      notifyListeners();
    } catch (e) {
      print("get customers error is: $e");
    }
  }
}

import 'package:x_express/Utils/exports.dart';


class OrderStatusService with ChangeNotifier {
  List<SatesModule> existStateFilterList = [];
  List<SatesModule> orderStatus = [];

  Future<void> getStatusOrder() async {
    try {
      if (orderStatus.isEmpty) {
        var data = await Request.reqGet('tms/orders/statuses');
        orderStatus = data.map<SatesModule>((e) => SatesModule.fromJson(e)).toList();

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  ///Filter state list
  void addItem(item) {
    existStateFilterList.add(SatesModule(title: item.title, check: item.check, id: item.id));
    notifyListeners();
  }

  void addAll() {
    existStateFilterList.addAll(orderStatus);
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
}

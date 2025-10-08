import 'package:x_express/Utils/exports.dart';

class OrderServices with ChangeNotifier {
  List<OrderModule> _orderList = [];
  List<OrderModule> _orderFilterList = [];
  List<OrderModule> _orderSearchList = [];
  
  List<OrderModule> get orderList => _orderList;
  List<OrderModule> get orderFilterList => _orderFilterList;
  List<OrderModule> get orderSearchList => _orderSearchList;


  var pageNumber = 0;
  var pageNumberSearch=0;
  var pageNumberFilter = 0;
  bool isLoading = false;
  bool isRefresh = false;

  Future<void> getOrder({context, isPagination = true, isRefresh = false, statusId, type}) async {
    try {

      if (isRefresh || isPagination == false) {

        pageNumber = 0;
        _orderList = [];
      }
      pageNumber += 1;

      var data = await Request.reqGet('tms/orders/list?statusId=$statusId&pageNumber=$pageNumber&pageSize=10');
      List<OrderModule> new_orderList = data.map<OrderModule>((e) => OrderModule.fromJson(e)).toList();
      for (var newItem in new_orderList) {
        bool isDuplicate = _orderList.any((existingItem) => existingItem.id == newItem.id);
        if (!isDuplicate) {
          _orderList.add(newItem);
        }
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isRefresh = false;
      print("get order error is: $e");
    }
  }



  Future<void> getOrderSearch({isPagination = true, isRefresh = false, text}) async {
    try {
      if (isRefresh || isPagination == false) {
        pageNumberSearch = 0;
        _orderSearchList = [];
      }
      if (isPagination || _orderSearchList.isEmpty) {
        pageNumberSearch += 1;
        var data = await Request.reqGet('tms/orders/list?searchText=$text&pageNumber=$pageNumberSearch&pageSize=10');
        print("response is: $data");
        List<OrderModule> new_orderList = data.map<OrderModule>((e) => OrderModule.fromJson(e)).toList();
        for (var newItem in new_orderList) {
          bool isDuplicate = _orderSearchList.any((existingItem) => existingItem.id == newItem.id);
          if (!isDuplicate) {
            _orderSearchList.add(newItem);
          }
        }
        print(orderSearchList.length);
      }
      notifyListeners();
    } catch (e) {
      print("get order error is: $e");
    }
  }
  

  Future<void> getOrderFilterList(
      {context, isPagination = true, isRefresh = false, statusId, orderNumber, e_date, s_date}) async {
    try {
      if (isRefresh || isPagination == false) {
        pageNumberFilter = 0;
        _orderFilterList = [];
      }
      statusId =
          statusId.isEmpty ? "" : statusId.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(" ", "");
      pageNumberFilter += 1;
      var data = await Request.reqGet(
          'tms/orders/list?orderNo=$orderNumber&FromDate=$s_date&toDate=$e_date&statuses=$statusId&pageNumber=$pageNumberFilter&pageSize=12');
      print("order filter result is: $data");
      _orderFilterList = data.map<OrderModule>((e) => OrderModule.fromJson(e)).toList();
    } catch (e) {
      print("order filter error is: $e");
    }

    notifyListeners();
  }

  void changeState() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void onRefreshLoading() {
    isRefresh = !isRefresh;
    notifyListeners();
  }
}



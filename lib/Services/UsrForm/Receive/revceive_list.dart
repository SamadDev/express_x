import 'package:x_express/Modules/User%20From/Order/order_receive.dart';
import 'package:x_express/Modules/User%20From/Order/order_receive_by_id.dart';
import 'package:x_express/Utils/exports.dart';

class ReceiveServices with ChangeNotifier {
  List<OrderReceiveModule> _orderReceiveList = [];
  List<OrderReceiveModule> _orderFilterList = [];
  List<OrderReceiveModule> _receiveSearchList = [];
  var updateReceiveData;
  OrderReceiveByIdModule? receiveDataModule;
  List<OrderReceiveModule> get orderReceiveList => _orderReceiveList;
  List<OrderReceiveModule> get orderFilterList => _orderFilterList;
  List<OrderReceiveModule> get receiveSearchList => _receiveSearchList;
  bool updateLoading = false;

  var perPage = 15;
  var pageNumber = 0;
  var pageNumberFilter = 0;
  var pageNumberSearch = 0;
  bool isLoading = false;
  bool isRefresh = false;

  Future<void> getOrderReceives({context, isPagination = true, isRefresh = false, statusId = 0}) async {
    try {
      if (isRefresh || isPagination == false) {
        pageNumber = 0;
        _orderReceiveList = [];
      }
      pageNumber += 1;
      var data = await Request.reqGet('tms/order-receives/list?statusId=$statusId&pageNumber=$pageNumber&pageSize=10');

      List<OrderReceiveModule> newReceivesList =
          data.map<OrderReceiveModule>((e) => OrderReceiveModule.fromJson(e)).toList();

      for (var newItem in newReceivesList) {
        bool isDuplicate = _orderReceiveList.any((existingItem) => existingItem.id == newItem.id);
        if (!isDuplicate) {
          _orderReceiveList.add(newItem);
        }
      }

      notifyListeners();
    } catch (e) {
      isLoading = false;
      isRefresh = false;
      print("get order error is: $e");
    }
  }

  Future<void> getReceivesSearch({context, isPagination = true, isRefresh = false, text}) async {
    try {
      if (isRefresh || isPagination == false) {
        pageNumberSearch = 0;
        _receiveSearchList = [];
      }
      pageNumberSearch += 1;
      var data =
          await Request.reqGet('tms/order-receives/list?searchText=$text&pageNumber=$pageNumberSearch&pageSize=10');
      List<OrderReceiveModule> newReceivesList =
          data.map<OrderReceiveModule>((e) => OrderReceiveModule.fromJson(e)).toList();

      for (var newItem in newReceivesList) {
        bool isDuplicate = _receiveSearchList.any((existingItem) => existingItem.id == newItem.id);
        if (!isDuplicate) {
          _receiveSearchList.add(newItem);
        }
      }
      notifyListeners();
    } catch (e) {
      print("get order error is: $e");
    }
  }

  Future<void> getReceiveOrderWithId({context, id}) async {
    print(id);
    try {
      updateReceiveData = await Request.reqGet('tms/order-receives/$id');
      print("receiveDataModule data is: $updateReceiveData");
      receiveDataModule = OrderReceiveByIdModule.fromJson(updateReceiveData);

      notifyListeners();
    } catch (e) {
      print("get Receives by id error is: $e");
    }
  }

  Future<void> getOrderReceivesFilterList(
      {context, isPagination = true, isRefresh = false, receiveNo, orderNumber, e_date, s_date, customer}) async {
    try {
      print(pageNumberFilter);
      if (isRefresh || isPagination == false) {
        pageNumberFilter = 0;
        _orderFilterList = [];
      }
      pageNumberFilter += 1;
      var data = await Request.reqGet(
          'tms/order-receives/list?refNo=$orderNumber&customerId=$customer&warehouseId=$warehouseValue&receiveNo=$receiveNo&fromDate=$s_date&toDate=$e_date&pageNumber=$pageNumberFilter&pageSize=10');
      List<OrderReceiveModule> newReceivesList =
          data.map<OrderReceiveModule>((e) => OrderReceiveModule.fromJson(e)).toList();
      for (var newItem in newReceivesList) {
        bool isDuplicate = _orderFilterList.any((existingItem) => existingItem.id == newItem.id);
        if (!isDuplicate) {
          _orderFilterList.add(newItem);
        }
      }
    } catch (e) {
      print("error is: $e");
      isLoading = false;
    }

    notifyListeners();
  }

  String warehouseValue = '0';
  void setWarehouseValue(value) {
    warehouseValue = value;
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

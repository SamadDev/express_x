import 'package:x_express/Modules/User%20From/Order/order_user_data.dart';
import 'package:x_express/Utils/exports.dart';

class OrderUserServices with ChangeNotifier {
  List<OrderModule> _orderList = [];
  List<OrderModule> _orderFilterList = [];
  List<OrderModule> get orderList => _orderList;
  List<OrderModule> get orderFilterList => _orderFilterList;
  var updateOrderData;
  late OrderUserModule updateOrderModuleData;

  String markValue = '';
  String currencyValue = '';
  String supplierValue = '';
  String orderId = "0";
  List items = [];
  bool loading = false;

  var perPage = 15;
  var pageNumber = 0;
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
      var data = await Request.reqGet('tms/orders/list?pageNumber=$pageNumber&pageSize=10');
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

  Future<void> getOrderWithId({context, id}) async {
    print("order is is: ${id.id}");
    try {
      updateOrderData = await Request.reqGet('tms/orders/${id.id}');
      updateOrderModuleData = OrderUserModule.fromJson(updateOrderData);
      notifyListeners();
    } catch (e) {
      print("get Receives by id error is: $e");
    }
  }

  Future<void> postOrder({data, context}) async {
    Dio dio = Dio();
    FormData formData = FormData.fromMap({"order": json.encode(data)});
    print("response value is: $data");
    try {
      LoadingDialog(context);
      loading = true;
      final res = await dio.post(
        "$domain" + "tms/orders",
        options: Options(headers: {"Authorization": "Bearer ${Auth.token}", "userType": "mobile", "language": "en"}),
        data: formData,
      );
      print(res.statusCode.toString());
      LoadingDialog(context);
      navigator_route(context: context, page: NavigationUserScreen(page: 1));
      notifyListeners();
    } catch (error) {
      print(error);
      loading = false;
    }
  }

  Future<void> updateOrderReceive({data, context}) async {
    print(data);
    Dio dio = Dio();
    FormData formData = FormData.fromMap({"order": json.encode(data)});
    print("response value is: $data");
    try {
      LoadingDialog(context);
      loading = true;
      print(loading);
      final result = await dio.put(
        "$domain" + "tms/orders",
        options: Options(headers: {"Authorization": "Bearer ${Auth.token}", "userType": "mobile", "language": "en"}),
        data: formData,
      );
      print("result is: $result");
      LoadingDialog(context);
      navigator_route(context: context, page: NavigationUserScreen(page: 1));
      notifyListeners();
    } catch (error) {
      print(error);
      loading = false;
    }
  }

  Future<void> getOrderFilterList(
      {context,
      isPagination = true,
      isRefresh = false,
      statusId,
      customerId,
      refNo,
      orderNumber,
      e_date,
      s_date}) async {
    try {
      if (isRefresh || isPagination == false) {
        pageNumberFilter = 0;
        _orderFilterList = [];
      }
      pageNumberFilter += 1;
      var data = await Request.reqGet(
          'tms/orders/list?orderNo=$orderNumber&refNo=$refNo&customerId=$customerId&FromDate=$s_date&toDate=$e_date&statuses=$statusId&pageNumber=$pageNumberFilter&pageSize=12');
      List new_orderList = data.map<OrderModule>((e) => OrderModule.fromJson(e)).toList();
      for (var newItem in new_orderList) {
        bool isDuplicate = _orderFilterList.any((existingItem) => existingItem.id == newItem.id);
        if (!isDuplicate) {
          _orderFilterList.add(newItem);
        }
      }
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

  void setOrderMarkValue(value) {
    markValue = value;
    notifyListeners();
  }

  void setOrderCurrencyValue(value) {
    currencyValue = value;
    notifyListeners();
  }

  void setOrderSupplierValue(value) {
    supplierValue = value;
    notifyListeners();
  }

  void addItems(value) {
    items.add(value);
    notifyListeners();
  }

  void setItems(itemsList) {
    items = itemsList;
    notifyListeners();
  }

  void setOrderId(value) {
    orderId = value;
    notifyListeners();
  }

  void removeItems(value) {
    final index = items.indexWhere((element) => element['itemCode'] == value.toString());
    print(index);
    print("index of :$index");
    items.removeAt(index);
    notifyListeners();
  }
}

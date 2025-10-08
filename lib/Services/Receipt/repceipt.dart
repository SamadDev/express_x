import 'package:x_express/Utils/exports.dart';

class ReceiptService with ChangeNotifier {
  List<ReceiptModule> receiptList = [];
  List<ReceiptModule> receiptSearchList = [];
  List<ReceiptModule> receiptListFilter = [];
  var pageNumberFilter = 0;
  var pageNumberSearch = 0;
  var pageNumber = 0;
  bool isLoading = false;
  bool isRefresh = false;

  Future<void> getReceipt(
      {context,
      isPagination = true,
      isRefresh = false,
      s_date = '',
      e_date = '',
      toCurrency = "0",
      docNo = '',
      currencyType = ''}) async {
    try {
      if (isRefresh || isPagination == false) {
        pageNumber = 0;
        receiptList = [];
      }
      pageNumber += 1;
      var data = await Request.reqGet(
          'fms/journals/list?typeId=1&toCurrencyId=$toCurrency&docNo=$docNo&fromDate=$s_date&toDate=$e_date&pageNumber=$pageNumber&pageSize=10');
      List<ReceiptModule> newReceiptList = data.map<ReceiptModule>((e) => ReceiptModule.fromJson(e)).toList();
      for (var newItem in newReceiptList) {
        bool isDuplicate = receiptList.any((existingItem) => existingItem.id == newItem.id);
        if (!isDuplicate) {
          receiptList.add(newItem);
        }
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isRefresh = false;
      print("get order error is: $e");
    }
  }

  Future<void> getSearchReceipt({text, isPagination = true, isRefresh = false}) async {
    try {
      if (isRefresh || isPagination == false) {
        pageNumberSearch = 0;
        receiptSearchList = [];
      }
      var data = await Request.reqGet('fms/journals/list?typeId=1&searchText=$text&pageNumber=$pageNumberSearch&pageSize=10');
      List<ReceiptModule> newReceiptList = data.map<ReceiptModule>((e) => ReceiptModule.fromJson(e)).toList();
      for (var newItem in newReceiptList) {
        bool isDuplicate = receiptSearchList.any((existingItem) => existingItem.id == newItem.id);
        if (!isDuplicate) {
          receiptSearchList.add(newItem);
        }
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isRefresh = false;
      print("get order error is: $e");
    }
  }

  Future<void> getReceiptFilter(
      {context,
      isPagination = true,
      isRefresh = false,
      s_date = '',
      e_date = '',
      toCurrency = "0",
      docNo = '',
      currencyType = ''}) async {
    try {
      if (isRefresh || isPagination == true) {
        pageNumberFilter = 0;
        receiptListFilter = [];
      }
      pageNumberFilter += 1;
      var data = await Request.reqGet(
          'fms/journals/list?typeId=1&toCurrencyId=$toCurrency&docNo=$docNo&fromDate=$s_date&toDate=$e_date&pageNumber=$pageNumberFilter&pageSize=10');

      List<ReceiptModule> newReceiptList = data.map<ReceiptModule>((e) => ReceiptModule.fromJson(e)).toList();
      for (var newItem in newReceiptList) {
        bool isDuplicate = receiptListFilter.any((existingItem) => existingItem.id == newItem.id);
        if (!isDuplicate) {
          receiptListFilter.add(newItem);
        }
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print("get order error is: $e");
    }
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

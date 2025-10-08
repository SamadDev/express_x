import 'package:x_express/Modules/Currency/currency.dart';
import 'package:x_express/Utils/exports.dart';

class CurrencyService with ChangeNotifier {
  List<CurrencyModule> _currencyList = [];
  List<CurrencyModule> _currencyFilterList = [];
  List<CurrencyModule> get currencyList => _currencyList;
  List<CurrencyModule> get currencyFilterList => _currencyFilterList;

  var perPage = 15;
  var pageNumber = 0;
  var pageNumberFilter = 0;
  bool isLoading = false;

  Future<void> getCurrency({context, isPagination = true, isRefresh = false, statusId}) async {
    try {
      if (isRefresh || isPagination == false) {
        pageNumber = 0;
        _currencyList = [];
      }
      pageNumber += 1;
      var data = await Request.reqGet('shared/currencies/rates?pageNumber=$pageNumber&pageSize=7');
      List<CurrencyModule> new_currencyList = data.map<CurrencyModule>((e) => CurrencyModule.fromJson(e)).toList();
      for (var newItem in new_currencyList) {
        bool isDuplicate = _currencyList.any((existingItem) => existingItem.id == newItem.id);
        if (!isDuplicate) {
          _currencyList.add(newItem);
        }
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print("get currency error is: $e");
    }
  }

  Future<void> getCurrencyFilterList(
      {context, isPagination = true, isRefresh = false, statusId, orderNumber, e_date, s_date, currency}) async {
    try {
      if (isRefresh || isPagination == false) {
        pageNumberFilter = 0;
        _currencyFilterList = [];
      }
      pageNumberFilter += 1;
      var data = await Request.reqGet(
          'shared/currencies/rates?FromDate=$s_date&toDate=$e_date&currencyType=$currency&pageNumber=$pageNumberFilter&pageSize=12');
      print("value is: $data");
      _currencyFilterList = data.map<CurrencyModule>((e) => CurrencyModule.fromJson(e)).toList();
    } catch (e) {
      print("error is: $e");
    }

    notifyListeners();
  }

  void changeState() {
    isLoading = !isLoading;
    print("isLoading is: $isLoading");
    notifyListeners();
  }
}

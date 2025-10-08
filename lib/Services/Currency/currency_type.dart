import 'package:x_express/Modules/Currency/currency_type.dart';
import 'package:x_express/Utils/exports.dart';

class CurrencyTypeService with ChangeNotifier {
  List<CurrencyTypeModule> currencyTypeList = [];
  List<CurrencyTypeModule> existCurrencyList = [];

  Future<void> getCurrencyType() async {
    try {
      var data = await Request.reqGet('shared/currencies');
      currencyTypeList = data.map<CurrencyTypeModule>((e) => CurrencyTypeModule.fromJson(e)).toList();
      currencyTypeList.insert(0, CurrencyTypeModule(name: "All", id: 0));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  ///Filter state list
  void addItem(item) {
    existCurrencyList.clear();
    existCurrencyList.add(item);
    notifyListeners();
  }

  void addAll() {
    existCurrencyList.clear();
    existCurrencyList.addAll(currencyTypeList);
    notifyListeners();
  }

  void removeAll() {
    existCurrencyList.clear();
    notifyListeners();
  }

  void removeItem(id) {
    existCurrencyList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
